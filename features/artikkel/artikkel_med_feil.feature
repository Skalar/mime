# encoding: utf-8
# language: no
@stub_user
Egenskap: Artikkel med feil

  For at leksikonet skal få artikler uten feil
  Som en lokalinteressert person
  Vil jeg ha gode feilmeldinger

  Bakgrunn: Skrevet ny artikkel med feil
    Gitt at jeg er logget inn
    Og jeg står på ny artikkel-siden

    @javascript
    Scenario: melding om at artikkel ikke ble lagret
      Når jeg trykker "Opprett"
      Så skal jeg se "ikke opprettet" under "#alert"

    Scenario: feilmeldinger ved lagre-knappen
      Når jeg trykker "Opprett"
      Så skal jeg se "Artikkelen må nok ha oppslagsord"
