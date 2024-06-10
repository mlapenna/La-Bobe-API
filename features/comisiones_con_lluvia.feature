##language: es
#
#Característica: US25 Cálculo de comisiones con día de lluvia
#  Como repartidor
#  Quiero que sea tenido en cuenta si está lloviendo
#  Para cobrar una comisión mayor
#
#  Antecedentes:
#    Dado que ya estoy registrado como usuario en el Telegram de la Bobe
#    Dado que el repartidor "Ale con bici" está registrado
#
#  # @bot
#  # Antecedentes:
#    # curl -X POST 'https://webapi-bobe-test.herokuapp.com/reset'
#    #  Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
#    #  Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
#
#  Escenario: US25-1 Pedido entregado en día de lluvia recibe 1% adicional
#    Dado que existe un pedido menu "Individual"
#    Dado que llueve
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Entonces el repartidor recibe una comision de $60 por el pedido
#
#  @bot
#  Escenario: US25-1 Pedido entregado en día de lluvia recibe 1% adicional
#    Dado que realizo un pedido con /pedir Individual
#    Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":true}' 'https://webapi-bobe-test.herokuapp.com/mock_lluvia_activar'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Entonces ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
#    Entonces verifico que el monto no es 5% sino 6% o sea $60
#
#  Escenario: US25-2 Pedido entregado en día no lluvioso no recibe porcentaje adicional
#    Dado que existe un pedido menu "Individual"
#    Dado que no llueve
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Entonces el repartidor recibe una comision de $50 por el pedido
#
#  @bot
#  Escenario: US25-2 Pedido entregado en día no lluvioso no recibe porcentaje adicional
#    Dado que realizo un pedido con /pedir Individual
#    Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' 'https://webapi-bobe-test.herokuapp.com/mock_lluvia_activar'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Entonces ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
#    Entonces verifico que el monto es 5% o sea $50
#
#  Escenario: US25-3 Pedido entregado en día lluvioso con calificación 5 recibe porcentaje adicional
#    Dado que existe un pedido menu "Individual"
#    Dado que llueve
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Cuando califico el pedido con puntaje 5
#    Entonces el repartidor recibe una comision de $80 por el pedido
#
#  @bot
#  Escenario: US25-3 Pedido entregado en día lluvioso con calificación 5 recibe porcentaje adicional
#    Dado que realizo un pedido con /pedir Individual
#    Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":true}' 'https://webapi-bobe-test.herokuapp.com/mock_lluvia_activar'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Cuando califico el pedido con /calificar_pedido <id_del_pedido> : 5
#    Entonces ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
#    Entonces verifico que el monto no es 7% sino 8% o sea $80
#
#  Escenario: US25-4 Pedido entregado en día lluvioso sin calificación recibe porcentaje adicional
#    Dado que existe un pedido menu "Familiar"
#    Dado que llueve
#    Dado progreso el estado del pedido
#    Dado progreso el estado del pedido
#    Cuando progreso el estado del pedido
#    Entonces el repartidor recibe una comision de $150 por el pedido
#
#  @bot
#  Escenario: US25-4 Pedido entregado en día lluvioso sin calificación recibe porcentaje adicional
#    Dado que realizo un pedido con /pedir Familiar
#    Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":true}' 'https://webapi-bobe-test.herokuapp.com/mock_lluvia_activar'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Cuando ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
#    Entonces ingreso el comando curl -X GET 'https://webapi-bobe-test.herokuapp.com/comision_pedido/<id_del_pedido>'
#    Entonces verifico que el monto no es 5% sino 6% o sea $150
#
