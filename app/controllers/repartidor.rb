require_relative '../fachada/la_bobe'

WebTemplate::App.controllers :repartidor, :provides => [:json] do
  get :index do
    todos_los_repartidores = repartidor_repo.todos
    usuarios_a_json todos_los_repartidores
  end

  get :show, :map => '/repartidor', :with => :id do
    begin
      repartidor_id = params[:id]
      repartidor = repartidor_repo.buscar(repartidor_id)

      repartidor_a_json repartidor
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/repartidor' do
    begin
      nuevo_repartidor = RepartidorCreator.new(repartidor_repo).crear_repartidor(repartidor_params[:nombre], repartidor_params[:dni], repartidor_params[:telefono])
      status 201
      repartidor_a_json nuevo_repartidor
    rescue RepartidorInvalido => e
      status 400
      {respuesta: "Registración fallida"}.to_json
    end
  end

  put :actualizar, :map => '/repartidor', :with => :id do
    begin
      pedido = LaBobe.asignar_pedido(repartidor_params[:id], repartidor_params[:id_pedidos])

      status 200
      pedido_a_json pedido
    rescue ErrorObjetoNoEncontrado => e
      status 405
      {error: e.message}.to_json
    rescue UsuarioInvalido => e
      status 400
      {error: e.message}.to_json
    end
  end

  delete :destruir, :map => '/repartidor', :with => :id do
    begin
      repartidor = repartidor_repo.buscar(params[:id])
      repartidor_repo.borrar(repartidor)

      status 200
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end

  delete :destruir, :map => '/repartidor' do
    begin
      repartidor_repo.borrar_todos

      status 200
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end
end
