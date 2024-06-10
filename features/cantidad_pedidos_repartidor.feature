#language: es

Característica: US15 Cantidad variable de pedidos por mochila.

  Antecedentes:
    Dado que ya estoy registrado como usuario en el Telegram de la Bobe
    Dado que no tengo pedidos
    Dado que no tengo repartidores registrados
    Dado que tengo 2 repartidores registrados
    Dado que no llueve

#  @api
#  curl -X POST 'https://webapi-bobe-test.herokuapp.com/reset' -d ''
#  Cuando ingreso el comando curl -X POST -d '{"nombre":"Ernesto", "dni":"12345678", "telefono":"112345678"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
#  Cuando ingreso el comando curl -X POST -d '{"nombre":"Mario", "dni":"12345678", "telefono":"112345678"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
#  Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' http://webapi-bobe-test.herokuapp.com/mock_lluvia_activar

  Escenario: US15-1 - Cuando hago 2 pedidos individuales, entran en la misma mochila
    Dado pido 2 pedidos tipo "Individual"
    Cuando progreso el estado de todos mis pedidos
    Cuando progreso el estado de todos mis pedidos
    Entonces todos los pedidos se le asignaron al repartidor registrado en el lugar 0

  @api
  Escenario: US15-1 - Cuando hago 2 pedidos individuales, entran en la misma mochila
    Dado Pido el menu individual con el comando /pedir Individual
    Dado el menu individual con el comando /pedir Individual
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces todos los pedidos se le asignaron al repartidor registrado en el lugar 0 (el primer repartidor registrado, en este caso, Ernesto)


  Escenario: US15-2 - Cuando hago un pedido individual y otro pareja, entran en la misma mochila
    Dado pido 1 pedidos tipo "Individual"
    Dado pido 1 pedidos tipo "Pareja"
    Cuando progreso el estado de todos mis pedidos
    Cuando progreso el estado de todos mis pedidos
    Entonces todos los pedidos se le asignaron al repartidor registrado en el lugar 0

  @api
  Escenario: US15-2 - Cuando hago un pedido individual y otro pareja, entran en la misma mochila
    Dado Pido el menu individual con el comando /pedir Individual
    Dado el menu individual con el comando /pedir Pareja
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces todos los pedidos se le asignaron al repartidor registrado en el lugar 0 (el primer repartidor registrado, en este caso, Ernesto)

  Escenario: US15-3 - Cuando pido un Individual y un Familiar, se asignan a dos repartidores diferentes
    Dado pido 1 pedidos tipo "Individual"
    Dado pido 1 pedidos tipo "Familiar"
    Cuando progreso el estado de todos mis pedidos
    Cuando progreso el estado de todos mis pedidos
    Entonces el pedido 0 se le asigno al repartidor registrado en el lugar 0
    Entonces el pedido 1 se le asigno al repartidor registrado en el lugar 1


  @api
  Escenario: US15-3 - Cuando pido un Individual y un Familiar, se asignan a dos repartidores diferentes
    Dado Pido el menu individual con el comando /pedir Individual
    Dado el menu individual con el comando /pedir Familiar
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces el pedido 0 (Individual) se le asigno al repartidor registrado en el lugar 0 (el primer repartidor registrado, en este caso, Ernesto)
    Entonces el pedido 1 (Familiar) se le asigno al repartidor registrado en el lugar 1 (el segundo repartidor registrado, en este caso, Mario)


  Escenario: US15-4 - Cuando pido un menú pareja, luego otro pareja y luego un individual, el primero y el tercero se asignan a la misma mochila y el segundo a otra
    Dado pido 2 pedidos tipo "Pareja"
    Dado pido 1 pedidos tipo "Individual"
    Cuando progreso el estado de todos mis pedidos
    Cuando progreso el estado de todos mis pedidos
    Entonces el pedido 0 se le asigno al repartidor registrado en el lugar 0
    Entonces el pedido 1 se le asigno al repartidor registrado en el lugar 1
    Entonces el pedido 2 se le asigno al repartidor registrado en el lugar 0


  @api
  Escenario: US15-4 - Cuando pido un menú pareja, luego otro pareja y luego un individual, el primero y el tercero se asignan a la misma mochila y el segundo a otra
    Dado Pido el menu individual con el comando /pedir Pareja
    Dado Pido el menu individual con el comando /pedir Pareja
    Dado Pido el menu individual con el comando /pedir Individual
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces el pedido 0 (Pareja) se le asigno al repartidor registrado en el lugar 0 (el primer repartidor registrado, en este caso, Ernesto)
    Entonces el pedido 1 (Pareja) se le asigno al repartidor registrado en el lugar 1 (el segundo repartidor registrado, en este caso, Mario)
    Entonces el pedido 2 (Individual) se le asigno al repartidor registrado en el lugar 0 (el primer repartidor registrado, en este caso, Ernesto)


  Escenario: US15-5 - Cuando pido tres menúes Familiar ya no hay repartidores disponibles porque no entran en dos mochilas
    Cuando pido 3 pedidos tipo "Familiar"
    Cuando progreso el estado de todos mis pedidos
    Cuando progreso el estado de todos mis pedidos
    Entonces se recibe un mensaje "No hay repartidores disponibles"

  @api
  Escenario: US15-5 - Cuando pido tres menúes Familiar ya no hay repartidores disponibles porque no entran en dos mochilas
    Dado Pido el menu individual con el comando /pedir Familiar
    Dado Pido el menu individual con el comando /pedir Familiar
    Dado Pido el menu individual con el comando /pedir Familiar
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando progreso el estado de mi pedido con el comando curl -X PUT -d '{"id":<ID_PEDIDO_3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces el pedido 0 (Familiar) se le asigno al repartidor registrado en el lugar 0 (el primer repartidor registrado, en este caso, Ernesto)
    Entonces el pedido 1 (Familiar) se le asigno al repartidor registrado en el lugar 1 (el segundo repartidor registrado, en este caso, Mario)
    Entonces recibo el mensaje "{"respuesta":"No hay repartidores disponibles"}
