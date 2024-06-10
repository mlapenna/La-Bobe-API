When(/^pido (\d+) pedidos tipo "([^"]*)"$/) do |cantidad_de_pedidos, tipo_de_pedido|
  (1..cantidad_de_pedidos).each {
    @request = { menu: tipo_de_pedido,
                 usuario: "Juan",
                 id_usuario: @id_ultimo_usuario_registrado
    }.to_json
    @response = Faraday.post(create_pedido_de_usuario_url, @request, header)
    expect(@response.status).to eq(201)
    parsed_response = JSON.parse(@response.body)
    @id_pedidos.append(parsed_response['id'])
  }
end

When(/^progreso el estado de todos mis pedidos$/) do
  @id_pedidos.each do |id_pedido|
    @request = { usuario: 'Juan',
                 id: id_pedido
    }.to_json
    @response = Faraday.put(progresar_estado_pedido_url, @request, header)
  end
end

When(/^que tengo (\d+) repartidores registrados$/) do |cantidad_repartidores|
  (1..cantidad_repartidores).each {
    @request = { nombre: @repartidor || "Mariano",
                 dni: @dni || 22333444,
                 telefono: @telefono || 1144445555
    }.to_json
    @response = Faraday.post(create_repartidor_url, @request, header)
    expect(@response.status).to eq(201)
    parsed_response = JSON.parse(@response.body)
    @id_repartidores.append(parsed_response['id'])
  }
end

When(/^todos los pedidos se le asignaron al repartidor registrado en el lugar (\d+)$/) do |indice_id_repartidor|
  expect(@id_repartidores[indice_id_repartidor]).not_to be_nil
  @response = Faraday.get(devolver_repartidor_url + "/#{@id_repartidores[indice_id_repartidor]}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  @id_pedidos.each do |id_pedido|
    expect(parsed_response['id_pedido']).to include(id_pedido.to_i)
  end
end

When(/^el pedido (\d+) se le asigno al repartidor registrado en el lugar (\d+)$/) do |indice_id_pedido ,indice_id_repartidor|
  expect(@id_repartidores[indice_id_repartidor]).not_to be_nil
  @response = Faraday.get(devolver_repartidor_url + "/#{@id_repartidores[indice_id_repartidor]}")
  expect(@response.status).to eq(200)
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['id_pedido']).to include(@id_pedidos[indice_id_pedido].to_i)
end

When(/^que no tengo pedidos$/) do
  @id_pedidos = []
end

When(/^que no tengo repartidores registrados$/) do
  @id_repartidores = []
end
