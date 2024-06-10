Sequel.migration do
  up do
    add_column :pedidos, :id_repartidor, Integer
    from(:pedidos).update(id_repartidor: 1)
  end

  down do
    remove_column :pedidos, :id_repartidor
  end
end
