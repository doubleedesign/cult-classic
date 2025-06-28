# Check that commands are available
$commands = @("mysql", "mysqldump", "git")
foreach ($command in $commands) {
	if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
		Write-Host "✘ $command is not available." -ForegroundColor Red
		exit 1
	}
	Write-Host "✔ $command is available" -ForegroundColor Green
}

# Date for auto-commt messages and db export
$date = Get-Date -Format "yyyy-MM-dd"

# Commit any uncommitted changes to Git
$gitStatus = git status --porcelain
if ($gitStatus) {
	Write-Host "Uncommitted changes found. Committing to Git..."
	git add .
	git commit -m "Auto-commit of changes from $date"
	Write-Host "✔ Changes committed to Git." -ForegroundColor Green
}

# Get current folder name
$folderName = Split-Path -Leaf (Get-Location)
Write-Host "Folder name: $folderName"

# Prepare export filename
$fileName = "${folderName}_dev_${date}.sql"
$path = Join-Path (Get-Location) "sql"

# Export the database
$databaseName = "${folderName}_dev"
if (-not (Test-Path $path)) {
	New-Item -ItemType Directory -Path $path | Out-Null
}
$exportFile = Join-Path $path $fileName
$exportCommand = "mysqldump -P 3309 -u root $databaseName > `"$exportFile`""
Invoke-Expression $exportCommand
if (Test-Path $exportFile) {
	Write-Host "✔ Database '$databaseName' exported to '$exportFile'." -ForegroundColor Green
} else {
	Write-Host "✘ Failed to export database '$databaseName'." -ForegroundColor Red
	exit 1
}

# Commit the export to Git
git add $exportFile
git commit -m "Database backup: $fileName"
Write-Host "✔ Exported database committed to Git." -ForegroundColor Green

