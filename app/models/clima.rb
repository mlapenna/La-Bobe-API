class Clima
  PALABRAS_LLUVIA = %w[rain snow thunderstorm drizzle].freeze

  def initialize(descripcion)
    @descripcion = descripcion.downcase
  end

  def llueve
    llueve = false
    PALABRAS_LLUVIA.each do |palabra_clave|
      llueve = @descripcion.include? palabra_clave
      break if llueve
    end

    llueve
  end
end
