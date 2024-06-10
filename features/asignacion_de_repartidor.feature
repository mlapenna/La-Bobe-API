#language: es

Característica: US21 Elegir a qué repartidor asignar el pedido

  Antecedentes:
    Dado que el repartidor "Ernesto" está registrado
    Dado que el repartidor "Lucas" está registrado
    Dado que el Usuario "Pablo" está registrado
    Dado que existe un pedido "1" para "Pablo"
    Dado que no llueve

  # @api
  # curl -X POST 'https://webapi-bobe-test.herokuapp.com/reset' -d ''
  # Cuando ingreso el comando curl -X POST -d '{"nombre":"Ernesto", "dni":"12345678", "telefono":"112345678"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
  # Cuando ingreso el comando curl -X POST -d '{"nombre":"Lucas", "dni":"12345679", "telefono":"112345679"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
  # Dado que ya registre un usuario con el comando /registracion Pablo, Acoyte 123, 1112345678
  # Dado que realizo un pedido con /pedir Individual
  # Dado que ingreso el comando curl -X PUT -d '{"esta_lloviendo":false}' http://webapi-bobe-test.herokuapp.com/mock_lluvia_activar

  Escenario: US21-1 - Cuando el pedido esté listo, se asigna al repartidor "Ernesto" y el estado pasa a Enviando
    Dado que el repartidor "Ernesto" no tiene pedidos
    Dado que el repartidor "Lucas" no tiene pedidos
    Cuando el estado del pedido "1" pasa de "Recibido" a "Preparando"
    Cuando el estado del pedido "1" pasa de "Preparando" a "Enviando"
    Entonces el mismo se asigna al repartidor "Ernesto"

  @api
  Escenario: US21-1 - Cuando el pedido esté listo, se asigna al repartidor "Ernesto" y el estado pasa a Enviando
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'

  Escenario: US21-2 - Cuando el pedido está listo, se asigna al primer repartidor disponible siendo que ya hay un repartidor ocupado
    Dado que el repartidor "Ernesto" tiene pedidos
    Dado que el repartidor "Lucas" no tiene pedidos
    Cuando el estado del pedido "1" pasa de "Recibido" a "Preparando"
    Cuando el estado del pedido "1" pasa de "Preparando" a "Enviando"
    Entonces el mismo se asigna al repartidor "Lucas"

  @api
  Escenario: US21-2 - Cuando el pedido está listo, se asigna al primer repartidor disponible siendo que ya hay un repartidor ocupado
    Dado que realizo otro pedido con /pedir Individual
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'


  Escenario: US21-3 - Cuando el pedido está listo, no se puede asignar a repartidores porque están todos ocupados
    Dado que el repartidor "Ernesto" tiene pedidos
    Dado que el repartidor "Lucas" tiene pedidos
    Cuando el estado del pedido "1" pasa de "Recibido" a "Preparando"
    Cuando el estado del pedido "1" pasa de "Preparando" a "Enviando"
    Entonces se recibe un mensaje "No hay repartidores disponibles"

  @api
  Escenario: US21-3 - Cuando el pedido está listo, no se puede asignar a repartidores porque están todos ocupados
    Dado que realizo otro pedido con /pedir Individual
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que realizo otro pedido con /pedir Individual
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces recibo el mensaje "{"respuesta":"No hay repartidores disponibles"}

  Escenario: US21-4 - Cuando el pedido está listo, y un repartidor ya entregó su pedido, se le asigna a él.
    Dado que el repartidor "Ernesto" tiene pedidos
    Dado que el repartidor "Lucas" tiene pedidos
    Cuando el estado del pedido "3" pasa de "Enviando" a "Entregado"
    Dado que realizo un nuevo pedido
    Cuando el estado del pedido "1" pasa de "Recibido" a "Preparando"
    Cuando el estado del pedido "1" pasa de "Preparando" a "Enviando"
    Entonces el mismo se asigna al repartidor "Lucas"

  @api
  Escenario: US21-4 - Cuando el pedido está listo, y un repartidor ya entregó su pedido, se le asigna a él.
    Dado que realizo otro pedido con /pedir Individual
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Dado que realizo otro pedido con /pedir Individual
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 3>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 2>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'

  Escenario: US21-5 - Cuando el pedido está listo, no se puede asignar a repartidores porque no hay repartidores creados
    Dado que no existen repartidores
    Cuando el estado del pedido "1" pasa de "Recibido" a "Preparando"
    Cuando el estado del pedido "1" pasa de "Preparando" a "Enviando"
    Entonces se recibe un mensaje "No hay repartidores disponibles"

  @api
  Escenario: US21-5 - Cuando el pedido está listo, no se puede asignar a repartidores porque no hay repartidores creados
    Cuando ingreso el comando curl -X DELETE 'https://webapi-bobe-test.herokuapp.com/repartidor'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Cuando ingreso el comando curl -X PUT -d '{"id":<id pedido 1>}' 'https://webapi-bobe-test.herokuapp.com/progresar_estado'
    Entonces recibo el mensaje "{"respuesta":"No hay repartidores disponibles"}
