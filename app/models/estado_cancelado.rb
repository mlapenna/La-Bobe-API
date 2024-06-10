class EstadoCancelado < Estado
  CANCELADO = 5

  def siguiente
    raise PedidoCanceladoNoPuedeSerProgresado
  end

  def calificar(pedido, puntaje, menus)
    raise ErrorElPedidoNoPuedeCalificarse
  end

  def cancelar
    raise ErrorElPedidoNoSePuedeCancelar
  end

  def orden
    CANCELADO
  end

end
