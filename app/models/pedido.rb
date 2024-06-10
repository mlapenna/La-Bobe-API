require_relative "./estado_recibido"
require_relative "./estado_entregado"
require_relative "./estado_preparando"
require_relative "./estado_enviando"
require_relative "../fachada/la_bobe"

class Pedido
  attr_reader :menu, :updated_on, :created_on, :usuario, :estado, :id_repartidor, :comision, :id_usuario
  attr_accessor :id, :puntaje
  attr_writer :clima

  def initialize(menu, usuario, estado, id_usuario, comision = nil, id_repartidor = nil, id = nil, puntaje = -1)
    @menu = menu
    @usuario = usuario
    @estado = estado
    @comision = comision
    @puntaje = puntaje
    @id_repartidor = id_repartidor
    @id = id
    @id_usuario = id_usuario
    validar_pedido!

    # logueo
    info = 'Pedido'
    info += " de #{@usuario}" unless @usuario.nil?
    info += " id ##{@id}" unless @id.nil?
    info += ' Inicializado satisfactoriamente'
    logger.info info
  end

  def asignar_repartidor(id)
    @id_repartidor = id
  end

  def desasignar_repartidor
    @id_repartidor = nil
  end

  def progresar_estado(clima)
    @estado = @estado.siguiente

    # logueo
    info = 'Pedido'
    info += " id ##{@id}" unless @id.nil?
    info += " | Estado [#{@estado.orden - 1} => #{@estado.orden}]"
    logger.info info

    if @estado.orden == ESTADO_PEDIDO::ENVIANDO
      @pedido = LaBobe.asignar_pedido(@id, self)
    elsif @estado.orden == ESTADO_PEDIDO::ENTREGADO
      @pedido = LaBobe.desasignar_pedido(self)
    end

    return self unless @estado.orden == ESTADO_PEDIDO::ENTREGADO

    menu_repo = Persistencia::Repositorios::RepositorioMenu.new
    @menu_objeto = menu_repo.buscar_por_nombre(@menu)

    comision = Comision.new(@menu_objeto, clima)
    @comision = comision.monto

    self
  end

  def calificar(puntaje, clima, menus)
    @clima = clima
    @estado.calificar(self, puntaje, menus)
  end

  def calificar_con_puntaje(puntaje, menus)
    unless puntaje.is_a? Integer
      raise CalificacionInvalida if puntaje.is_a? Float
      raise CalificacionInvalida unless puntaje.scan(/\D/).empty?

      puntaje = puntaje.to_i
    end

    raise CalificacionInvalida unless puntaje.between?(1, 5)

    # logueo
    info = "Calificación #{puntaje} para el pedido"
    info += " (id ##{@id})" unless @id.nil?
    info += " #{@menu}"
    logger.info info

    ya_calificado = @puntaje.positive?
    resultado = false
    @puntaje = puntaje.to_i

    @menu_objeto = menus.detect{|item| item.nombre == @menu}

    comision = Comision.new(@menu_objeto, @clima, puntaje)
    @comision = comision.monto

    resultado = true if ya_calificado
    resultado
  end

  def cancelar
    @estado = @estado.cancelar
  end

  private

  def validar_pedido!
    raise UsuarioInvalido, 'name is missing' if menu_vacio?
  end

  def menu_vacio?
    (@menu.nil? || @menu == '')
  end

end
