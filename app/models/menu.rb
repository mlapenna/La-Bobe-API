class Menu
  attr_reader :id, :nombre, :precio

  def initialize(nombre, precio, id = nil)
    @nombre = nombre
    @precio = precio
    @id = id
  end
end
