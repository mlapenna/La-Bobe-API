class Usuario
  attr_reader :nombre, :updated_on, :created_on, :direccion, :telefono, :id_usuario
  attr_accessor :id

  def initialize(nombre, direccion, telefono, id_usuario = nil, id = nil)
    @nombre = nombre
    @direccion = direccion
    @telefono = telefono
    @id = id
    @id_usuario = id_usuario
    validar_nombre!
    validar_direccion!
    validar_telefono!

    # logueo
    info = "Usuario #{@nombre}"
    info += ", id ##{@id}" unless @id.nil?
    info += " Inicializado satisfactoriamente"
    logger.info info
  end

  private

  def validar_nombre!
    raise UsuarioInvalido if @nombre.nil? || @nombre == '' || @nombre.length > 20
  end

  def validar_direccion!
    raise UsuarioInvalido if @direccion.nil? || @direccion == '' || @direccion.length < 5
  end

  def validar_telefono!
    raise UsuarioInvalido if !@telefono.is_a?(Integer) && (@telefono.nil? || !@telefono.scan(/\D/).empty?)
  end
end
