require_relative '../fachada/la_bobe'
require_relative '../helpers/pedido_helper'
WebTemplate::App.controllers :pedido, :provides => [:json] do
  get :index do
    todos_los_pedidos = LaBobe.get_todos_los_pedidos
    pedidos_a_json todos_los_pedidos
  end

  get :show, :map => '/pedidos/:id_usuario', :with => :id do
    begin
      pedido = LaBobe.get_pedido_de_usuario(params[:id_usuario], params[:id])

      pedido_hash = pedido_a_hash pedido
      pedido_hash.merge!(respuesta: respuesta_estado(pedido.estado).to_s)
      pedido_hash.to_json
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    rescue UsuarioNoTienePermisosParaConsultarElPedido => e
      status 405
      {respuesta: 'El pedido pertenece a otra persona'}.to_json
    end
  end

  get :show, :map => '/comision_pedido', :with => :id do
    begin
      pedido = LaBobe.get_pedido params[:id]
      {monto: pedido.comision}.to_json
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/pedidos_de_usuario' do
    begin
      nuevo_pedido = LaBobe.crear_pedido_con_usuario_registrado(pedido_params[:menu], pedido_params[:usuario], pedido_params[:id_usuario])
      status 201
      pedido_a_json nuevo_pedido
    rescue ErrorMenuInexistente => e
      status 406
      {respuesta: 'Pedido fallido elija una opcion valida'}.to_json
    rescue UsuarioInvalido => e
      status 400
      {respuesta: 'Primero debes registrarte para poder realizar un pedido'}.to_json
    end
  end

  put :actualizar, :map => '/progresar_estado' do
    begin
      pedido_actualizado = LaBobe.progresar_estado_pedido pedido_params[:id]

      status 200
      pedido_a_json pedido_actualizado
    rescue ErrorObjetoNoEncontrado => e
      status 404
    rescue ErrorNoHayRepartidores => e
      status 405
      pedido = pedido_repo.buscar(pedido_params[:id])
      pedido_hash = pedido_a_hash pedido
      pedido_hash.merge!(respuesta: "No hay repartidores disponibles")
      pedido_hash.to_json
    rescue PedidoYaEntregadoNoPuedeSerProgresado => e
      status 406
      {respuesta: "El pedido no puede progresar su estado, ya fué entregado."}.to_json
    rescue PedidoCanceladoNoPuedeSerProgresado => e
      status 407
      {respuesta: "El pedido no puede progresar su estado, fué cancelado."}.to_json
    end
  end

  put :activate, :map => '/calificar_pedido' do
    begin
      pedido = pedido_repo.buscar(pedido_params[:id_pedido])
      actualizado = LaBobe.calificar_pedido(pedido, pedido_params[:puntaje])
      pedido_actualizado = pedido_repo.guardar(pedido)

      status 200
      pedido_hash = pedido_a_hash pedido_actualizado
      if !actualizado
        pedido_hash.merge!(respuesta: "Gracias por su calificación")
      else
        pedido_hash.merge!(respuesta: "Calificación actualizada")
      end
      pedido_hash.to_json
    rescue ErrorObjetoNoEncontrado => e
      status 405
      {error: e.message}.to_json
    rescue ErrorElPedidoNoPuedeCalificarse => e
      status 405
      pedido_hash = pedido_a_hash pedido
      pedido_hash.merge!(respuesta: "El pedido no se puede calificar")
      pedido_hash.to_json
    rescue CalificacionInvalida => e
      status 405
      {respuesta: "Calificación inválida, ingrese un número entero entre 1 y 5"}.to_json
    end
  end

  put :cancel, :map => '/cancelar_pedido', :with => :id  do
    begin
      pedido = pedido_repo.buscar(params[:id])
      pedido.cancelar
      pedido_actualizado = pedido_repo.guardar(pedido)
      status 200

      pedido_hash = pedido_a_hash pedido_actualizado
      pedido_hash.merge!(respuesta: "Su pedido fue cancelado exitosamente.")
      pedido_hash.to_json

    rescue ErrorElPedidoNoSePuedeCancelar => e
      status 405
      pedido_hash = pedido_a_hash pedido
      pedido_hash.merge!(respuesta: "Su pedido no puede ser cancelado.")
      pedido_hash.to_json
    end
  end

  delete :destruir, :map => '/pedidos', :with => :id do
    begin
      LaBobe.borrar_pedido params[:id]

      status 200
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end

  delete :destruir, :map => '/pedidos' do
    begin
      pedido_repo.borrar_todos

      status 200
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end
end
