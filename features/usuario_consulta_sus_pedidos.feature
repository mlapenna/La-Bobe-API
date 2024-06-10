#language: es

Característica: US19 usuario solo puede consultar sus pedidos
  Para saber el estado de un pedido
  Como usuario quiero poder consultar un pedido
  Sólo puedo hacerlo si el pedido me pertenece

  Antecedentes:
    Dado que no hay usuarios registrados en el Telegram de la Bobe
    Dado que me registro en el Telegram de la Bobe

#  @bot
#  Antecedentes:
#    Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678

  Escenario: US19-01 Consulta del estado del pedido realizado por otro
    Dado que el Usuario "Pablo" está registrado en el Telegram de la Bobe
    Dado que pide el menu "Individual"
    Cuando consulto el pedido como si fuera mio
    Entonces recibo el mensaje "El pedido pertenece a otra persona"

  @bot
  Escenario: Consulta del estado del pedido recibido
    Dado que ya registre un usuario con el comando /registracion Pablo, Mendoza 1234, 1112345600
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces recibo el mensaje "El pedido pertenece a otra persona"

  Escenario: US19-02 Consulta del estado del pedido realizado por mí
    Dado yo pido el menu "Individual"
    Cuando consulto el pedido como si fuera mio
    Entonces el estado del pedido es "Recibido"

  @bot
  Escenario: Consulta del estado del pedido recibido
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Recibido"

  Escenario: US19-02 No puedo pedir menu si no estoy registrado
    Dado que no hay usuarios registrados con id 0 en el Telegram de la Bobe
    Cuando pido el menu "Individual" con id de usuario 0
    Entonces recibo el mensaje "Primero debes registrarte para poder realizar un pedido"

  @bot
  Escenario: US19-02 No puedo pedir menu si no estoy registrado
    Dado que uso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/users/0' -H 'Content-Type: application/json'
    Dado que recibo un status 404 ObjectNotFound
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando curl -X POST -d '{"menu": "Individual","usuario": "Juan","id_usuario": "0"}' "https://webapi-bobe-test.herokuapp.com/pedidos"
    Entonces recibo el mensaje "Primero debes registrarte para poder realizar un pedido"
