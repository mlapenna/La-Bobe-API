Sequel.migration do
  up do
    add_column :pedidos, :puntaje, Integer
    from(:pedidos).update(puntaje: 8)
  end

  down do
    remove_column :pedidos, :puntaje
  end
end
