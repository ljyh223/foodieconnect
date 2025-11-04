#!/bin/bash
modules=("app" "auth" "chat" "restaurant" "review" "settings" "staff")

for m in "${modules[@]}"; do
  echo "Generating localization for $m..."
  flutter gen-l10n --config lib/$m/l10n/l10n.yaml
done
