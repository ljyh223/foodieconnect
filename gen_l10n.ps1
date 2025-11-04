$modules = @("app", "auth", "chat", "restaurant", "review", "setting", "staff","profile")

foreach ($m in $modules) {
  $arbPath = "lib/l10n/$m"
  if (!(Test-Path $arbPath)) {
    Write-Host "⚠️  Skip ${m}: $arbPath not found" -ForegroundColor Yellow
    continue
  }

  Write-Host "Generating localization for $m..."
  $className = ($m.Substring(0,1).ToUpper() + $m.Substring(1) + "Localizations")

  flutter gen-l10n `
    --arb-dir=$arbPath `
    --template-arb-file=$m`_en.arb `
    --output-dir=lib/generated/$m `
    --output-localization-file=${m}_localizations.dart `
    --output-class=$className `
    --format
}
