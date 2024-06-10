class Comision
  COMISION_PREDETERMINADA = 0.05
  COMISION_SEGUN_PUNTAJE = [0.03, COMISION_PREDETERMINADA, COMISION_PREDETERMINADA, COMISION_PREDETERMINADA, 0.07].freeze

  def initialize(menu, clima, puntaje = nil)
    @menu = menu
    @clima = clima
    @puntaje = puntaje
  end

  def monto
    comision_porcentaje = if @puntaje.nil?
                 COMISION_PREDETERMINADA
               else
                 COMISION_SEGUN_PUNTAJE[@puntaje - 1]
               end
    comision_porcentaje += 0.01 if @clima.llueve

    (comision_porcentaje * @menu.precio).round(2)
  end
end
