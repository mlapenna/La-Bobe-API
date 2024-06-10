#language: es
Característica: US3 Consultar opciones de menu

  Antecedentes:
    Dado que ya estoy registrado como usuario en el Telegram de la Bobe

  Escenario: US3-01 - Consulta simple de menú
    Dado que existe un menu
    Cuando consulto las opciones de menu
    Entonces obtengo "Individual", con precio 1000
    Entonces obtengo "Pareja", con precio 1500
    Entonces obtengo "Familiar", con precio 2500

  @bot # este escenario dentro de @bot no se va a ejecutar en el rake
  Escenario: US3-01 - Consulta simple de menú
    Dado que existe un menu
    Cuando consulto las opciones de menu con el comando /menu
    Entonces obtengo "Individual", con precio 1000
    Entonces obtengo "Pareja", con precio 1500
    Entonces obtengo "Familiar", con precio 2500
