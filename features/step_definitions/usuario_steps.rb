Dado('que ingreso mi nombre {string}') do |nombre|
  @nombre = nombre
end

Dado('ingreso mi direccion {string}') do |direccion|
  @direccion = direccion
end

Dado('ingreso mi telefono {int}') do |telefono|
  @telefono = telefono
end

Dado('ingreso mi telefono {string}') do |telefono|
  @telefono = telefono
end

Cuando('me registro como usuario') do
  @id_ultimo_usuario_registrado = 1
  @request = {nombre: @nombre,
              direccion: @direccion,
              telefono: @telefono,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
end

Entonces('recibo el mensaje {string}') do |mensaje|
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['respuesta']).to include(mensaje)
end

When(/^ingreso mi dni "([^"]*)"$/) do |dni|
  @dni = dni
end

When(/^que ingreso mi nombre y apellido "([^"]*)"$/) do |nombre_y_apellido|
  @nombre = nombre_y_apellido
end

When(/^me registro como repartidor$/) do
  @request = {nombre: @nombre || "Mariano",
              dni: @dni || 22333444,
              telefono: @telefono || 1144445555
  }.to_json
  @response = Faraday.post(create_repartidor_url, @request, header)
end

Entonces('recibo el mensaje de error de registración {string}') do |mensaje|
  expect(@response.status).to eq(400)
  parsed_response = JSON.parse(@response.body)
  expect(mensaje).to eq(parsed_response['respuesta'])
end

When(/^que ya existe un usuario registrado con telefono "([^"]*)"$/) do |telefono|
  @id_ultimo_usuario_registrado = 99
  @request = {nombre: "William",
              direccion: "Acoyte 222",
              telefono: telefono,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
end
