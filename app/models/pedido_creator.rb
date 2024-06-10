class PedidoCreator
  def initialize(pedido_repo)
     @repo = pedido_repo
  end

  def crear_pedido(menu, usuario, id_usuario)
    pedido = Pedido.new(menu, usuario, EstadoRecibido.new, id_usuario)
    @repo.guardar(pedido)
  end
end

module ESTADO_PEDIDO
  RECIBIDO = 1
  PREPARANDO = 2
  ENVIANDO = 3
  ENTREGADO = 4
  CANCELADO = 5
end
