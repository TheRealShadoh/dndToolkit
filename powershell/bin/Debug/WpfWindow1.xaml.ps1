Add-Type -AssemblyName presentationframeworkfunction Add-ControlVariables {	
New-Variable -Name 'window' -Value $window.FindName('window') -Scope 1 -Force	
New-Variable -Name 'button' -Value $window.FindName('button') -Scope 1 -Force
}

function Load-Xaml {
	[xml]$xaml = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('PFdpbmRvdw0KDQogIHhtbG5zPSJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dpbmZ4LzIwMDYveGFtbC9wcmVzZW50YXRpb24iDQoNCiAgeG1sbnM6eD0iaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93aW5meC8yMDA2L3hhbWwiIHg6TmFtZT0id2luZG93Ig0KDQogIFRpdGxlPSJNYWluV2luZG93IiBIZWlnaHQ9IjM1MCIgV2lkdGg9IjUyNSIgTG9hZGVkPSJ3aW5kb3dfTG9hZGVkIj4NCiAgICA8QnV0dG9uIHg6TmFtZT0iYnV0dG9uIiBDb250ZW50PSJCdXR0b24iIEhvcml6b250YWxBbGlnbm1lbnQ9IkxlZnQiIE1hcmdpbj0iOTUsMTMzLDAsMCIgVmVydGljYWxBbGlnbm1lbnQ9IlRvcCIgV2lkdGg9Ijc1IiBDbGljaz0iYnV0dG9uX0NsaWNrIi8+DQo8L1dpbmRvdz4='))
[System.Reflection.Assembly]::LoadWithPartialName('PresentationFramework') | Out-Null
	$manager = New-Object System.Xml.XmlNamespaceManager -ArgumentList $xaml.NameTable
	$manager.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
	$xaml.SelectNodes("//*[@x:Name='window']", $manager)[0].RemoveAttribute('Loaded')
	$xaml.SelectNodes("//*[@x:Name='button']", $manager)[0].RemoveAttribute('Click')
	$xamlReader = New-Object System.Xml.XmlNodeReader $xaml
	[Windows.Markup.XamlReader]::Load($xamlReader)
}
function Set-EventHandlers {
	$window.add_Loaded({
		param([System.Object]$sender,[System.Windows.RoutedEventArgs]$e)
		window_Loaded($sender,$e)
	})
	$button.add_Click({
		param([System.Object]$sender,[System.Windows.RoutedEventArgs]$e)
		button_Click($sender,$e)
	})
}

$window = Load-XamlAdd-ControlVariables
Set-EventHandlers

function window_Loaded
{
	param($sender, $e)
}


function button_Click
{
	param($sender, $e)
	test-message -msg 'clicky'
}

#
# modules.psm1
#
function test-message {
	param(
		$msg
	)
	msg console $msg
}
$window.ShowDialog()