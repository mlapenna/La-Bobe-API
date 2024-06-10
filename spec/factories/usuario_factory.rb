module UsuarioFactory
  def un_usuario_existente
    usuario_repo = Persistence::Repositories::RepositorioUsuario.new
    un_usuario = Usuario.new('John', 'La Pampa 123', 12345678)
    usuario_repo.guardar(un_usuario)
  end
end
