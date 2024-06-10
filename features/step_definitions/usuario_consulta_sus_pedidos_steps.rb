When(/^que el Usuario "([^"]*)" está registrado en el Telegram de la Bobe$/) do |nombre|
  @request = {nombre: nombre,
              direccion: 'La Pampa 123',
              telefono: 1234567855,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(201)
  @id_de_otro = @id_ultimo_usuario_registrado
  @id_ultimo_usuario_registrado += 1
end

When(/^que pide el menu "([^"]*)"$/) do |menu|
  @request = {menu: menu,
              usuario: 'Juan',
              id_usuario: @id_de_otro
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
end

When(/^consulto el pedido como si fuera mio$/) do
  parsed_response = JSON.parse(@response.body)
  @response = Faraday.get(estado_pedido_url + "/#{@mi_id}/#{parsed_response['id']}")
end

When(/^que me registro en el Telegram de la Bobe$/) do
  @request = {nombre: 'yo',
              direccion: 'La Pampa 123',
              telefono: 12345678,
              id_usuario: @id_ultimo_usuario_registrado
  }.to_json
  @response = Faraday.post(create_user_url, @request, header)
  expect(@response.status).to eq(201)
  @mi_id = @id_ultimo_usuario_registrado
  @id_ultimo_usuario_registrado += 1
end

When(/^yo pido el menu "([^"]*)"$/) do |menu|
  @request = {menu: menu,
              usuario: 'Juan',
              id_usuario: @mi_id
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
end

When(/^que no hay usuarios registrados en el Telegram de la Bobe$/) do
  @id_ultimo_usuario_registrado = 1
end

When(/^que no hay usuarios registrados con id (\d+) en el Telegram de la Bobe$/) do |id|
  @response = Faraday.get(find_user_url id)
  expect(@response.status).to eq(404)
end

When(/^pido el menu "([^"]*)" con id de usuario (\d+)$/) do |menu, id|
  @request = {menu: menu,
              usuario: 'Juan',
              id_usuario: id
  }.to_json
  @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
end
