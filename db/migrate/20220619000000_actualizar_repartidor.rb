Sequel.migration do
  up do
    add_column :repartidores, :id_pedido, Integer
    from(:repartidores).update(id_pedido: 1)
  end

  down do
    remove_column :repartidores, :id_pedido
  end
end
