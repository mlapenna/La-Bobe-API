class EstadoEntregado < Estado
  ENTREGADO = 4

  def siguiente
    raise PedidoYaEntregadoNoPuedeSerProgresado
  end

  def calificar(pedido, puntaje, menus)
    pedido.calificar_con_puntaje(puntaje, menus)
  end

  def cancelar
    raise ErrorElPedidoNoSePuedeCancelar
  end

  def orden
    ENTREGADO
  end

end
