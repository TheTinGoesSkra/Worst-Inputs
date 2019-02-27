# Worst inputs
## Zielsetzung

[Link zu Webseite](https://thetingoesskra.github.io/Worst-Inputs/)


In unserem Projekt wollen wir Eingaben für Telefonnummern machen, die möglichst unpraktisch oder aufwändig sind. Davon gibt es online schon einige [Beispiele](https://qz.com/679782/programmers-imagine-the-most-ridiculous-ways-to-input-a-phone-number/). Wir wollen einige der Beispiele nachprogrammieren und auch eigene, schlechte Eingaben erfinden.

## Teilziele

1. Einige einfache Beispiele aus dem Internet nachprogrammieren
2. Einige schwerere Beispiele selbst erfinden und programmieren
3. Alle Module auf einer Webseite zusammenfassen

## Liste der Module

1. **AutoIncrement** _von GeorgOhneH, 6.2.19_, 74b04b870c9efaee598826fa87fdc36fb843b22e

2. **Droplist** _von Honigchnuschperli, 13.2.19_, b93dd88055a0e466d67d53e616ab834a953cc449
Mittels einer Droplist kann eine Telefonnummer ausgewählt werden.

 
3. **MovingButtons** _von GeorgOhneH, 2.2.19_, 84736e32b0c27921585cfebd4b96a9cd059aec92
Die Telefonnummer wird eingegeben indem man auf bewegende Buttons drücken muss.


4. **NumIncrement** _von TheTinGoesSkra, 11.2.19_, 57a35b75e926dadd5570246ee833998704d366a3
Die Person muss so lange auf einen Increment-Button drücken, bis die gewollte Telefonnummer entsteht.


5. **PrimeNumbers** _von Honigchnuschperli, 20.2.19_, 32bec5694c104916f7b988760a23cc4db32b0282
Die Telefonnummer wird mit Multiplikation von Primzahlen eingegeben.  


6. **RandomChange** _von TheTinGoesSkra, 20.2.19_, d74a2f941575aeaadbedb6e6a551327eed5c090b
Eine Taste muss eingegeben werden, damit die angegebene Zahl entsteht.


7. **RandomNumber** _von Honigchnuschperli, 6.2.19_, 2445e3f6dd9595e9823f8ca787e61e1e29c5848d
Es wird so lange eine zufällige Nummer generiert bis diese per Zufall die Telefonnummer ist.


## Timeline
Die meisten Module wurden innerhalb von einer Doppelstunde programmiert.

###MovingButtons:
	Beispiel für Random Generatoren und einer Clock, von Georg Schwan.

###RandomNumber:
	Einfaches Beispiel um Zufallszahlen kennen zu lernen, von Leandro Hunter. 

###NumIncrement:
Typisches Beispiel mit dem Increment-Befehl, um Elm besser kennen   zu    lernen, von Vincent Ellenrieder.

###AutoIncrement:
	Weitere Anwendung von einer Clock, von Georg.

###Droplist:
	Anwendung von For-Loops, von Leandro Hunter.

###RandomChange: 
Verwendung von Random-Befehlen, Zeit-Elementen und Tastatur-Angaben, von Vincent Ellenrieder.

###PrimeNumbers: 
	Verwendung von Textfields in Elm, von Leandro Hunter.



##Diskussion
###Erkenntnisse/Probleme
Für das Styling wurde Bootstrap verwendet, da es relativ einfach ist.


Eventlistener von Javascript werden in Elm über Subscriptions gelöst. Kann manchmal mühsam werden, da es zu wenig Dokumentation gibt. 


Zufallszahlen können nicht einfach generiert werden sondern müssen über Random-Generators während der Laufzeiten ausgeführt werden.


Die Fehlermeldungen in Elm waren sehr hilfreich, was uns viel Zeit bei den Korrekturen gespart hat.


Wir habe relativ wenig neue Types verwendet, weil es nicht nötig war und wir nicht komplizierte, algorithmische Sachen implementieren wollten.  


Das enorme Wissen Georgs im Bereich des Informatik hat Leandro und Vincent ungemein geholfen und wir sind dafür sehr dankbar.
 	
