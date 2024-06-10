#language: es

Característica: US5  Cambiar el estado del pedido de Recibido a Preparando
  Para empezar a preparar un pedido
  Como un dueño del negocio
  Quiero poder progresar el estado del pedido

  Antecedentes:
    # Dado que soy empleado de La Bobe con acceso al sistema
    Dado que ya estoy registrado como usuario en el Telegram de la Bobe
    Dado me registro como repartidor
    Dado pido el menu "Individual"
    Dado que no llueve

#  @bot
#  Antecedentes:
#    Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
#    Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
#    Dado que se pidió un menu Individual con el comando /pedir Individual
#    Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' http://webapi-bobe-test.herokuapp.com/mock_lluvia_activar

  Escenario: Cuando se empieza a preparar el pedido, el estado pasa de Recibido a Preparando
    Dado consulto mi pedido
    Dado el estado del pedido es "Recibido"
    Cuando progreso el estado del pedido
    Cuando consulto mi pedido
    Entonces el estado del pedido es "Preparando"

  @api
  Escenario: Cuando se empieza a preparar el pedido, el estado pasa de Recibido a Preparando
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Recibido"
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Preparando"

#Característica: US6 Cambiar el estado del pedido de Preparando a Enviando (esto incluye la asignación básica de repartidor)
#
#  Antecedentes:
#    Dado me registro como usuario
#    Dado me registro como repartidor
#    Dado pido el menu "Individual"

#  @bot
#  Antecedentes:
#    Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
#    Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
#    Dado que se pidió un menu Individual con el comando /pedir Individual

  Escenario: Cuando el pedido esta listo, el estado pasa a Enviando
    Dado consulto mi pedido
    Dado el estado del pedido es "Recibido"
    Cuando progreso el estado del pedido
    Cuando consulto mi pedido
    Entonces el estado del pedido es "Preparando"
    Cuando progreso el estado del pedido
    Cuando consulto mi pedido
    Entonces el estado del pedido es "Enviando"

  @api
  Escenario: Cuando el pedido esta listo, estado pasa a Enviando
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Recibido"
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Preparando"
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Enviando"

  Escenario: Cuando el estado pasa a Enviando el pedido se le asigna al primer repartidor sin pedidos
    Dado consulto mi pedido
    Dado el estado del pedido es "Recibido"
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Entonces el estado del pedido es "Enviando"
    Y es asignado al primer repartidor sin pedidos

  @api
  Escenario: Cuando el pedido esta listo, estado pasa a Enviando
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Recibido"
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Enviando"
    Y ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/repartidor/<id_repartidor_asignado>' -H "Content-Type: application/json"
    Y el id_pedido es igual a <id_pedido_generado>

#Característica: US7 Cambiar el estado del pedido de Enviando a Entregado
#
#  Antecedentes:
#    Dado me registro como usuario
#    Dado me registro como repartidor
#    Dado pido el menu "Individual"

#  @bot
#  Antecedentes:
#    Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
#    Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
#    Dado que se pidió un menu Individual con el comando /pedir Individual


  Escenario: Cuando el Usuario recibe el pedido, el estado pasa a Entregado
    Dado consulto mi pedido
    Dado el estado del pedido es "Recibido"
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando consulto mi pedido
    Entonces el estado del pedido es "Entregado"

  @api
  Escenario: Cuando el Usuario recibe el pedido, el estado pasa a Entregado
    Dado consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Dado el estado del pedido es "Recibido"
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Y ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/repartidor/<id_repartidor_asignado>' -H "Content-Type: application/json"
    Cuando consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Entonces el estado del pedido es "Entregado"

#Característica: US34 no permitir progresar estado de pedido entregado
#  Para empezar a preparar un pedido
#  Como un dueño del negocio
#  Quiero poder progresar el estado del pedido

#  Antecedentes:
#    Dado que soy empleado de La Bobe con acceso al sistema
#    Dado me registro como usuario
#    Dado me registro como repartidor
#    Dado pido el menu "Individual"

#  @bot
#  Antecedentes:
#    Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
#    Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
#    Dado que se pidió un menu Individual con el comando /pedir Individual


  Escenario: No puedo progresar estado de pedido ya entregado
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Y consulto mi pedido
    Y el estado del pedido es "Entregado"
    Cuando progreso el estado del pedido
    Entonces recibo el mensaje "El pedido no puede progresar su estado, ya fué entregado."

  @api
  Escenario: No puedo progresar estado de pedido ya entregado
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Y consulto mi pedido con el comando /estado_pedido <id_pedido_generado>
    Y el estado del pedido es "Entregado"
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Entonces recibo el mensaje "El pedido no puede progresar su estado, ya fué entregado."


