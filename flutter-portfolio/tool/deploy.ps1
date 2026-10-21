$ErrorActionPreference = 'Stop'
Push-Location (Split-Path -Parent $PSScriptRoot)
try {
    & (Join-Path $PSScriptRoot 'verify.ps1')
    if (-not (Test-Path -LiteralPath '.vercel/project.json')) {
        throw 'Link the intended Vercel project with vercel link before deploying.'
    }
    $staticOutput = Join-Path (Get-Location) '.vercel/output/static'
    New-Item -ItemType Directory -Path $staticOutput -Force | Out-Null
    Get-ChildItem -LiteralPath 'build/web' -Force | Copy-Item -Destination $staticOutput -Recurse -Force
    '{"version":3}' | Set-Content -LiteralPath '.vercel/output/config.json' -Encoding utf8
    vercel deploy --prebuilt --prod --yes
    if ($LASTEXITCODE -ne 0) { throw 'Vercel deployment failed.' }
} finally {
    Pop-Location
}
