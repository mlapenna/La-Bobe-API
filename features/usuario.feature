#language: es
Característica: US1 Registracion de Usuario
  Para acceder a la aplicación
  Como un usuario
  Quiero poder registrarme

  Escenario: US1-01 - Registración básica de usuario
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion "Acoyte 123"
    Y ingreso mi telefono "1456789"
    Cuando me registro como usuario
    Entonces recibo el mensaje "Bienvenido Ale"

  @bot
  Escenario: Registración básica de usuario
    Cuando ingreso el comando /registracion Ale, Acoyte 123, 1456789
    Entonces recibo el mensaje "Bienvenido Ale"

#Característica: US10 Validar usuario nombre, dirección, teléfono completos
  Escenario: Registro fallido por nombre vacío
    Dado que ingreso mi nombre ""
    Y ingreso mi direccion "Acoyte 123"
    Y ingreso mi telefono "1112345678"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallido por nombre vacío
    Cuando ingreso el comando /registracion , Acoyte 123, 1112345678
    Entonces recibo el mensaje "Registración fallida"

  Escenario: Registro fallido tamaño de nombre mayor a 20 caracteres
    Dado que ingreso mi nombre "abcdefghijklmnopqrstuvwxyz"
    Y ingreso mi direccion "Acoyte 123"
    Y ingreso mi telefono "1112345678"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallido por nombre de tamaño mayor a 20 caracteres
    Cuando ingreso el comando /registracion abcdefghijklmnopqrstuvwxyz, Acoyte 123, 1112345678
    Entonces recibo el mensaje "Registración fallida"

  Escenario: Registro exitoso con nombre de tamaño igual a 20 caracteres
    Dado que ingreso mi nombre "abcdefghijklmnopqrst"
    Y ingreso mi direccion "Acoyte 123"
    Y ingreso mi telefono "9"
    Cuando me registro como usuario
    Entonces recibo el mensaje "Bienvenido abcdefghijklmnopqrst"

  @bot
  Escenario: Registro exitoso con nombre de tamaño igual a 20 caracteres
    Cuando ingreso el comando /registracion abcdefghijklmnopqrst, Acoyte 123, 9
    Entonces recibo el mensaje "Bienvenido abcdefghijklmnopqrst"

  Escenario: Registro fallido por dirección vacía
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion ""
    Y ingreso mi telefono "1112345678"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallida por dirección vacía
    Cuando ingreso el comando /registracion Ale, , 1112345678
    Entonces recibo el mensaje "Registración fallida"


  Escenario: Registro fallido por dirección de tamaño menor a 5 caracteres
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion "Acoy"
    Y ingreso mi telefono "1112345678"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallida por direccion de tamaño menor a 5 caracteres
    Cuando ingreso el comando /registracion Ale, Acoy, 1112345678
    Entonces recibo el mensaje "Registración fallida"

  Escenario: Registro exitoso con dirección de tamaño igual a 5 caracteres
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion "Acoyt"
    Y ingreso mi telefono "117"
    Cuando me registro como usuario
    Entonces recibo el mensaje "Bienvenido Ale"

  @bot
  Escenario: Registro exitoso con dirección de tamaño igual a 5 caracteres
    Cuando ingreso el comando /registracion Ale, Acoyt, 117
    Entonces recibo el mensaje "Bienvenido Ale"

  Escenario: Registro fallido por teléfono vacío
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion "Acoyte 123"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallido por teléfono vacío
    Cuando ingreso el comando /registracion Ale, Acoyte 123, # (importante poner un espacio luego de la ultima ',')
    Entonces recibo el mensaje "Registración fallida"

  Escenario: Registro fallido por ingresar teléfono no numérico
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion "Acoy"
    Y ingreso mi telefono "esto no es un telefono jaja"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallida por ingresar telefono no numerico
    Cuando ingreso el comando /registracion Ale, Acoyte 123, esto no es un telefono jaja
    Entonces recibo el mensaje "Registración fallida"


# Característica: US9 Validar usuario único por teléfono.

  Escenario: Registro fallido de usuario por telefono en uso
    Dado que ya existe un usuario registrado con telefono "12345678"
    Dado que ingreso mi nombre "Ale"
    Y ingreso mi direccion "Acoyte 123"
    Y ingreso mi telefono "12345678"
    Cuando me registro como usuario
    Entonces recibo el mensaje de error de registración "Registración fallida"

  @bot
  Escenario: Registro fallido de usuario por telefono en uso
    Cuando ingreso el comando /registracion Julio, Belgrano 222, 12345678
    Cuando ingreso el comando /registracion Ale, Acoyte 123, 12345678
    Entonces recibo el mensaje "Registración fallida"

