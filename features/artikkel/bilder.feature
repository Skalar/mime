# encoding: utf-8
# language: no
Egenskap: Legge bilder til artikler

  For at leksikonet skal være så bra som mulig
  Som en lokalinteressert person
  Vil jeg kunne legge inn bilder i artikler

  @javascript
  Scenario: legge til bilder
    Gitt at original-artikkelen "Foo" finnes
    Og jeg står på artikkelredigering for "Foo"
    Når jeg legger ved bildet "spec/data/jpeg.jpeg" til "file-uploader"
    Og jeg trykker "Last opp filer"
    Så skal det være 1 av ".files li.image img"
    Når jeg trykker "Lagre"
    Så skal det være 1 av ".meta figure"
    Og artikkelen "Foo" skal ha 2 versjoner
    Og versjon 1 av "Foo" skal være sist oppdatert "2008-10-16"

  @javascript
  Scenario: legge bilder til ny artikkel
    Gitt at jeg står på ny artikkel-siden
    Og jeg fyller inn "article[headword]" med "Foo"
    Når jeg legger ved bildet "spec/data/jpeg.jpeg" til "file-uploader"
    Og jeg trykker "Last opp filer"
    Så skal det være 1 av ".files li.image img"
    Når jeg trykker "Opprett"
    Så skal det være 1 av ".meta figure"

  @javascript
  Scenario: legge bilder til ny artikkel som først får valideringsfeil
    Gitt at artikkelen "Foo" finnes
    Og jeg står på ny artikkel-siden
    Og jeg fyller inn "article[headword]" med "Foo"
    Og jeg legger ved bildet "spec/data/jpeg.jpeg" til "file-uploader"
    Når jeg trykker "Opprett"
    Og jeg fyller inn "article[headword]" med "Bar"
    Og jeg trykker "Opprett"
    Så skal det være 1 av ".meta figure"

  Scenario: endre bildetekst
    Gitt at artikkelen "Foo" finnes
    Og at artikkelen "Foo" har bilde
    Og jeg står på artikkelredigering for "Foo"
    Når jeg fyller inn "Beskrivelse" med "baz"
    Når jeg trykker "Lagre"
    Så skal jeg se "baz" under ".meta figcaption"
    
  Scenario: slette bilde fra artikkel etter at artikkelen er lagret (uten javascript)
    Gitt at artikkelen "Foo" finnes
    Og at artikkelen "Foo" har bilde
    Og jeg står på artikkelredigering for "Foo"
    Når jeg krysser av "Slett"
    Og jeg trykker "Lagre"
    Så skal det være 0 av ".meta figure"

  @javascript
  Scenario: slette bilde fra artikkel etter at artikkelen er lagret (med javascript)
    Gitt at artikkelen "Foo" finnes
    Og at artikkelen "Foo" har bilde
    Og jeg står på artikkelredigering for "Foo"
    Når jeg sletter det første bildet
    Og jeg trykker "Lagre"
    Så skal det være 0 av ".meta figure"

  @javascript
  Scenario: slette bilde fra artikkel før artikkelen er lagret
     Gitt at artikkelen "Foo" finnes
      Og jeg står på artikkelredigering for "Foo"
      Når jeg legger ved bildet "spec/data/jpeg.jpeg" til "file-uploader"
      Og jeg trykker "Last opp filer"
      Så skal det være 1 av ".files li.image img"
      Når jeg trykker "remove-image"
      Så skal det være 0 av ".files li.image img"