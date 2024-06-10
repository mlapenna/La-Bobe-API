require 'spec_helper'
require_relative '../../../app/fachada/la_bobe'

describe Comision do
  before do
    ClimaMockStatus.activar(true, false)
  end

  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:menu) { menu_repo.buscar_por_nombre('Individual')}
  let(:clima) { LaBobe.clima }

  it 'la comisión de un pedido Individual no calificado es de $50' do
    comision = Comision.new(menu, clima)
    expect(comision.monto).to eq(50)
  end

  it 'la comisión de un pedido Individual calificado con 5 es de $70' do
    comision = Comision.new(menu, clima,5)
    expect(comision.monto).to eq(70)
  end

  it 'la comisión de un pedido Individual calificado con 1 es de $30' do
    comision = Comision.new(menu, clima, 1)
    expect(comision.monto).to eq(30)
  end
end


describe Comision do
  before do
    ClimaMockStatus.activar(true, true)
  end

  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }
  let(:menu) { menu_repo.buscar_por_nombre('Individual')}
  let(:clima) { LaBobe.clima }

  it 'la comisión de un pedido Individual no calificado en día lluvioso es de $60' do
    comision = Comision.new(menu, clima)
    expect(comision.monto).to eq(60)
  end

end

