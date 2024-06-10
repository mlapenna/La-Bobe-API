#language: es

Característica: US12 Calificar un pedido sólo si fue entregado
  Una vez que recibo un pedido
  entonces puedo calificar el mismo

  Antecedentes:
    Dado que ya estoy registrado como usuario en el Telegram de la Bobe
    Dado que el repartidor "Ale con bici" está registrado
    Dado que no llueve

  # @bot
  # Antecedentes:
  #  Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
  #  Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
  #  Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' http://webapi-bobe-test.herokuapp.com/mock_lluvia_activar

  Escenario: US12-01 - Cuando el pedido se encuentra en estado recibido, no puede calificarse
    Dado que existe un pedido menu "Individual"
    Cuando quiero calificar el pedido
    Entonces recibo el mensaje con el error "El pedido no se puede calificar"

  @bot
  Escenario: US12-01 - Cuando el pedido se encuentra en estado recibido, no puede calificarse
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando quiero calificar con el comando /calificar_pedido <id_pedido_generado> :  <calificación>
    Entonces recibo el mensaje con el error "El pedido no se puede calificar"

  Escenario: US12-02 - Cuando el pedido se encuentra en estado preparando, no puede calificarse
    Dado que existe un pedido menu "Individual"
    Cuando progreso el estado del pedido
    Cuando quiero calificar el pedido
    Entonces recibo el mensaje con el error "El pedido no se puede calificar"

  @bot
  Escenario: US12-02 - Cuando el pedido se encuentra en estado preparando, no puede calificarse
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando quiero calificar con el comando /calificar_pedido <id_pedido_generado> : <calificación>
    Entonces recibo el mensaje con el error "El pedido no se puede calificar"

  Escenario: US12-03 - Cuando el pedido se encuentra en estado enviando, no puede calificarse
    Dado que existe un pedido menu "Individual"
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando quiero calificar el pedido
    Entonces recibo el mensaje con el error "El pedido no se puede calificar"

  @bot
  Escenario: US12-03 - Cuando el pedido se encuentra en estado enviando, no puede calificarse
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando quiero calificar con el comando /calificar_pedido <id_pedido_generado> :  <calificación>
    Entonces recibo el mensaje con el error "El pedido no se puede calificar"

  Escenario: US12-04 - Cuando el pedido se encuentra en estado entregado, puede calificarse
    Dado que existe un pedido menu "Individual"
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando quiero calificar el pedido
    Entonces recibo el mensaje por calificar "Gracias por su calificación"

  @bot
  Escenario: US12-04 - Cuando el pedido se encuentra en estado entregado, puede calificarse
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando quiero calificar con el comando /calificar_pedido <id_pedido_generado> : <calificación>
    Entonces recibo el mensaje por calificar "Gracias por su calificación"

  Escenario: US12-05 - Cuando el pedido se encuentra en estado entregado, y ya fue calificado, la calificación se actualiza
    Dado que existe un pedido menu "Individual"
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando progreso el estado del pedido
    Cuando quiero calificar el pedido
    Entonces recibo el mensaje por calificar "Gracias por su calificación"
    Cuando quiero volver a calificar el pedido
    Entonces recibo el mensaje por calificar "Calificación actualizada"

  @bot
  Escenario: US12-05 - Cuando el pedido se encuentra en estado entregado, y ya fue calificado, la calificación se actualiza
    Dado que consulto las opciones de menu con el comando /menu
    Cuando pido el menu individual con el comando /pedir Individual
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando ingreso el comando curl -X PUT 'https://webapi-bobe-test.herokuapp.com/progresar_estado' -H 'Content-Type: application/json' -d '{"id":"<id_pedido_generado>"}'
    Cuando quiero calificar con el comando /calificar_pedido <id_pedido_generado> :  <calificación>
    Entonces recibo el mensaje por calificar "Gracias por su calificación"
    Cuando quiero calificar con el comando /calificar_pedido <id_pedido_generado> :  <calificación>
    Entonces recibo el mensaje por calificar "Calificación actualizada"

#Característica: US22 Validar no calificar un pedido con una puntuación invalida
#  Como repartidor
#  Quiero que las calificaciones se hagan dentro de los valores correctos
#  Para cobrar la comisión proporcional

#  Antecedentes:
#    Dado me registro como usuario
#    Dado me registro como repartidor

  # @bot
  # Antecedentes:
    # curl -X POST 'https://webapi-bobe-test.herokuapp.com/reset'
    # Dado que ya registre un usuario con el comando /registracion Ale, Acoyte 123, 1112345678
    # Dado ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'

  Escenario: US22-1 Pedido recibe una calificación de 0 y devuelve error
    Dado que existe un pedido menu "Individual"
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Cuando califico el pedido con puntaje 0
    Entonces recibo el mensaje con el error "Calificación inválida, ingrese un número entero entre 1 y 5"

  @bot
  Escenario: US22-1 Pedido recibe una calificación de 0 y devuelve error
    Dado que realizo un pedido con /pedir Individual
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido <id_del_pedido> : 0
    Entonces se devuelve un error "Calificación inválida, ingrese un número entero entre 1 y 5"

  Escenario: US22-2 Pedido recibe una calificación de 4,2 y devuelve error
    Dado que existe un pedido menu "Individual"
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Cuando califico el pedido con puntaje 4,2
    Entonces recibo el mensaje con el error "Calificación inválida, ingrese un número entero entre 1 y 5"

  @bot
  Escenario: US22-2 Pedido recibe una calificación de 4,2 y devuelve error
    Dado que realizo un pedido con /pedir Individual
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido <id_del_pedido> : 4,2
    Entonces se devuelve un error "Calificación inválida, ingrese un número entero entre 1 y 5"

  Escenario: US22-3 Pedido recibe una calificación de 6 y devuelve error
    Dado que existe un pedido menu "Individual"
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Cuando califico el pedido con puntaje 6
    Entonces recibo el mensaje con el error "Calificación inválida, ingrese un número entero entre 1 y 5"

  @bot
  Escenario: US22-3 Pedido recibe una calificación de 6 y devuelve error
    Dado que realizo un pedido con /pedir Individual
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido <id_del_pedido> : 6
    Entonces se devuelve un error "Calificación inválida, ingrese un número entero entre 1 y 5"

  Escenario: US22-4 Pedido recibe una calificación de una letra y devuelve error
    Dado que existe un pedido menu "Individual"
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Dado progreso el estado del pedido
    Cuando califico el pedido con puntaje "A"
    Entonces recibo el mensaje con el error "Calificación inválida, ingrese un número entero entre 1 y 5"

  @bot
  Escenario: US22-4 Pedido recibe una calificación de una letra y devuelve error
    Dado que realizo un pedido con /pedir Individual
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que ingreso el comando curl -X PUT -d '{"id":<id_del_pedido>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando califico el pedido con /calificar_pedido <id_del_pedido> : A
    Entonces se devuelve un error "Calificación inválida, ingrese un número entero entre 1 y 5"

