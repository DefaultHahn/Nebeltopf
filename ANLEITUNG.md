# Nebeltopf v6 – Druck- und Bauanleitung

Facettierter Fogponik-Topf für 10 Pflanzen, gebaut für den Bambu Lab H2D.
Alles ist parametrisch in `nebeltopf.scad` (OpenSCAD). Keine Schrauben, kein TPU, keine Gewindeeinsätze.
Ausführliche Beschreibung mit Schnittmodell und Designentscheidungen: `Nebeltopf_v6_Dokumentation.pdf`.

## Maße

| | |
|---|---|
| Gesamthöhe | 383,5 mm (Sockel 200 + Kuppel 183,5) |
| Grundfläche | 280 × 284 mm (Sechseck 280 über Ecken, plus Ausbuchtung an einer Ecke) |
| Wasser | Sechseck-Tank (Wand 3 mm) + Wasserkammer: bis MAX (130 mm) ca. 6,6 l, bis MIN (40 mm) ca. 2,0 l |
| Pflanzplätze | 6 unten (15° nach oben), 3 Mitte (43°), 1 oben (senkrecht) |
| Netztopf | 2"-Maß, oben Ø 52, unten Ø 42, 50 mm tief, Rand Ø 60 |
| Öffnungen | Wasserkammer an der Ecke mit Deckel (Nachfüllen, Anzeiger), Kabelstutzen Innen-Ø 10 auf einer anderen Seite |

## Dateien (Ordner `stl`)

| Datei | Anzahl | Hinweis |
|---|---|---|
| `kuppel_haupt.stl` + `kuppel_farbe2.stl` | 1 | zusammen laden, zweifarbig |
| `kuppel.stl` | – | dieselbe Kuppel einfarbig (statt der beiden oben) |
| `sockel.stl` | 1 | Tank mit Kragen, Rinne, Siebauflage, Wasserkammer und Kabelstutzen |
| `sieb.stl` | 1 | Wurzelsieb, liegt im Sockel auf |
| `netztopf.stl` | 10 | |
| `kammerdeckel.stl` | 1 | deckt die Wasserkammer ab, Loch für den Anzeiger; wird flach gedruckt, liegt eingebaut 5° schräg |
| `podest.stl` | 1 | hebt den Anzeiger an, steht im Ring am Kammerboden |
| `kabelkappe.stl` | 1 | auf den Kabelstutzen, Kabel seitlich einlegen |
| `blindkappe.stl` | nach Bedarf | verschließt den Kabelstutzen, falls kein Kabel durch muss |
| `kragenadapter.stl` | nach Bedarf | für 2"-Neoprenkragen statt Netztopf |
| `pruefblock.stl` | 1 | Test der Topf-Passung, zuerst drucken |

Alle Teile liegen schon in Druckrichtung.

**Zukauf:** Ultraschallnebler mit Schwimmer (Kabel max. Ø 5 mm, sonst `KABEL_D` anpassen),
Wasserstandsanzeiger für Hydrokultur, 19 cm (dickste Stelle bis Ø 19, Rohr ca. Ø 12; sonst `ANZEIGER_LOCH` /
`ANZEIGER_D` anpassen), optional Silikonfett.

## Zuerst testen

1. `pruefblock.stl` und einen `netztopf.stl` drucken.
2. Topf mit den drei Nasen in die Schlitze stecken und im Uhrzeigersinn (von oben gesehen) ca. 30° drehen.
   Kurz vor dem Ende wird es strammer, dann klickt es, und der Rand liegt bündig.
3. Zu stramm oder zu locker: in der .scad `SPIEL` ändern (Standard 0,25 mm) und Topf neu exportieren.

## Druckeinstellungen (Bambu Studio)

Material überall PETG. Für alles, was Wasser hält: **Wandschleifen 8** (die Wände werden damit komplett
aus Umfangslinien gedruckt) und **Boden/Deckel 4 mm massiv** (bei 0,2 mm Schichthöhe 20 Schichten).
Bauteillüfter niedrig (10–30 %), das verbessert die Lagenhaftung.
Fertige Profile für Bambu Studio liegen im Ordner `druckprofile` (Datei › Importieren › Konfigurationen importieren):
`Nebeltopf_Sockel_wasserdicht.json` (Prozess) und `SUNLU_PETG_Nebeltopf_H2D.json` (Filament).

**Kuppel** (zwei Farben, passt in den Zwei-Düsen-Bauraum)
- `kuppel_haupt.stl` und `kuppel_farbe2.stl` gleichzeitig importieren, „als ein Objekt mit mehreren Teilen“
  bestätigen, dann je Teil das Filament zuweisen.
- Stützen: **Baum (automatisch), „Nur auf Druckplatte“, Schwellenwinkel 30°**.
  Gestützt wird nur die Unterseite der Spitze; alles andere ist mit 45° oder als Brücke druckbar.

**Sockel:** ohne Stützen. Der Übergang vom Sechseck zum runden Kragen ist eine 45°-Schräge, die Decke des Hohlrings darüber wird überbrückt.
Nach dem Druck einen Tag mit Wasser bis MAX stehen lassen, bevor die Technik rein kommt.

