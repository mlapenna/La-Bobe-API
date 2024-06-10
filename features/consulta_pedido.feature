#language: es

Característica: US8 Consulta de estado del pedido
  Para saber el estado de un pedido
  Como usuario
  Quiero poder consultar un pedido

  Antecedentes:
    Dado que ya estoy registrado como usuario en el Telegram de la Bobe

  # este escenario dentro de @bot no se va a ejecutar en el rake
  # @bot
  # Antecedentes:
  #  Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678

  Escenario: Consulta del estado del pedido recibido
    Dado pido el menu "Individual"
    Cuando consulto mi pedido
    Entonces el estado del pedido es "Recibido"

  @bot # este escenario dentro de @bot no se va a ejecutar en el rake
  Escenario: Consulta del estado del pedido recibido
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Recibido"
