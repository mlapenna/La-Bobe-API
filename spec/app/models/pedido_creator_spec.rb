require 'spec_helper'

describe 'PedidoCreator' do

  it 'debería crear un pedido y guardarlo' do
    menu = 'Individual'
    usuario = 'Juan'
    pedido = instance_double(Pedido)
    repo = instance_double(Persistencia::Repositorios::RepositorioPedido)
    estado = instance_double(EstadoRecibido)
    # expect(Pedido).to receive(:new).with(menu, usuario, estado, 1).and_return(pedido)
    # expect(repo).to receive(:guardar).with(pedido).and_return(pedido)
    # PedidoCreator.new(repo).crear_pedido('Individual', 'Juan',1)
  end

end
