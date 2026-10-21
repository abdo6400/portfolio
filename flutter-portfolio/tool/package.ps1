$ErrorActionPreference = 'Stop'
$projectRoot = [System.IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot))
$outputRoot = [System.IO.Path]::GetFullPath((Join-Path $projectRoot '.vercel/output'))
$expectedRoot = Join-Path (Join-Path $projectRoot '.vercel') 'output'
if ($outputRoot -ne $expectedRoot) { throw 'Unexpected output directory.' }
$buildRoot = Join-Path $projectRoot 'build/web'
if (-not (Test-Path -LiteralPath (Join-Path $buildRoot 'main.dart.wasm'))) {
    throw 'A successful Flutter --wasm build is required before packaging.'
}
# Only this project-owned generated output directory is replaced.
if (Test-Path -LiteralPath $outputRoot) {
    $outputItem = Get-Item -LiteralPath $outputRoot -Force
    if ($outputItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
        throw 'Refusing to replace redirected output.'
    }
    Remove-Item -LiteralPath $outputRoot -Recurse -Force
}
$staticOutput = Join-Path $outputRoot 'static'
New-Item -ItemType Directory -Path $staticOutput -Force | Out-Null
Get-ChildItem -LiteralPath $buildRoot -Force | Copy-Item -Destination $staticOutput -Recurse
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'vercel-output.json') -Destination (Join-Path $outputRoot 'config.json')
