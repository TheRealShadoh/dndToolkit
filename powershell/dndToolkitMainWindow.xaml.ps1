Add-Type -AssemblyName presentationframework
Add-Type -AssemblyName System.Windows.Forms

function Add-ControlVariables { # May need to add variables from UI here manually to call them

	New-Variable -Name 'window' -Value $window.FindName('window') -Scope 1 -Force
	New-Variable -Name 'playerPicture' -Value $window.FindName('playerPicture') -Scope 1 -Force
	New-Variable -Name 'languageComboBox' -Value $window.FindName('languageComboBox') -Scope 1 -Force
	New-Variable -Name 'chatEnter' -Value $window.FindName('chatEnter') -Scope 1 -Force
	New-Variable -Name 'chatLog' -Value $window.FindName('chatLog') -Scope 1 -Force
	New-Variable -Name 'buttonSelectPlayer' -Value $window.FindName('buttonSelectPlayer') -Scope 1 -Force
	New-Variable -Name 'buttonSelectDM' -Value $window.FindName('buttonSelectDM') -Scope 1 -Force
	New-Variable -Name 'menuTab' -Value $window.FindName('menuTab') -Scope 1 -Force
	New-Variable -Name 'playerStats' -Value $window.FindName('playerStats') -Scope 1 -Force
	New-Variable -Name 'intro' -Value $window.FindName('intro') -Scope 1 -Force
	New-Variable -Name 'playerSimpleStats' -Value $window.FindName('playerSimpleStats') -Scope 1 -Force
	New-Variable -Name 'playerDetailedStats' -Value $window.FindName('playerDetailedStats') -Scope 1 -Force

}

function Load-Xaml {
	[xml]$xaml = Get-Content -Path $PSScriptRoot\dndToolkitMainWindow.xaml
	$manager = New-Object System.Xml.XmlNamespaceManager -ArgumentList $xaml.NameTable
	$manager.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
	$xaml.SelectNodes("//*[@x:Name='window']", $manager)[0].RemoveAttribute('Loaded')
	$xaml.SelectNodes("//*[@x:Name='playerPicture']", $manager)[0].RemoveAttribute('Click')
	$xaml.SelectNodes("//*[@x:Name='chatEnter']", $manager)[0].RemoveAttribute('KeyDown')
	$xaml.SelectNodes("//*[@x:Name='buttonSelectPlayer']", $manager)[0].RemoveAttribute('Click')
	$xaml.SelectNodes("//*[@x:Name='buttonSelectDM']", $manager)[0].RemoveAttribute('Click')
	$xaml.SelectNodes("//*[@x:Name='playerStats']", $manager)[0].RemoveAttribute('Loaded')
	$xamlReader = New-Object System.Xml.XmlNodeReader $xaml
	[Windows.Markup.XamlReader]::Load($xamlReader)
}
function Load-XamlCustom {
	param(
		$windowName
	)
	[xml]$xaml = Get-Content -Path $PSScriptRoot\$windowName
	$manager = New-Object System.Xml.XmlNamespaceManager -ArgumentList $xaml.NameTable
	$manager.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
	$xamlReader = New-Object System.Xml.XmlNodeReader $xaml
	[Windows.Markup.XamlReader]::Load($xamlReader)
}

function Set-EventHandlers {

	$window.add_Loaded( {
			param([System.Object]$sender, [System.Windows.RoutedEventArgs]$e)
			window_Loaded($sender, $e)
		})
	$chatEnter.add_KeyDown( {
			param([System.Object]$sender, [System.Windows.Input.KeyEventArgs]$e)
			chatEnter_KeyDown($sender, $e)
		})
	$buttonSelectPlayer.add_Click( {
			param([System.Object]$sender, [System.Windows.RoutedEventArgs]$e)
			buttonSelectPlayer_Click($sender, $e)
		})
	$buttonSelectDM.add_Click( {
			param([System.Object]$sender, [System.Windows.RoutedEventArgs]$e)
			buttonSelectDM_Click($sender, $e)
		})
	$playerStats.add_Loaded( {
			param([System.Object]$sender, [System.Windows.RoutedEventArgs]$e)
			playerStats_Loaded($sender, $e)
		})
}




