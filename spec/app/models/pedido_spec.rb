require 'spec_helper'
require_relative '../../../app/fachada/la_bobe'

describe Pedido do
  before do
    ClimaMockStatus.activar(true, false)
  end

  let(:pedido) { Pedido.new('Individual', 'Ale', EstadoRecibido.new,1) }
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:repartidor_repo) { Persistencia::Repositorios::RepositorioRepartidor.new }
  let(:pedido_repo) { Persistencia::Repositorios::RepositorioPedido.new }
  let(:un_repartidor) { Repartidor.new('Juan con moto', 40569586, 2345678) }
  let(:clima) { LaBobe.clima }

  it 'se crea un pedido con menu y usuario, y se verifica' do
    pedido = Pedido.new('Individual', 'Juan', EstadoRecibido.new, 1)
    expect(pedido.menu).to eq('Individual')
    expect(pedido.usuario).to eq('Juan')
    expect(pedido.estado).to an_instance_of(EstadoRecibido)
    expect(pedido.id_usuario).to eq(1)
  end

  it 'pedido creado con estado Recibido al progresar el estado pasa a Preparando' do
    pedido.progresar_estado(clima)
    expect(pedido.estado).to an_instance_of(EstadoPreparando)
  end

  it 'pedido creado con estado Recibido al progresar el estado pasa a Enviando' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    expect(pedido.estado).to an_instance_of(EstadoEnviando)
  end

  it 'no puedo progresar estado de pedido entregado' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    expect(pedido.estado).to an_instance_of(EstadoEntregado)
    expect{ pedido.progresar_estado(clima) }.to raise_error PedidoYaEntregadoNoPuedeSerProgresado
  end

  it 'pedido puede tener un repartidor asignado' do
    pedido.asignar_repartidor(1)
    expect(pedido.id_repartidor).to eq 1
  end

  it 'pedido puede desasignar su repartidor asignado' do
    pedido.asignar_repartidor(1)
    pedido.desasignar_repartidor
    expect(pedido.id_repartidor).to eq nil
  end

  it 'pedido puede calificarse' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    pedido.calificar(4, clima, menu_repo.todos)
    expect(pedido.puntaje).to eq 4
  end

  it 'pedido no puede calificarse por estar en estado recibido, y lanza una excepción' do
    expect{ pedido.calificar(4, clima, menu_repo) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'pedido no puede calificarse por estar en estado preparando, y lanza una excepción' do
    pedido.progresar_estado(clima)
    expect{ pedido.calificar(4, clima, menu_repo.todos) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'pedido no puede calificarse por estar en estado enviando, y lanza una excepción' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    expect{ pedido.calificar(4, clima, menu_repo.todos) }.to raise_error(ErrorElPedidoNoPuedeCalificarse)
  end

  it 'pedido puede volver a calificarse' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    resultado = pedido.calificar(4, clima, menu_repo.todos)
    expect(pedido.puntaje).to eq 4
    expect(resultado).to eq false
    resultado = pedido.calificar(3, clima, menu_repo.todos)
    expect(pedido.puntaje).to eq 3
    expect(resultado).to eq true
  end

  it 'pedido en estado enviando no se puede cancelar' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    expect(pedido.estado).to an_instance_of(EstadoEnviando)
    expect{pedido.cancelar}.to raise_error ErrorElPedidoNoSePuedeCancelar
  end

  it 'pedido en estado entregado no se puede cancelar' do
    repartidor_repo.guardar(un_repartidor)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    expect(pedido.estado).to an_instance_of(EstadoEntregado)
    expect{pedido.cancelar}.to raise_error ErrorElPedidoNoSePuedeCancelar
  end
end


describe Pedido do
  before do
    ClimaMockStatus.activar(true, false)
  end

  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:repartidor_repo) { Persistencia::Repositorios::RepositorioRepartidor.new }
  let(:pedido_repo) { Persistencia::Repositorios::RepositorioPedido.new }
  let(:un_repartidor) { Repartidor.new('Juan con moto', 40569586, 2345678) }
  let(:clima) { LaBobe.clima }

  def crear_y_entregar_pedido(menu)
    repartidor_repo.guardar(un_repartidor)
    pedido = Pedido.new(menu, 'Juan', EstadoRecibido.new, 1)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    pedido
  end

  def calcular_comision_pedido(menu, porcentaje)
    menu = menu_repo.buscar_por_nombre(menu)
    precio = menu.precio
    precio * porcentaje
  end

  it 'creo y entrego un pedido Individual y la comisión es del 5% en valor monetario' do
    pedido = crear_y_entregar_pedido('Individual')
    comision_correcta = calcular_comision_pedido('Individual', 0.05)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'creo y entrego un pedido Pareja y la comisión es del 5% en valor monetario' do
    pedido = crear_y_entregar_pedido('Pareja')
    comision_correcta = calcular_comision_pedido('Pareja', 0.05)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'creo y entrego un pedido Familiar y la comisión es del 5% en valor monetario' do
    pedido = crear_y_entregar_pedido('Familiar')
    comision_correcta = calcular_comision_pedido('Familiar', 0.05)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'Califico un pedido Individual con 1 y la comisión queda en 3%' do
    pedido = crear_y_entregar_pedido('Individual')
    pedido.calificar(1, clima, menu_repo.todos)
    comision_correcta = calcular_comision_pedido('Individual', 0.03)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'Califico un pedido Pareja con 2 y la comisión queda en 5%' do
    pedido = crear_y_entregar_pedido('Pareja')
    pedido.calificar(2, clima, menu_repo.todos)
    comision_correcta = calcular_comision_pedido('Pareja', 0.05)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'Califico un pedido Familiar con 3 y la comisión queda en 5%' do
    pedido = crear_y_entregar_pedido('Familiar')
    pedido.calificar(3, clima, menu_repo.todos)
    comision_correcta = calcular_comision_pedido('Familiar', 0.05)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'Califico un pedido Individual con 4 y la comisión queda en 5%' do
    pedido = crear_y_entregar_pedido('Individual')
    pedido.calificar(4, clima, menu_repo.todos)
    comision_correcta = calcular_comision_pedido('Individual', 0.05)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'Califico un pedido Individual con 5 y la comisión queda en 7%' do
    pedido = crear_y_entregar_pedido('Individual')
    pedido.calificar(5, clima, menu_repo.todos)
    comision_correcta = calcular_comision_pedido('Individual', 0.07)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'Califico un pedido con 0 y devuelve error' do
    pedido = crear_y_entregar_pedido('Individual')
    expect{ pedido.calificar(0, clima, menu_repo.todos) }.to raise_error(CalificacionInvalida)
  end

  it 'Califico un pedido con -3 y devuelve error' do
    pedido = crear_y_entregar_pedido('Pareja')
    expect{ pedido.calificar(-3, clima, menu_repo.todos) }.to raise_error(CalificacionInvalida)
  end

  it 'Califico un pedido con 2.1 y devuelve error' do
    pedido = crear_y_entregar_pedido('Familiar')
    expect{ pedido.calificar(2.1, clima, menu_repo.todos) }.to raise_error(CalificacionInvalida)
  end

  it 'Califico un pedido con 6 y devuelve error' do
    pedido = crear_y_entregar_pedido('Familiar')
    expect{ pedido.calificar(6, clima, menu_repo.todos) }.to raise_error(CalificacionInvalida)
  end

  it 'Califico un pedido con "H" y devuelve error' do
    pedido = crear_y_entregar_pedido('Familiar')
    expect{ pedido.calificar('H', clima, menu_repo.todos) }.to raise_error(CalificacionInvalida)
  end
end

describe Pedido do
  before do
    ClimaMockStatus.activar(true, true)
  end

  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:repartidor_repo) { Persistencia::Repositorios::RepositorioRepartidor.new }
  let(:un_repartidor) { Repartidor.new('Juan con moto', 40569586, 2345678) }
  let(:pedido_repo) { Persistencia::Repositorios::RepositorioPedido.new }
  let(:clima) { LaBobe.clima }

  def crear_y_entregar_pedido(menu)
    repartidor_repo.guardar(un_repartidor)
    pedido = Pedido.new(menu, 'Juan', EstadoRecibido.new, 1)
    pedido.progresar_estado(clima)
    pedido.progresar_estado(clima)
    pedido_repo.guardar(pedido)
    pedido.progresar_estado(clima)
    pedido
  end

  def calcular_comision_pedido(menu, porcentaje)
    menu = menu_repo.buscar_por_nombre(menu)
    precio = menu.precio
    precio * porcentaje
  end

  it 'creo y entrego un pedido Individual, lo califican con 5 y la comisión es del 8% en valor monetario' do
    pedido = crear_y_entregar_pedido('Individual')
    pedido.calificar(5, clima, menu_repo.todos)
    comision_correcta = calcular_comision_pedido('Individual', 0.08)

    expect(pedido.comision).to eq comision_correcta
  end

  it 'creo y entrego un pedido Familiar, sin calificar y la comisión es del 6% en valor monetario' do
    pedido = crear_y_entregar_pedido('Familiar')
    comision_correcta = calcular_comision_pedido('Familiar', 0.06)

    expect(pedido.comision).to eq comision_correcta
  end
end
