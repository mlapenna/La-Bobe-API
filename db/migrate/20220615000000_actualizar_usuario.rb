Sequel.migration do
  up do
    rename_table(:users, :usuarios)
    add_column :usuarios, :direccion, String
    from(:usuarios).update(direccion: 'La Pampa 123')
    add_column :usuarios, :telefono, Integer
    from(:usuarios).update(telefono: 12345678)
  end

  down do
    remove_column :usuarios, :direccion
    remove_column :usuarios, :telefono
    rename_table(:usuarios, :users)
  end
end
