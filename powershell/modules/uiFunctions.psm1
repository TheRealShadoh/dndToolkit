function New-PlayerLanguages {
    param(
        $PlayerLanguages,
        $TargetPanel
    )

    <#
    ONLY TESTED WITH GROUP BOX
    ONLY TESTED WITH GROUP BOX
    #>


    $i = 0 #init point of label in panel
    #build out languages
    foreach ($lang in $PlayerLanguages) {
        $i = $i + 20
        $labelLanguage = (New-Object -TypeName System.Windows.Forms.Label)
        $labelLanguage.AutoSize = $true
        $labelLanguage.Name = [System.String]$lang
        $labelLanguage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74, [System.Int32]20))
        $labelLanguage.Text = [System.String]$lang
        $labelLanguage.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]20, [System.Int32]$i))

        #Add to panel (display to users)
        $TargetPanel.Controls.Add($labelLanguage)
    }


}
function New-PlayerInfo {
    param(
        $PlayersInfo,
        $TargetPanel,
        $Initialize
    )
    if ($Initialize) {
        $PlayersInfo = @("") #blank values
    }


    foreach ($player in $PlayersInfo) {
        #simple stats
        foreach ($key in $player.simpleStats.psobject.Properties | select -expandproperty name) {
            switch ($key) {
                "Languages" {
                    $dockPanel = New-Object System.Windows.Controls.DockPanel
                    $label = New-Object System.Windows.Controls.TextBlock
                    $label.Text = $key + ": "
                    $texblock = New-Object System.Windows.Controls.TextBlock
                    $texblock.Text = $player.simpleStats.$key
                    $dockPanel.AddChild($label)
                    $dockPanel.AddChild($texblock)
                    $TargetPanel.AddChild($dockPanel)

                }
                Default {
                    $dockPanel = New-Object System.Windows.Controls.DockPanel
                    $label = New-Object System.Windows.Controls.TextBlock
                    $label.Text = $key + ": "
                    $texblock = New-Object System.Windows.Controls.TextBlock
                    $texblock.Text = $player.simpleStats.$key
                    $dockPanel.AddChild($label)
                    $dockPanel.AddChild($texblock)
                    $TargetPanel.AddChild($dockPanel)

                }
            }
        }
        #detailed stats
        foreach ($key in $player.detailedStats.psobject.properties | Select-Object -expandproperty Name) {
            switch ($key) {
                "Languages" {
                    $dockPanel = New-Object System.Windows.Controls.DockPanel
                    $label = New-Object System.Windows.Controls.TextBlock
                    $label.Text = $key + ": "
                    $texblock = New-Object System.Windows.Controls.TextBlock
                    $texblock.Text = $player.detailedStats.$key
                    $dockPanel.AddChild($label)
                    $dockPanel.AddChild($texblock)
                    $TargetPanel.AddChild($dockPanel)

                }
                Default {
                    $dockPanel = New-Object System.Windows.Controls.DockPanel
                    $label = New-Object System.Windows.Controls.TextBlock
                    $label.Text = $key + ": "
                    $texblock = New-Object System.Windows.Controls.TextBlock
                    $texblock.Text = $player.detailedStats.$key
                    $dockPanel.AddChild($label)
                    $dockPanel.AddChild($texblock)
                    $TargetPanel.AddChild($dockPanel)

                }
            }
        }
        <#Non WPF
        $labelPlayerHeader = (New-Object -TypeName System.Windows.Forms.Label)
        $labelCharName = (New-Object -TypeName System.Windows.Forms.Label)
        $labelPlayerName = (New-Object -TypeName System.Windows.Forms.Label)
        $labelPlayerNumber = (New-Object -TypeName System.Windows.Forms.Label)
        $labelCharRace = (New-Object -TypeName System.Windows.Forms.Label)

        #build out controls
        $labelPlayerHeader.AutoSize = $true
        $labelPlayerHeader.Name = [System.String]"PlayerHeader"
        $labelPlayerHeader.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelPlayerHeader.Text = [System.String]"Player Info"
        $labelPlayerHeader.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]10.125,([System.Drawing.FontStyle][System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline),[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))

        $labelCharName.AutoSize = $true
        $labelCharName.Name = [System.String]$player.charName
        $labelCharName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelCharName.Text = [System.String]"Charcter Name: " + [System.String]$player.charName

        $labelPlayerName.AutoSize = $true
        $labelPlayerName.Name = [System.String]$player.playerName
        $labelPlayerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelPlayerName.Text = [System.String]"Player Name: " + [System.String]$player.playerName

        $labelPlayerNumber.AutoSize = $true
        $labelPlayerNumber.Name = [System.String]$player.playerNumber
        $labelPlayerNumber.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelPlayerNumber.Text = [System.String]"Player Number: " + [System.String]$player.playerNumber

        $labelCharRace.AutoSize = $true
        $labelCharRace.Name = [System.String]$player.charRace
        $labelCharRace.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelCharRace.Text = [System.String]"Player Number: " + [System.String]$player.charRace

        $labelLanguageHeader = (New-Object -TypeName System.Windows.Forms.Label)
        $labelLanguageHeader.AutoSize = $true
        $labelLanguageHeader.Name = [System.String]"LangHeader"
        $labelLanguageHeader.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelLanguageHeader.Text = [System.String]"Known Languages"
        $labelLanguageHeader.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]10.125,([System.Drawing.FontStyle][System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline),[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))

        #Add to panel (display to users)
        $TargetPanel.Controls.Add($labelPlayerHeader)
        $TargetPanel.Controls.Add($labelCharName)
        $TargetPanel.Controls.Add($labelPlayerName)
        $TargetPanel.Controls.Add($labelPlayerNumber)
        $TargetPanel.Controls.Add($labelCharRace)
        $TargetPanel.Controls.Add($labelLanguageHeader)

        foreach ($lang in $player.charLanguages){
            $labelLanguage = (New-Object -TypeName System.Windows.Forms.Label)
            $labelLanguage.AutoSize = $true
            $labelLanguage.Name = [System.String]$lang
            $labelLanguage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
            $labelLanguage.Text = [System.String]$lang
            $TargetPanel.Controls.Add($labelLanguage)
        }
        #>
        #init


    }



}


