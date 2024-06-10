#language: es

Característica: US23 Cálculo de comisiones básico (sin tener en cuenta calificaciones)
  Para conocer mis honorarios
  Como repartidor
  Quiero poder consultar la comisión de un pedido

  Antecedentes:
    Dado que me registro como usuario
    Dado me registro como repartidor
    Dado que no llueve

  # @bot
  # Antecedentes:
    # curl -X POST 'https://webapi-bobe-test.herokuapp.com/reset'
    # Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
    # Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
    # Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' http://webapi-bobe-test.herokuapp.com/mock_lluvia_activar

  Escenario: US23-1 Repartidor recibe comision del 5% al entregar pedido Individual
    Dado que pido el menu "Individual"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Y es asignado al primer repartidor sin pedidos
    Dado que progreso el estado del pedido
    Entonces el repartidor recibe una comision de $50 por el pedido

  @bot
  Escenario: US23-1 Repartidor recibe comision del 5% al entregar pedido Individual
    Dado que se pidió un menu Individual con el comando /pedir Individual
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Y veo que tiene asignado un repartidor
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Y ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>' -H "Content-Type: application/json"
    Entonces verifico que la comisión es de $50

  Escenario: US23-2 Repartidor recibe comision del 5% al entregar pedido Pareja
    Dado pido el menu "Familiar"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Y es asignado al primer repartidor sin pedidos
    Dado que progreso el estado del pedido
    Entonces el repartidor recibe una comision de $125 por el pedido

  @api
  Escenario: US23-2 Repartidor recibe comision del 5% al entregar pedido Familiar
    Dado que se pidió un menu Individual con el comando /pedir Pareja
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Y veo que tiene asignado un repartidor
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Y ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>' -H "Content-Type: application/json"
    Entonces verifico que la comisión es de $75

  Escenario: US23-3 Repartidor recibe comision del 5% al entregar pedido Familiar
    Dado pido el menu "Familiar"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Y es asignado al primer repartidor sin pedidos
    Dado que progreso el estado del pedido
    Entonces el repartidor recibe una comision de $125 por el pedido

  @api
  Escenario: US23-3 Repartidor recibe comision del 5% al entregar pedido Familiar
    Dado que se pidió un menu Individual con el comando /pedir Familiar
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Y veo que tiene asignado un repartidor
    Dado ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_del_pedido>"}'
    Y ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>' -H "Content-Type: application/json"
    Entonces verifico que la comisión es de $125

#Característica: US24 Cálculo de comisiones con calificación.
#  Como repartidor
#  Quiero que las calificaciones apliquen a mis pedidos
#  Para cobrar la comisión proporcional

  Escenario: US24-1 Pedido recibe una calificación de 1 y la comisión es de 3%
    Dado que existe un pedido menu "Individual"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Cuando califico el pedido con puntaje 1
    Entonces el repartidor recibe una comision de $30 por el pedido

  @bot
  Escenario: US24-1 Pedido recibe una calificación de 1 y la comisión es de 3%
    Dado que realizo un pedido con /pedir Individual
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido 1 : 1
    Entonces ingreso el comando curl -X GET -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
    Entonces verifico que el monto no es 5% sino 3% o sea $30

  Escenario: US24-2 Pedido recibe una calificación de 2 y la comisión es de 5%
    Dado que existe un pedido menu "Pareja"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Cuando califico el pedido con puntaje 2
    Entonces el repartidor recibe una comision de $75 por el pedido

  @bot
  Escenario: US24-2 Pedido recibe una calificación de 2 y la comisión es de 5%
    Dado que realizo un pedido con /pedir Pareja
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido 1 : 2
    Entonces ingreso el comando curl -X GET -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
    Entonces verifico que el monto es $75

  Escenario: US24-3 Pedido recibe una calificación de 3 y la comisión es de 5%
    Dado que existe un pedido menu "Familiar"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Cuando califico el pedido con puntaje 3
    Entonces el repartidor recibe una comision de $125 por el pedido

  @bot
  Escenario: US24-3 Pedido recibe una calificación de 3 y la comisión es de 5%
    Dado que realizo un pedido con /pedir Familiar
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'id_del_pedido>'
    Cuando califico el pedido con /calificar_pedido 1 : 3
    Entonces ingreso el comando curl -X GET -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
    Entonces verifico que el monto es $150

  Escenario: US24-4 Pedido recibe una calificación de 4 y la comisión es de 5%
    Dado que existe un pedido menu "Pareja"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Cuando califico el pedido con puntaje 4
    Entonces el repartidor recibe una comision de $75 por el pedido

  @bot
  Escenario: US24-4 Pedido recibe una calificación de 4 y la comisión es de 5%
    Dado que realizo un pedido con /pedir Pareja
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido 1 : 4
    Entonces ingreso el comando curl -X GET -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
    Entonces verifico que el monto es $75

  Escenario: US24-5 Pedido recibe una calificación de 5 y la comisión es de 7%
    Dado que existe un pedido menu "Pareja"
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Dado que progreso el estado del pedido
    Cuando califico el pedido con puntaje 5
    Entonces el repartidor recibe una comision de $105 por el pedido

  @bot
  Escenario: US24-5 Pedido recibe una calificación de 5 y la comisión es de 7%
    Dado que realizo un pedido con /pedir Pareja
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido 1 : 5
    Entonces ingreso el comando curl -X GET -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
    Entonces verifico que el monto es $105
