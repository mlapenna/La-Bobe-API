class EstadoRecibido < Estado
  RECIBIDO = 1

  def siguiente
    EstadoPreparando.new
  end

  def calificar(pedido, puntaje, menus)
    raise ErrorElPedidoNoPuedeCalificarse
  end

  def cancelar
    EstadoCancelado.new
  end

  def orden
    RECIBIDO
  end

end
