# Define parameters
param (
    [Parameter(Mandatory = $true, HelpMessage = "Specify the file path to copy.")]
    [string]$FilePath,

    [Parameter(Mandatory = $true, HelpMessage = "Specify the culture.")]
    [string]$Culture
)

# Check if the specified file exists
if (-Not (Test-Path -Path $FilePath)) {
    Write-Host "Error: The file '$FilePath' does not exist." -ForegroundColor Red
    exit 1
}

# Get the directory of the original file
$Directory = Split-Path -Path $FilePath

if ($Culture -eq "Barbarian") {
  $NewFileNames = @("102478131.wem", "1045795626.wem", "1049025423.wem", "160844087.wem", "275696381.wem", "281115467.wem", "298682469.wem", "307982822.wem", "354513421.wem", "3600008.wem", "476299133.wem", "487968435.wem", "503423011.wem", "560373866.wem", "960708276.wem", "99462000.wem")
} elseif ($Culture -eq "Eastern") {
  $NewFileNames = @("356751165.wem", "714455442.wem", "1045141631.wem", "588809634.wem", "5276975.wem", "557643065.wem", "1007382217.wem", "419959907.wem", "99473578.wem", "1031602017.wem", "454672576.wem")
} elseif ($Culture -eq "Nomad") {
  $NewFileNames = @("1066320220.wem", "641426314.wem", "7905113.wem", "416599737.wem", "266556003.wem", "146899512.wem", "201991136.wem", "334587872.wem", "21583811.wem", "856256630.wem", "49225673.wem", "53100711.wem", "730560580.wem")
} elseif ($Culture -eq "Roman") {
  $NewFileNames = @("1023832362.wem", "109215146.wem", "117444204.wem", "125659827.wem", "184270593.wem", "187949750.wem", "333641789.wem", "403404911.wem", "425905752.wem", "683762023.wem", "852692817.wem", "89161115.wem", "977441045.wem")
} else {
  Write-Host "Error: Unknown culture '$Culture'." -ForegroundColor Red
  exit 1
}

foreach ($Item in $NewFileNames) {
  $NewFilePath = Join-Path -Path $Directory -ChildPath $Item

  try {
    Copy-Item -Path $FilePath -Destination $NewFilePath -Force
    Write-Host "File copied successfully to '$NewFilePath'" -ForegroundColor Green
  } catch {
    Write-Host "Error: Unable to copy and rename the file. $_" -ForegroundColor Red
  }
}
