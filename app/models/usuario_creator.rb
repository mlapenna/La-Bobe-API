class UsuarioCreator
  def initialize(user_repo)
    @repo = user_repo
  end

  def crear_usuario(nombre, direccion, telefono, id_usuario)
    usuario = Usuario.new(nombre, direccion, telefono, id_usuario)
    raise UsuarioInvalido if @repo.contain_usuario_con_telefono(telefono)
    @repo.guardar(usuario)
  end
end
