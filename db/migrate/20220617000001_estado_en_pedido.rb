Sequel.migration do
  up do
    add_column :pedidos, :estado, Integer
    from(:pedidos).update(estado: 1)
  end

  down do
    remove_column :pedidos, :estado
  end
end
