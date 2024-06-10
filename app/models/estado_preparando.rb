class EstadoPreparando < Estado
  PREPARANDO = 2

  def siguiente
    EstadoEnviando.new
  end

  def calificar(pedido, puntaje, menus)
    raise ErrorElPedidoNoPuedeCalificarse
  end

  def cancelar
    EstadoCancelado.new
  end

  def orden
    PREPARANDO
  end

end
