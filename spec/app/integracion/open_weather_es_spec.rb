require 'integracion_helper'

describe OpenWeatherES do
  let(:open_weather_es) { OpenWeatherES.new }


=begin
  it 'al llamar a la API devuelve status 200 y el atributo "main" dentro del primer elemento del array "weather"' do
    expect(open_weather_es.response_status_ok).to eq(true)
    expect(open_weather_e.clima).not_to be_nil
  end
=end

end
