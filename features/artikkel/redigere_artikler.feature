# encoding: utf-8
# language: no
Egenskap: Redigere artikler

  For at leksikonet skal få mange interessante artikler
  Som en lokalinteressert person
  Vil jeg kunne redigere artikler

  Bakgrunn:
    Gitt følgende artikler:
      | headword | text               |
      | Foo      | Masse tekst om foo |
      | Bar      | Tekst om bar       |

    @log_in_user
    Scenario: gå til artikkelredigering fra artikkelvisning
      Gitt at jeg står på artikkelvisning for "Foo"
      Når jeg klikker "Rediger"
      Så skal jeg komme til artikkelredigering for "Foo"

    @log_in_user
    Scenario: redigere tekst i artikkel
      Gitt at jeg står på artikkelredigering for "Foo"
      Og jeg fyller inn "article[text]" med "Ny tekst om foo"
      Når jeg trykker "Lagre"
      Så skal jeg se "Ny tekst om foo"

    @javascript @log_in_user
    Scenario: beskjed om at artikkelen er lagret
      Gitt at jeg står på artikkelredigering for "Foo"
      Når jeg trykker "Lagre"
      Og jeg skal se "Artikkelen er lagret" under "#notice"

    @javascript
    Scenario: anonym bidragsyter
      Gitt at jeg står på artikkelredigering for "Foo"
      Så skal jeg se "Du er nødt til å logge inn for å bidra til leksikonet." under "#alert"

    @log_in_user
    Scenario: innlogget bidragsyter
      Og jeg står på artikkelredigering for "Foo"
      Og jeg fyller inn "article[text]" med "Ny tekst om foo"
      Når jeg trykker "Lagre"
      Og jeg klikker "Versjonslogg"
      Så skal jeg se "Navn Navnesen" under "table.versions"

    @javascript @log_in_user
    Scenario: Det skal være en lettfattelig måte å formatere artikler på
      Når jeg står på artikkelredigering for "Foo"
      Så skal "#article_text_editor" være usynlig
      Og jeg skal se formatert tekst med en verktøylinje
