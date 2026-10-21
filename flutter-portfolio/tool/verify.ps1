$ErrorActionPreference = 'Stop'
Push-Location (Split-Path -Parent $PSScriptRoot)
try {
    dart format --output=none --set-exit-if-changed lib test
    if ($LASTEXITCODE -ne 0) { throw 'Formatting failed.' }
    flutter analyze --no-pub
    if ($LASTEXITCODE -ne 0) { throw 'Analysis failed.' }
    flutter test --no-pub
    if ($LASTEXITCODE -ne 0) { throw 'Tests failed.' }
    flutter build web --release --wasm --no-pub
    if ($LASTEXITCODE -ne 0) { throw 'Web build failed.' }
} finally {
    Pop-Location
}
