param(
    [string] $SourceRoot,
    [string] $WasmFile,
    [switch] $SelfTest
)
$ErrorActionPreference = 'Stop'

function Assert-WasmFreshness([datetime] $wasmTime, [datetime[]] $sourceTimes) {
    foreach ($sourceTime in $sourceTimes) {
        if ($sourceTime -gt $wasmTime) {
            throw 'The WebAssembly output is older than the Dart source. Rebuild from a clean checkout before deploying.'
        }
    }
}

if ($SelfTest) {
    $now = [datetime]::UtcNow
    Assert-WasmFreshness $now @($now.AddMinutes(-1))
    $rejected = $false
    try { Assert-WasmFreshness $now @($now.AddMinutes(1)) } catch { $rejected = $true }
    if (-not $rejected) { throw 'Stale WebAssembly was not rejected.' }
    $rejected = $false
    $missingFile = Join-Path $PSScriptRoot ([guid]::NewGuid().ToString('N') + '.wasm')
    try { & $PSCommandPath -SourceRoot $PSScriptRoot -WasmFile $missingFile } catch { $rejected = $true }
    if (-not $rejected) { throw 'Missing WebAssembly was not rejected.' }
    Write-Output 'WebAssembly freshness checks passed.'
    return
}

if (-not (Test-Path -LiteralPath $WasmFile -PathType Leaf)) {
    throw 'A successful Flutter --wasm build is required before packaging.'
}
if (-not (Test-Path -LiteralPath $SourceRoot -PathType Container)) {
    throw 'Dart source directory is missing.'
}
$wasmTime = (Get-Item -LiteralPath $WasmFile).LastWriteTimeUtc
$sourceTimes = @(Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -Filter '*.dart' | ForEach-Object { $_.LastWriteTimeUtc })
if ($sourceTimes.Count -eq 0) { throw 'No Dart source files were found.' }
Assert-WasmFreshness $wasmTime $sourceTimes
