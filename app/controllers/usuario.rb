WebTemplate::App.controllers :users, :provides => [:json] do
  get :index do
    todos_los_usuarios = usuario_repo.todos
    usuarios_a_json todos_los_usuarios
  end

  get :show, :map => '/users', :with => :id do
    begin
      usuario_id = params[:id]
      usuario = usuario_repo.find_por_id_usuario(usuario_id)

      usuario_a_json usuario
    rescue ErrorObjetoNoEncontrado, UsuarioInvalido => e
      status 404
      {error: e.message}.to_json
    end
  end

  post :create, :map => '/users' do
    begin
      nuevo_usuario = UsuarioCreator.new(usuario_repo).crear_usuario(usuario_params[:nombre], usuario_params[:direccion], usuario_params[:telefono], usuario_params[:id_usuario])
      status 201
      usuario_a_json nuevo_usuario
    rescue UsuarioInvalido => e
      status 400
      {respuesta: 'Registración fallida'}.to_json
    end
  end

  delete :destruir, :map => '/users', :with => :id do
    begin
      usuario = usuario_repo.buscar(params[:id])
      usuario_repo.borrar(usuario)

      status 200
    rescue ErrorObjetoNoEncontrado => e
      status 404
      {error: e.message}.to_json
    end
  end
end
