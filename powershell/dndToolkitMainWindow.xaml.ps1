Add-Type -AssemblyName presentationframework

function Add-ControlVariables { # May need to add variables from UI here manually to call them

New-Variable -Name 'window' -Value $window.FindName('window') -Scope 1 -Force	
New-Variable -Name 'playerButton' -Value $window.FindName('playerButton') -Scope 1 -Force	
New-Variable -Name 'playerPicture' -Value $window.FindName('playerPicture') -Scope 1 -Force
New-Variable -Name 'languageComboBox' -Value $window.FindName('languageComboBox') -Scope 1 -Force

	
}

function Load-Xaml {
	[xml]$xaml = Get-Content -Path $PSScriptRoot\dndToolkitMainWindow.xaml
	$manager = New-Object System.Xml.XmlNamespaceManager -ArgumentList $xaml.NameTable
	$manager.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
	$xaml.SelectNodes("//*[@x:Name='window']", $manager)[0].RemoveAttribute('Loaded')
	$xaml.SelectNodes("//*[@x:Name='playerButton']", $manager)[0].RemoveAttribute('Click')
	$xaml.SelectNodes("//*[@x:Name='playerPicture']", $manager)[0].RemoveAttribute('Click')
	$xamlReader = New-Object System.Xml.XmlNodeReader $xaml
	[Windows.Markup.XamlReader]::Load($xamlReader)
}
function Load-XamlCustom{
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

	$window.add_Loaded({
		param([System.Object]$sender,[System.Windows.RoutedEventArgs]$e)
		window_Loaded($sender,$e)
	})
	$playerButton.add_Click({
		param([System.Object]$sender,[System.Windows.RoutedEventArgs]$e)
		playerButton_Click($sender,$e)
	})

}

$window = Load-Xaml
Add-ControlVariables
Set-EventHandlers

function window_Loaded
{
	param($sender, $e)
	$playerImg = playerImg1
	$bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
	$bitmap.BeginInit()
	$bitmap.StreamSource = [System.IO.MemoryStream][System.Convert]::FromBase64String($playerImg)
	$bitmap.EndInit()
	$bitmap.Freeze()
	$playerPicture.Source = $bitmap
}

#.(Join-Path $PSScriptRoot "modules.psm1")

function submitButton_Click
{
	param($sender, $e)
	msg console $firstNameText.text


}
function newWindow_Click
{
	param($sender, $e)
	$window2 = Load-XamlCustom -windowName WpfWindow2.xaml
	$window2.ShowDialog()

}


function playerButton_Click
{
	param($sender, $e)

}

$languages=@("common","Elvish","blah","blah")
$languageComboBox = $languages
#Import resources
Import-Module "C:\git\dndToolkit\powershell\data\resources.psm1"

$window.ShowDialog()