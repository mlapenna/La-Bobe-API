#language: es
Característica: US4 Pedido de menú único
  Para comprar un menu
  Como un usuario
  Quiero poder realizar un pedido

Antecedentes:
  Dado que ya estoy registrado como usuario en el Telegram de la Bobe

Escenario: Pedido del menu individual
  Dado que consulto las opciones de menu
  Cuando pido el menu "Individual"
  Entonces recibo el mensaje "Pedido exitoso del menu: Individual"

@bot
Escenario: Pedido menu individual
  Dado que consulto las opciones de menu con el comando /menu
  Cuando pido el menu individual con el comando /pedir Individual
  Entonces recibo el mensaje de confirmación "Pedido exitoso del menu: Individual"



