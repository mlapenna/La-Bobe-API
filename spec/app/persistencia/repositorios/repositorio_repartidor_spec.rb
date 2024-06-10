require 'integracion_helper'

describe Persistencia::Repositorios::RepositorioRepartidor do
  let(:repartidor_repo) { Persistencia::Repositorios::RepositorioRepartidor.new }
  let(:un_repartidor) { Repartidor.new('Juan con moto', 40569586, 12345678) }


  it 'deberia guardar el nuevo reaprtidor' do
    repartidor_repo.guardar(un_repartidor)
    expect(repartidor_repo.todos.count).to eq(1)
  end

  it 'guardo un repartidor con pedido asignado' do
    un_repartidor.asignar_pedido(1, VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
    nuevo_repartidor = repartidor_repo.guardar(un_repartidor)
    expect(repartidor_repo.todos.count).to eq(1)
    repartidor_encontrado = repartidor_repo.buscar(nuevo_repartidor.id)
    expect(repartidor_encontrado.nombre).to eq('Juan con moto')
    expect(repartidor_encontrado.volumen_ocupado).to eq(VOLUMEN_PEDIDOS::MENU_INDIVIDUAL)
  end
end
