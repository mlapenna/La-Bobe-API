require 'integracion_helper'

describe Persistencia::Repositorios::RepositorioPedido do
  before do
    ClimaMockStatus.activar(true, false)
  end

  let(:pedido_repo) { Persistencia::Repositorios::RepositorioPedido.new }
  let(:pedido) { Pedido.new('Individual', 'Ale', EstadoRecibido.new, 1) }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:repartidor_repo) { Persistencia::Repositorios::RepositorioRepartidor.new }
  let(:pedido_repo) { Persistencia::Repositorios::RepositorioPedido.new }
  let(:un_repartidor) { Repartidor.new('Juan con moto', 40569586, 2345678) }
  let(:clima) { LaBobe.clima }

  it 'se crea un pedido con nombre existente y no da error al grabarlo' do
    un_pedido = Pedido.new('Individual', 'Juancito', EstadoRecibido.new, 1)
    pedido_repo.guardar(un_pedido)
  end

  it 'se crea otro pedido (2) con nombre existente y no da error al grabarlo' do
    un_pedido = Pedido.new('Familiar', 'Carlos', EstadoRecibido.new, 1)
    pedido_repo.guardar(un_pedido)
  end

  it 'se crea otro pedido (3) nombre existente y no da error al grabarlo' do
    un_pedido = Pedido.new('Pareja', 'Ariel', EstadoRecibido.new, 1)
    pedido_repo.guardar(un_pedido)
  end

  it 'se crea un pedido con nombre inexistente y da error al grabarlo' do
    un_pedido = Pedido.new('Milanesisima', 'Juan', EstadoRecibido.new, 1)
    expect { pedido_repo.guardar(un_pedido) }.to raise_error(ErrorMenuInexistente)
  end

  it 'debería guardar un nuevo pedido' do
    un_pedido = Pedido.new('Individual', 'Juancito', EstadoRecibido.new, 1)
    pedido_repo.guardar(un_pedido)
    expect(pedido_repo.todos.count).to eq 1
  end

  it 'guardo un repartidor con pedido asignado' do
    pedido.asignar_repartidor(55)
    pedido_guardado = pedido_repo.guardar(pedido)
    expect(pedido_repo.todos.count).to eq(1)
    pedido_encontrado = pedido_repo.buscar(pedido_guardado.id)
    expect(pedido_encontrado.id_repartidor).to eq(55)
  end

  it 'guardo un pedido con calificación' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    pedido.calificar(4, clima, menu_repo.todos)
    pedido_guardado = pedido_repo.guardar(pedido)
    expect(pedido_repo.todos.count).to eq(1)
    pedido_encontrado = pedido_repo.buscar(pedido_guardado.id)
    expect(pedido_encontrado.puntaje).to eq(4)
  end
end
