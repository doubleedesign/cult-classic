# Check that commands are available
$commands = @("php", "mysql", "composer", "herd")
foreach ($command in $commands) {
	if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
		Write-Host "✘ $command is not available." -ForegroundColor Red
		exit 1
	}
	Write-Host "✔ $command is available" -ForegroundColor Green
}

# Get current folder name
$folderName = Split-Path -Leaf (Get-Location)
Write-Host "Folder name: $folderName"

# Check if database exists, if not create it
$databaseName = "${folderName}_dev"
$checkDbQuery = "SHOW DATABASES LIKE '$databaseName';"
$dbExists = & mysql -P 3309 -u root -e $checkDbQuery | Select-String $databaseName
if (-not $dbExists) {
	Write-Host "✘ Database '$databaseName' does not exist." -ForegroundColor Yellow
	$createDbQuery = "CREATE DATABASE $databaseName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
	& mysql -P 3309 -u root -e $createDbQuery
	Write-Host "✔ Database '$databaseName' created." -ForegroundColor Green
} else {
	Write-Host "✔ Database '$databaseName' already exists." -ForegroundColor Green
}

# Find the most recent file in sql folder
$sqlFolder = Join-Path (Get-Location) "sql"
if (Test-Path $sqlFolder) {
	$sqlFiles = Get-ChildItem -Path $sqlFolder -Filter *.sql | Sort-Object LastWriteTime -Descending
	if ($sqlFiles.Count -gt 0) {
		$latestSqlFile = $sqlFiles[0].FullName
		Write-Host "Importing latest SQL file: $latestSqlFile"
		# TODO this needs error handling
		mysql -P 3309 -u root $databaseName -e "source $latestSqlFile"
		Write-Host "✔ Database '$databaseName' imported from '$latestSqlFile'." -ForegroundColor Green
	} else {
		Write-Host "✘ No SQL files found in '$sqlFolder'. Cannot import database." -ForegroundColor Red
	}
} else {
	Write-Host "✘ SQL folder '$sqlFolder' does not exist. Cannot import database." -ForegroundColor Red
}

# Set up in Herd
cd app
herd link $folderName
herd secure

# Move back up to root folder
cd ..

# Install composer dependencies
if (Test-Path "composer.json") {
	Write-Host "Installing composer dependencies..."
	composer install
} else {
	Write-Host "✘ composer.json not found. Skipping composer install." -ForegroundColor Yellow
}
