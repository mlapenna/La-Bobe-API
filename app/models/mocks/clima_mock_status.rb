class ClimaMockStatus
  @@activado = false
  @@esta_lloviendo = nil

  def self.activar(activado, esta_lloviendo = nil)
    @@activado = activado
    @@esta_lloviendo = esta_lloviendo
  end

  def self.activado
    @@activado
  end

  def self.esta_lloviendo
    @@esta_lloviendo
  end
end

