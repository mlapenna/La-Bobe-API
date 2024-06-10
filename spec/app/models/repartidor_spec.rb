require 'spec_helper'

describe Repartidor do
  context 'cuando es creado' do
    let(:un_repartidor) { Repartidor.new('Juan con moto', 40569586, 2345678) }

    it 'se crea un repartidor sin nombre y devuelve error' do
      expect { described_class.new('', '11111111111', '42245252') }.to raise_error(RepartidorInvalido)
    end

    it 'se crea un repartidor sin dni y devuelve error' do
      expect { described_class.new('Repartidor1', '', '42245252') }.to raise_error(RepartidorInvalido)
    end

    it 'se crea un repartidor sin telefono y devuelve error' do
      expect { described_class.new('Repartidor1', '123123123', '') }.to raise_error(RepartidorInvalido)
    end

    it 'se crea un repartidor con nombre, dni y teléfono, y se verifica' do
      repartidor = described_class.new('Juan con moto', 40569586, 2345678)
      expect(repartidor.nombre).to eq('Juan con moto')
      expect(repartidor.dni).to eq(40569586)
      expect(repartidor.telefono).to eq(2345678)
      expect(repartidor.volumen_ocupado).to eq(0)
    end

    it 'al repartidor se le puede asignar un pedido' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect(un_repartidor.id_pedidos).to eq([1])
    end

    it 'al repartidor se le asigna un pedido y luego se desasigna' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect(un_repartidor.id_pedidos).to eq([1])
      un_repartidor.desasignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect(un_repartidor.id_pedidos).to eq([])
    end

    it 'repartidor puede tener mas de un pedido asignado' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      un_repartidor.asignar_pedido(5, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect(un_repartidor.id_pedidos).to eq([1, 5])
    end

    it 'repartidor no puede asignar un pedido con volumen mayor a su Volumen maximo' do
      expect{un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MAXIMO_REPARTIDOR + 1)}.to raise_error(RepartidorNoPuedeAsignarPedidosTanGrandes)
    end

    it 'repartidor no puede asignar un pedido con volumen mayor a su Volumen maximo' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect{un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_FAMILIAR)}.to raise_error(RepartidorNoTieneEspacioParaAsignarEstePedido)
    end

    it 'repartidor desasigna pedido' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      un_repartidor.asignar_pedido(2, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      un_repartidor.desasignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect(un_repartidor.id_pedidos).to eq([2])
      expect(un_repartidor.volumen_ocupado).to eq(VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
    end

    it 'repartidor no puede desasignar un pedido que no tiene asignado' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      un_repartidor.asignar_pedido(2, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect{un_repartidor.desasignar_pedido(3, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)}.to raise_error(RepartidorNoPuedeDesasignarUnPedidoQueNoTieneAsignado)
    end

    it 'repartidor no puede tener volumen negativo' do
      un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
      expect{un_repartidor.desasignar_pedido(1, VOLUMEN_PEDIDOS::MENU_FAMILIAR)}.to raise_error(RepartidorNoPuedeTenerVolumenNegativo)
    end

  end

end
