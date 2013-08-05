# encoding: utf-8
# language: no

@log_in_user
Egenskap: Ny artikkel

  For at leksikonet skal få mange interessante artikler
  Som en lokalinteressert person
  Vil jeg kunne opprette artikler

  Scenario: opprette ny artikkel
    Gitt at jeg står på ny artikkel-siden
    Og jeg fyller inn "article[headword]" med "Xyzzy-tittel"
    Når jeg trykker "Opprett"
    Så skal jeg komme til artikkelredigering for "Xyzzy-tittel"
    Og jeg skal se "Xyzzy-tittel"

  Scenario: versjonslogg
    Gitt at jeg står på ny artikkel-siden
    Og jeg fyller inn "article[headword]" med "Xyzzy-tittel"
    Når jeg trykker "Opprett"
    Og jeg klikker "Versjonslogg"
    Så skal jeg se "Navn Navnesen" under "table.versions"

  @javascript
  Scenario: anonym bidragsyter
    Gitt at jeg står på ny artikkel-siden
    Når jeg klikker "Logg ut"
    Og jeg går til ny artikkel-siden
    Så skal jeg se "Du er nødt til å logge inn for å bidra til leksikonet." under "#alert"
