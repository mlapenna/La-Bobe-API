Sequel.migration do
  up do
    add_column :usuarios, :id_usuario, Integer
  end

  down do
    remove_column :usuarios, :id_usuario
  end
end