<#
function New-PlayerInfoLEGACY { #DEPRECATED
    param(
        $PlayersInfo,
        $TargetPanel,
        $Initialize
    )
    if($Initialize){
        $PlayersInfo = @("") #blank values
    }
    foreach($player in $PlayersInfo){
        #init
        $labelCharName = (New-Object -TypeName System.Windows.Forms.Label)
        $labelPlayerName = (New-Object -TypeName System.Windows.Forms.Label)
        $labelPlayerNumber = (New-Object -TypeName System.Windows.Forms.Label)
        $labelCharRace = (New-Object -TypeName System.Windows.Forms.Label)

        #build out controls
        $labelCharName.AutoSize = $true
        $labelCharName.Name = [System.String]$player.charName
        $labelCharName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelCharName.Text = [System.String]"Charcter Name: " + [System.String]$player.charName

        $labelPlayerName.AutoSize = $true
        $labelPlayerName.Name = [System.String]$player.playerName
        $labelPlayerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelPlayerName.Text = [System.String]"Player Name: " + [System.String]$player.playerName

        $labelPlayerNumber.AutoSize = $true
        $labelPlayerNumber.Name = [System.String]$player.playerNumber
        $labelPlayerNumber.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelPlayerNumber.Text = [System.String]"Player Number: " + [System.String]$player.playerNumber

        $labelCharRace.AutoSize = $true
        $labelCharRace.Name = [System.String]$player.charRace
        $labelCharRace.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]74,[System.Int32]20))
        $labelCharRace.Text = [System.String]"Player Number: " + [System.String]$player.charRace

        #Add to panel (display to users)
        $TargetPanel.Controls.Add($labelCharName)
        $TargetPanel.Controls.Add($labelPlayerName)
        $TargetPanel.Controls.Add($labelPlayerNumber)
        $TargetPanel.Controls.Add($labelCharRace)
        $TargetPanel.Controls.Add($groupBoxCharLanguages)
    }



}
#>
