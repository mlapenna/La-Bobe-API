#language: es
Característica: US20 Validar solo se puede cancelar si el pedido si está Recibido o Preparando

  Antecedentes:
    Dado que me registro como usuario
    Dado me registro como repartidor
    Dado pido el menu "Individual"
    Dado que no llueve

  @bot
  # Antecedentes:
  #  Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
  #  Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
  #  Dado que se pidió un menu Individual con el comando /pedir Individual
  #  Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' http://webapi-bobe-test.herokuapp.com/mock_lluvia_activar

  Escenario: Cancelo pedido en estado Recibido
    Dado consulto mi pedido
    Dado el estado del pedido es "Recibido"
    Cuando cancelo el pedido
    Entonces recibo el mensaje "Su pedido fue cancelado exitosamente."

  @api
  Escenario: Cancelo pedido en estado Recibido
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Recibido"
    Cuando cancelo el pedido con el comando /cancelar_pedido <id_pedido_generado>
    Entonces recibo el mensaje "Su pedido fue cancelado exitosamente."

  Escenario: Cancelo pedido en estado Preparando
    Dado consulto mi pedido
    Dado progreso el estado del pedido
    Dado el estado del pedido es "Preparando"
    Cuando cancelo el pedido
    Entonces recibo el mensaje "Su pedido fue cancelado exitosamente."

  @api
  Escenario: Cancelo pedido en estado Preparando
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Preparando"
    Cuando cancelo el pedido con el comando /cancelar_pedido <id_pedido_generado>
    Entonces recibo el mensaje "Su pedido fue cancelado exitosamente."

  Escenario: No puedo cancelar pedido en estado Enviando
    Dado consulto mi pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado el estado del pedido es "Enviando"
    Cuando cancelo el pedido
    Entonces recibo el mensaje "Su pedido no puede ser cancelado."

  @api
  Escenario: No puedo cancelar pedido en estado Enviando
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Enviando"
    Cuando cancelo el pedido con el comando /cancelar_pedido <id_pedido_generado>
    Entonces recibo el mensaje "Su pedido no puede ser cancelado."

  Escenario: No puedo cancelar pedido en estado Entregado
    Dado consulto mi pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado el estado del pedido es "Entregado"
    Cuando cancelo el pedido
    Entonces recibo el mensaje "Su pedido no puede ser cancelado."

  @api
  Escenario: No puedo cancelar pedido en estado Enviando
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Entregado"
    Cuando cancelo el pedido con el comando /cancelar_pedido <id_pedido_generado>
    Entonces recibo el mensaje "Su pedido no puede ser cancelado."
