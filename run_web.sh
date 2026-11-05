#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
FLUTTER_BIN="${FLUTTER_BIN:-$(command -v flutter || true)}"
if [[ -z "$FLUTTER_BIN" && -x /home/khanh/development/flutter/bin/flutter ]]; then
  FLUTTER_BIN=/home/khanh/development/flutter/bin/flutter
fi
if [[ -z "$FLUTTER_BIN" ]]; then
  echo 'Set FLUTTER_BIN to your Flutter executable.' >&2
  exit 1
fi
exec "$FLUTTER_BIN" run -d web-server --web-hostname 0.0.0.0 --web-port "${PORT:-8080}" "$@"
