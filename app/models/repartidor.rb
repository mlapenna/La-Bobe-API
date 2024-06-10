class Repartidor
  attr_reader :nombre, :updated_on, :created_on
  attr_reader :dni
  attr_reader :telefono
  attr_accessor :id
  attr_accessor :id_pedidos
  attr_accessor :volumen_ocupado

  def initialize(nombre, dni, telefono, id = nil, id_pedidos = [], volumen_ocupado = 0)
    @nombre = nombre
    @dni = dni
    @telefono = telefono
    @id = id
    @id_pedidos= id_pedidos
    @volumen_ocupado = volumen_ocupado
    validar_repartidor!

    # logueo
    info = "Repartidor #{@nombre}"
    info += ", id ##{@id}" unless @id.nil?
    info += " Inicializado satisfactoriamente"
    logger.info info
  end

  def asignar_pedido(id_pedido, volumen_pedido)
    raise RepartidorNoPuedeAsignarPedidosTanGrandes if volumen_pedido > VOLUMEN_PEDIDOS::MAXIMO_REPARTIDOR
    raise RepartidorNoTieneEspacioParaAsignarEstePedido if volumen_pedido + @volumen_ocupado > VOLUMEN_PEDIDOS::MAXIMO_REPARTIDOR
    @volumen_ocupado += volumen_pedido
    @id_pedidos.append(id_pedido)
    # logueo
    info = "Repartidor asignado a pedido id ##{id_pedido}"
    info += " | Volumen del repartidor [#{@volumen_ocupado - volumen_pedido} => #{@volumen_ocupado}]"
    logger.info info
  end

  def puedo_asignar_pedido?(volumen_pedido)
    return false if volumen_pedido > VOLUMEN_PEDIDOS::MAXIMO_REPARTIDOR
    return false if volumen_pedido + @volumen_ocupado > VOLUMEN_PEDIDOS::MAXIMO_REPARTIDOR
    return true
  end

  def desasignar_pedido(id_pedido, volumen_pedido)
    raise RepartidorNoPuedeDesasignarUnPedidoQueNoTieneAsignado unless @id_pedidos.include? id_pedido
    raise RepartidorNoPuedeTenerVolumenNegativo if @volumen_ocupado - volumen_pedido < 0
    @id_pedidos.delete_if {|id| id == id_pedido }
    @volumen_ocupado -= volumen_pedido

    # logueo
    info = "Repartidor desasignado a pedido id ##{id_pedido}"
    info += " | Volumen del repartidor [#{@volumen_ocupado + volumen_pedido} => #{@volumen_ocupado}]"
    logger.info info
  end

  private

  def validar_repartidor!
    raise RepartidorInvalido, 'nombre esta vacio' if nombre_vacio? || dni_vacio? || telefono_vacio?
  end

  def nombre_vacio?
    (@nombre.nil? || @nombre == '')
  end

  def telefono_vacio?
    (@telefono.nil? || @telefono == '')
  end

  def dni_vacio?
    (@dni.nil? || @dni == '')
  end
end

module VOLUMEN_PEDIDOS
  MENU_INDIVIDUAL = 1
  MENU_PAREJA = 2
  MENU_FAMILIAR = 3
  MAXIMO_REPARTIDOR = 3
end
