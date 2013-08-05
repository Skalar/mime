# encoding: utf-8
# language: no
Egenskap: Ny artikkel med oppslagsord

  For at leksikonet skal få mange interessante artikler
  Som en lokalinteressert person
  Vil jeg kunne opprette artikler som oppslagsord utfylt

  @log_in_user
  Scenario: opprette ny artikkel
    Når jeg går til ny artikkel-siden for "Foo"
    Så skal jeg se "Foo" i oppslagsord-feltet
