class EstadoEnviando < Estado
  ENVIANDO = 3

  def siguiente
    EstadoEntregado.new
  end

  def calificar(pedido, puntaje, menus)
    raise ErrorElPedidoNoPuedeCalificarse
  end

  def cancelar
    raise ErrorElPedidoNoSePuedeCancelar
  end

  def orden
    ENVIANDO
  end

end