$window = Load-Xaml
Add-ControlVariables
Set-EventHandlers





$boxbindingtest = "Chat log goes here!
Type in your message, or the message someone sent you!
It will then translate if you know the language and add it to the chat log.
If it recognizes that you're the one sending the message it will display it in the box below.
I'm open to a better way to do this."

#Import resources
Import-Module "C:\git\dndToolkit\powershell\data\resources.psm1"


#Carry over from dndToolkit
#region Pathing
$workingDir = Split-Path -Parent $MyInvocation.MyCommand.path #$dndTranslatorPOSH_DMScreen_Load.file
$dataDir = Split-Path -Parent $workingDir
$dataDir = Split-Path -Parent $dataDir
#endregion Pathing

Import-Module  "C:\git\dndToolkit\powershell\modules\dndToolkit.psd1" -Force -Verbose

$global:data = @{ } #share data between scopes

# Language import
$langMap = Get-Content "C:\git\dndToolkit\powershell\data\languages\default.json" -Raw
$langMap = $langMap | ConvertFrom-Json
$global:data.Add('langmap', $langMap)

# Setup Players - not used for player screen
$players = Get-childitem "C:\git\dndToolkit\powershell\data\playerFiles\" | ForEach-Object { Get-Content $_.FullName -Raw | ConvertFrom-Json }   #will need to set this up for proper pathing
# Setup NPC
$npcs = Get-childitem "C:\git\dndToolkit\powershell\data\npcFiles\" | ForEach-Object { Get-Content $_.FullName -Raw | ConvertFrom-Json }   #will need to set this up for proper pathing
$global:data.Add('players', $players) # not used for player screen
$global:data.Add('npcs', $npcs)





function window_Loaded {
	param($sender, $e)
	$playerImg = playerImg1
	$bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
	$bitmap.BeginInit()
	$bitmap.StreamSource = [System.IO.MemoryStream][System.Convert]::FromBase64String($playerImg)
	$bitmap.EndInit()
	$bitmap.Freeze()
	$playerPicture.Source = $bitmap
}


function chatEnter_KeyDown {
	param($sender, $e)

	if ($sender.key -eq 'Return') {
		<# textbox
		$chatlog.AppendText($chatEnter.text)
		$chatlog.AppendText($boxbindingtest)
		#>
		$chatlog.Text += $chatEnter.text
		$chatlog.Text += $boxbindingtest


	}

}

function buttonSelectPlayer_Click {
	param($sender, $e)
	#
	# Select the player file
	#

	[System.Windows.Forms.OpenFileDialog]$openFileDialog1 = $null
	$openFileDialog1 = (New-Object -TypeName System.Windows.Forms.OpenFileDialog)
	$openFileDialog1.ShowDialog()

	# Read each file, import and convert from json into usable data

	$players = Get-Content -Path $openFileDialog1.FileName -Raw | ConvertFrom-Json


	# Update databinging... update ui
	$playerInfo = New-PlayerInfo -PlayersInfo $players -SimpleStatsTarget $playerSimpleStats -DetailedStatsTarget $playerDetailedStats
	$playerStats.IsEnabled = $true
	$intro.isEnabled = $false
	$menuTab.selectedItem = $playerStats
}

function playerStats_Loaded {
	param($sender, $e)

}





function buttonSelectDM_Click {
	param($sender, $e)

	# Select the folder containing player files

	[System.Windows.Forms.FolderBrowserDialog]$folderBrowserDialog1 = $null
	$folderBrowserDialog1 = (New-Object -TypeName System.Windows.Forms.FolderBrowserDialog)
	$folderBrowserDialog1.ShowDialog()



	# Read each file, import and convert from json into usable data

	#$players = Get-childitem $playerFile | ForEach-Object { Get-Content $_.FullName -Raw | ConvertFrom-Json }


	# Update databinging... update ui
	#written for winforms              New-PlayerInfo -PlayersInfo $players -TargetPanel $flowLayoutPanel1

	#change tab
	$intro.isEnabled = $false
	$playerStats.IsEnabled = $true
	$menuTab.selectedItem = $playerStats

}


$window.ShowDialog()