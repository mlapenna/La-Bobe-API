class OpenWeatherES
  attr_reader :response_status_ok

  def initialize
    @response = Faraday.get(ENV['OPEN_WEATHER_URL'])
    @response_status_ok = (@response.status == 200)
  end

  def clima
    parsed_response = JSON.parse(@response.body)
    respuesta = parsed_response['weather'][0]['main']
    logger.info "Open Weather devolvió: '#{respuesta}'"

    respuesta
  end
end
