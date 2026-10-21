$ErrorActionPreference = 'Stop'
Push-Location (Split-Path -Parent $PSScriptRoot)
try {
    & (Join-Path $PSScriptRoot 'verify.ps1')
    if (-not (Test-Path -LiteralPath '.vercel/project.json')) {
        throw 'Link the intended Vercel project with vercel link before deploying.'
    }
    & (Join-Path $PSScriptRoot 'package.ps1')
    vercel deploy --prebuilt --prod --yes
    if ($LASTEXITCODE -ne 0) { throw 'Vercel deployment failed.' }
} finally {
    Pop-Location
}
