Sequel.migration do
  up do
    add_column :pedidos, :comision, Integer
  end

  down do
    remove_column :pedidos, :comision
  end
end
