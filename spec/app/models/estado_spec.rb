require 'spec_helper'
require_relative '../../../app/fachada/la_bobe'

describe Estado do
  let(:estado) { Estado.new }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }

  it 'se crea un estado general y lanza una excepcion cuando se progresa ' do
    expect{ estado.siguiente }.to raise_error ResponsabilidadDeLaSubclase
  end

  it 'se crea un estado general y lanza una excepcion cuando se quiere calificar ' do
    pedido = instance_double(Pedido)
    expect{ estado.calificar(pedido, 4, menu_repo.todos) }.to raise_error ResponsabilidadDeLaSubclase
  end

  it 'se crea un estado general y lanza una excepcion cuando se trata de cancelar ' do
    expect{ estado.cancelar }.to raise_error ResponsabilidadDeLaSubclase
  end

end

describe EstadoRecibido do
  let(:estado_recibido) { EstadoRecibido.new }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }

  it 'se crea un estado recibido y se progresa ' do
    expect(estado_recibido.siguiente).to an_instance_of(EstadoPreparando)
  end

  it 'cuando un estado recibido se quiere calificar se lanza una excepcion' do
    pedido = instance_double(Pedido)
    expect{ estado_recibido.calificar(pedido, 4, menu_repo.todos) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'un estado recibido puede ser cancelado ' do
    estado_actualizado = estado_recibido.cancelar
    expect(estado_actualizado).to an_instance_of(EstadoCancelado)
  end

end

describe EstadoPreparando do
  let(:estado_preparando) { EstadoPreparando.new }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }

  it 'se crea un estado preparando y se progresa ' do
    expect(estado_preparando.siguiente).to an_instance_of(EstadoEnviando)
  end

  it 'cuando un estado preparando se quiere calificar se lanza una excepcion' do
    pedido = instance_double(Pedido)
    expect{ estado_preparando.calificar(pedido, 4, menu_repo.todos) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'un estado preparando puede ser cancelado ' do
    estado_actualizado = estado_preparando.cancelar
    expect(estado_actualizado).to an_instance_of(EstadoCancelado)
  end

end

describe EstadoEnviando do
  let(:estado_enviando) { EstadoEnviando.new }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }

  it 'se crea un estado enviando y se progresa ' do
    expect(estado_enviando.siguiente).to an_instance_of(EstadoEntregado)
  end

  it 'cuando un estado enviando se quiere calificar se lanza una excepcion' do
    pedido = instance_double(Pedido)
    expect{ estado_enviando.calificar(pedido, 4, menu_repo.todos) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'cuando trato de cancelar un estado enviando se lanza una excepcion' do
    expect{ estado_enviando.cancelar }.to raise_error(ErrorElPedidoNoSePuedeCancelar)
  end

end

describe EstadoEntregado do
  before do
    ClimaMockStatus.activar(true, false)
  end

  let(:estado_entregado) { EstadoEntregado.new }
  let(:pedido) { Pedido.new('Individual', 'Ale', EstadoRecibido.new,1) }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:clima) { LaBobe.clima }

  it 'se crea un estado entregado y lanza una excepcion cuando se progresa ' do
    expect{ estado_entregado.siguiente }.to raise_error(PedidoYaEntregadoNoPuedeSerProgresado)
  end

  it 'un estado entregado puede calificar' do
    pedido.clima = clima
    estado_entregado.calificar(pedido, 4, menu_repo.todos)
    expect(pedido.puntaje).to eq(4)
  end

  it 'cuando trato de cancelar un estado entregado se lanza una excepcion' do
    expect{ estado_entregado.cancelar }.to raise_error(ErrorElPedidoNoSePuedeCancelar)
  end

end

describe EstadoCancelado do
  let(:estado_cancelado) { EstadoCancelado.new }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }

  it 'se crea un estado cancelado y se progresa ' do
    expect{ estado_cancelado.siguiente }.to raise_error(PedidoCanceladoNoPuedeSerProgresado)
  end

  it 'cuando un estado cancelado se quiere calificar se lanza una excepcion' do
    pedido = instance_double(Pedido)
    expect{ estado_cancelado.calificar(pedido, 4, menu_repo) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'cuando trato de cancelar un estado ya cancelado se lanza una excepcion' do
    expect{ estado_cancelado.cancelar }.to raise_error(ErrorElPedidoNoSePuedeCancelar)
  end

end
