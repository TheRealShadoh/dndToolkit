# dndTranslator
## Team
- GMZeirith
- exeldrian

## Basic function
GM Screen
```dndTranslatorPOSH_GMScreen.ps1```

Player screen
``` dndTranslatorPOSH_PlayerScreen.ps1 ```

Converted without salt, you trust your players
```
fLI TIVWSR 2SY EVI PSSOMRK JSV QE2 LEZI GSQI XLVSYKL XLMW EVIEB E JI0 GSMRW QE2 LIPT QI VIQIQFIVw
The person you are looking for may have come through this area, a few coins may help me remember.
```

Converted with salt, players will not be able to decode the message without you giving them the salt number.
```
kQN YN01XW 7X3 J0N UXXTRWP OX0 VJ7 QJ4N LXVN 2Q0X3PQ 2QR1 J0NJG J ON5 LXRW1 VJ7 QNUY VN 0NVNVKN0B H] n9j j9ck(!I
The person you are looking for may have come through this area, a few coins may help me remember. [I WAS SALTED]
```

![](img/demo/5translated.png)



## TODO
Basic PowerShell GUI thrown together to proof of concept the flow. Next steps...
- Import players:languages into GM screen from JSON
- Allow players:languages  to be created within GUI
- Place language next to each player for each language they know
- Dynamic creation of available language buttons
- Language buttons click event for encoding the GM Message into a language and copying to clipboard + a console(?)
- Player screen import a config file (JSON) that sets their language options
- Create a player screen paste button


## General flow

- DM picks cypher settings for languages
- DM assigns languages known to players
- User inputs a message, selects a language
- Message is run through cypher based on language choice
- Cyphertext delivered to recipient or chat
- If PC knows language
-    PM translation
- Else
-    PM language used if DM allows?

## Ideas

- Custom fonts?
- Discord or simple copy/paste??
- Vocalize or text based on context


### Supported Languages
- Common
- Orc
- Goblin
- Draconic
- Elvish
- Dwarvish
- Underdark
- Abyssal
- Infernal
- Giant
- Gnomish
- Halfling

### Supported characters
 - a-z
 - A-Z
 - 0-9
 - . ! ? ( ) , [ ] ' ; :

 ### Known issues
 - If key is too large (100 known as bad), some letters will fail to be decoded. Report an issue with the plain text, language, key (if not default), and the cipher text.
