#language: es
Característica: US14 Pedido de menú eligiendo una opción
  Para comprar el menu que quiero
  Como un usuario
  Quiero poder elegir el menu para pedir

  Antecedentes:
    Dado que ya estoy registrado como usuario en el Telegram de la Bobe

  @bot
  # Antecedentes:
  # Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678


  Escenario: Pedido del menu individual
    Dado que consulto las opciones de menu
    Cuando pido el menu "Individual"
    Entonces recibo el mensaje "Pedido exitoso del menu: Individual"

  @bot
  Escenario: Pedido del menu individual
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu Individual con el comando /pedir Individual
    Entonces recibo el mensaje "Pedido exitoso del menu: Individual"

  Escenario: Pedido del menu pareja
    Dado que consulto las opciones de menu
    Cuando pido el menu "Pareja"
    Entonces recibo el mensaje "Pedido exitoso del menu: Pareja"

  @bot
  Escenario: Pedido del menu pareja
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu Pareja con el comando /pedir Pareja
    Entonces recibo el mensaje "Pedido exitoso del menu: Pareja"

  Escenario: Pedido del menu familiar
    Dado que consulto las opciones de menu
    Cuando pido el menu "Familiar"
    Entonces recibo el mensaje "Pedido exitoso del menu: Familiar"

  @bot
  Escenario: Pedido del menu familiar
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu "Familiar" con el comando /pedir Familiar
    Entonces recibo el mensaje "Pedido exitoso del menu: Familiar"

  Escenario: Pedido de algo que no esta en el menu
    Dado que consulto las opciones de menu
    Cuando pido el menu "Repollos"
    Entonces recibo el mensaje de error "Pedido fallido elija una opcion valida"

  @bot
  Escenario: Pedido de algo que no esta en el menu
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido algo que no esta en el menu con el comando /pedir Repollos
    Entonces recibo el mensaje de error "Pedido fallido elija una opcion valida"
