
#!/bin/bash
set -Eeuo pipefail

BACKUP_DIR="/var/backups/linux-infrastructure"
BACKUP="$(find "$BACKUP_DIR" -maxdepth 1 -type f -name 'infra01-config-*.tar.gz' -printf '%T@ %p\n' | sort -nr | head -n 1 | cut -d' ' -f2-)"

if [[ -z "$BACKUP" || ! -f "$BACKUP" ]]; then
    echo "ERROR: No backup archive found."
    exit 1
fi

TEST_DIR="$(mktemp -d)"
RESTORED_FILE="$TEST_DIR/etc/rsyslog.conf"

trap 'rm -rf "$TEST_DIR"' EXIT

echo
echo "=================================================="
echo "       MILESTONE 13: DISASTER RECOVERY"
echo "=================================================="

echo
echo "[1/4] BACKUP INFORMATION"
echo "Backup file : $(basename "$BACKUP")"
echo "Backup size : $(du -h "$BACKUP" | cut -f1)"
echo "Created     : $(stat -c '%y' "$BACKUP" | cut -d. -f1)"

echo
echo "[2/4] BACKUP CONTENTS"
if tar -tzf "$BACKUP" > "$TEST_DIR/contents.txt"; then
    echo "Archive integrity : PASS"
    echo "Total entries     : $(wc -l < "$TEST_DIR/contents.txt")"
    echo
    echo "Configuration areas included:"
    grep -E '^etc/(rsyslog|prometheus|grafana|bind|systemd/system)(/|$)' \
        "$TEST_DIR/contents.txt" | head -20 || true
    echo "... (showing up to 20 matching entries)"
else
    echo "Archive integrity : FAIL"
    exit 1
fi

echo
echo "[3/4] RESTORING CONFIGURATION"
tar -xzf "$BACKUP" -C "$TEST_DIR" etc/rsyslog.conf
test -s "$RESTORED_FILE"
echo "Recovered file : etc/rsyslog.conf"
echo "Destination    : Temporary recovery directory"
echo "Recovery status: PASS"

echo
echo "[4/4] VERIFYING RECOVERY"
if cmp -s /etc/rsyslog.conf "$RESTORED_FILE"; then
    echo "Comparison     : PASS"
    echo "Result         : Recovered file matches live configuration"
else
    echo "Comparison     : DIFFERENT"
    echo "Result         : Live configuration differs from this backup"
    echo "Note           : This may be due to legitimate changes since backup"
    exit 1
fi

echo
echo "=================================================="
echo " RESULT: ALL DISASTER RECOVERY CHECKS PASSED"
echo "=================================================="
echo "Safety: Live configuration was not modified."
echo
