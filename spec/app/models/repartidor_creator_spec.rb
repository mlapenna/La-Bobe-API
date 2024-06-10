require 'spec_helper'

describe 'RepartidorCreator' do

  it 'debería crear un repartidor y guardarlo' do
    nombre = 'Juan con moto'
    dni = 40569586
    telefono = 2345678

    repartidor = instance_double(Repartidor)
    repo = instance_double(Persistencia::Repositorios::RepositorioRepartidor)
    expect(Repartidor).to receive(:new).with(nombre, dni, telefono).and_return(repartidor)
    expect(repo).to receive(:guardar).with(repartidor).and_return(repartidor)
    RepartidorCreator.new(repo).crear_repartidor('Juan con moto',40569586, 2345678)
  end

end
