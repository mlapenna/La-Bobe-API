class RepartidorCreator
  def initialize(repartidor_repo)
    @repo = repartidor_repo
  end

  def crear_repartidor(nombre, dni, telefono)
    repartidor = Repartidor.new(nombre, dni, telefono)
    @repo.guardar(repartidor)
  end
end