**Sieb, Netztöpfe, Kappen, Kammerdeckel, Podest, Prüfblock:** ohne Stützen.

Filament (Wände massiv gerechnet): Kuppel ca. 0,8 kg, Sockel ca. 1,3 kg, 10 Töpfe ca. 0,18 kg, Rest ca. 0,15 kg.

## Zusammenbau

1. Nebler in den Tank legen, Kabel von innen durch den Kabelstutzen fädeln,
   Kabel seitlich in den Schlitz der Kabelkappe drücken, Kappe mit leichter Drehung aufstecken
   (6 %-Kegel, dichtet ohne Gummi; ein Hauch Silikonfett hilft).
2. Podest in den Ring am Boden der Wasserkammer stellen, Anzeiger hineinstellen,
   Kammerdeckel darüber in den Falz legen.
3. Sieb mit dem Griff nach oben auf die Auflage legen.
4. Kuppel aufsetzen (siehe unten), Netztöpfe einsetzen.
5. Wasser über die Wasserkammer einfüllen, höchstens 6,6 l (MAX).

## Kuppel auf den Sockel setzen

1. Kuppel so aufsetzen, dass sie ca. 20° im Uhrzeigersinn verdreht ist (von oben gesehen);
   die Nasen innen am Kuppelring rutschen dann in die Schlitze am Sockelkragen.
2. Kuppel gegen den Uhrzeigersinn drehen, bis sie klickt und die Sechseckkanten bündig sind.
   Die schräge Nut zieht die Kuppel dabei auf die Auflage.
3. Zum Öffnen: im Uhrzeigersinn zurückdrehen (die Rastzungen geben nach), abheben.
   Die Wurzeln können bis aufs Sieb wachsen, also langsam abheben.

**Nachfüllen:** Kammerdeckel abheben (er geht über den Anzeiger), Wasser in die Kammer gießen, Deckel drauf.
Die Kuppel bleibt dabei drauf. Die Kammer ist nur unten mit dem Tank verbunden, deshalb kommt kein Nebel heraus.
Der Anzeiger steht an der Ecke zwischen zwei Pflanzplätzen, dort sitzt kein Topf darüber.
Die Ausbuchtung ist zu beiden Seiten gleich angeschrägt, Dach und Deckel fallen 5° nach außen ab:
verschüttetes Wasser und Schmutz bleiben nicht liegen.

| Wasser über Boden | Füllmenge |
|---|---|
| 40 mm (MIN) | 2,0 l |
| 70 mm | 3,6 l |
| 100 mm | 5,1 l |
| 130 mm (MAX) | 6,6 l |

Pro Zentimeter sind es ca. 0,51 l. Hydrokultur-Anzeiger haben meist keine Skala für so tiefe Tanks: einmal mit dem
Messbecher bis MIN füllen und merken, was der Anzeiger zeigt. Passt es nicht, das Podest mit anderem `PODEST_H`
neu drucken (Standard 25 mm, damit das Sichtfenster eines 19-cm-Anzeigers über dem Deckel liegt).

Kondenswasser läuft innen an der Kuppel herunter, über die Schulter und die Rinne zurück in den Tank.

## Betrieb

- Nebler im Intervall betreiben (Zeitschaltuhr), nicht dauerhaft.
- Wasserstand nie unter MIN fallen lassen, der Nebler braucht Wasser über sich.
- Sieb ab und zu herausnehmen und Wurzeln, die durchgewachsen sind, abschneiden.

## OpenSCAD bedienen

- Fenster > Customizer öffnen, bei `TEIL` auswählen, was du sehen willst.
  `uebersicht` lädt die fertigen STLs aus dem Ordner `stl` und ist sofort flüssig drehbar.
- Ein Teil exportieren: `TEIL` wählen, F6, dann F7.
- Schnell rechnen: aktuellen Development Snapshot von openscad.org installieren und unter
  Bearbeiten > Einstellungen > Erweitert als 3D-Rendering-Backend „Manifold“ wählen.
  Mit OpenSCAD 2021 dauert die Kuppel ca. 3 Minuten, egal wie schnell der PC ist (ein Kern).
- Gefahrlos änderbar: `SPIEL`, `KABEL_D`, `ANZEIGER_LOCH`, `ANZEIGER_D`, `PODEST_H`, `ANSCHLUSS_ID`, `FARBSCHICHT`.
  `R_ANZEIGER` (wie weit der Anzeiger außen steht), `FLANKE` (wie weit die Schrägen vor der Ecke beginnen) und
  `DACH_NEIGUNG` (Gefälle von Dach und Deckel) gehen auch, danach mit `TEIL = "schnitt"` kurz prüfen.
  Die Facetten- und Platzwinkel (`EL_…`, `R_…`, `Z_…`) sind so abgestimmt, dass sich die 10 Töpfe
  innen nicht berühren und nichts übersteht. Wer daran dreht, sollte mit `TEIL = "schnitt"` prüfen.
