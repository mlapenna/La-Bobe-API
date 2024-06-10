require 'spec_helper'

describe Clima do
  it 'cuando el string que devuelve Open Weather incluye "rain", entonces está lloviendo' do
    clima = Clima.new('rain nieve nubes')
    expect(clima.llueve).to eq(true)
  end

  it 'cuando el string que devuelve Open Weather incluye "snow", entonces está lloviendo' do
    clima = Clima.new('nieve nubes snow pizza')
    expect(clima.llueve).to eq(true)
  end

  it 'cuando el string que devuelve Open Weather incluye "thunderstorm", entonces está lloviendo' do
    clima = Clima.new('sky nubes rama thunderstorm')
    expect(clima.llueve).to eq(true)
  end

  it 'cuando el string que devuelve Open Weather incluye "drizzle", entonces está lloviendo' do
    clima = Clima.new('sky nubes drizzle thunderstruck')
    expect(clima.llueve).to eq(true)
  end

  it 'cuando el string que devuelve Open Weather no incluye ninguna palabra clave, entonces no está lloviendo' do
    clima = Clima.new('sky nubes Extreme tornado')
    expect(clima.llueve).to eq(false)
  end
end
