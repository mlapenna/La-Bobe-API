Sequel.migration do
  up do
    add_column :pedidos, :id_usuario, Integer
  end

  down do
    remove_column :pedidos, :id_usuario
  end
end
