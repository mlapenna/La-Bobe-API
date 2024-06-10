#language: es
Característica: US2 Registración básica de repartidor
  Para acceder a la aplicación
  Como un repartidor
  Quiero poder registrarme

  Escenario: Registracion basica de repartidor
    Dado que ingreso mi nombre y apellido "Ale con bici"
    Y ingreso mi dni "10999888"
    Y ingreso mi telefono 1112345678
    Cuando me registro como repartidor
    Entonces recibo el mensaje "Bienvenido repartidor Ale con bici"

  @api
  Escenario: Registracion de repartidor
    Cuando ingreso el comando curl -X POST 'https://webapi-bobe-test.herokuapp.com/repartidor' -H 'Content-Type: application/json' -d '{"nombre":"Ale con bici","dni":"22333444","telefono":"1144445555"}'
    Entonces recibo el mensaje "Bienvenido repartidor Ale con bici"

# Característica: US11 Validar repartidor con nombre y apellido, dni y teléfono no vacíos.

  Escenario: US11-01 Registro fallido por nombre y apellido vacíos
    Dado que ingreso mi nombre y apellido ""
    Y ingreso mi direccion "Acoyte 123"
    Y ingreso mi dni "30303030"
    Y ingreso mi telefono "1112345678"
    Cuando me registro como repartidor
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @api
  Escenario: US11-01 Registro fallido por nombre y apellido vacíos
    Cuando ingreso el comando curl -X POST -d '{"nombre":"","dni":"12345678", "telefono":"112345678"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
    Entonces recibo el mensaje "Registración fallida"

  Escenario: US11-02 Registro fallido por dni vacío
    Dado que ingreso mi nombre y apellido "Ernesto Perez"
    Y ingreso mi dni ""
    Y ingreso mi telefono "1112345678"
    Cuando me registro como repartidor
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @api
  Escenario: US11-02 Registro fallido por dni vacío
    Cuando ingreso el comando curl -X POST -d '{"nombre":"Ernesto Perez", "dni":"", "telefono":"1112345678"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
    Entonces recibo el mensaje "Registración fallida"

  Escenario: US11-03 Registro fallido por teléfono vacío
    Dado que ingreso mi nombre y apellido "Ernesto Perez"
    Y ingreso mi dni "30303030"
    Y ingreso mi telefono ""
    Cuando me registro como repartidor
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @api
  Escenario: US11-03 Registro fallido por teléfono vacío
    Cuando ingreso el comando curl -X POST -d '{"nombre":"Ernesto Perez", "dni":"30303030", "telefono":""}' "https://webapi-bobe-test.herokuapp.com/repartidor",
    Entonces recibo el mensaje "Registración fallida"

  Escenario: US11-04 Registro exitoso con campos completos
    Dado que ingreso mi nombre y apellido "Ernesto Perez"
    Y ingreso mi dni "30303030"
    Y ingreso mi telefono "1112345678"
    Cuando me registro como repartidor
    Entonces recibo el mensaje "Bienvenido repartidor Ernesto Perez"

  @api
  Escenario: US11-04 Registro exitoso con campos completos
    Cuando ingreso el comando /curl -X POST -d '{"nombre":"Ernesto Perez", "dni":"30303030", "telefono":"1112345678"}' "https://webapi-bobe-test.herokuapp.com/repartidor"
    Entonces recibo el mensaje "Bienvenido repartidor Ernesto Perez"
