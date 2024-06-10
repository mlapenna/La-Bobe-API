Sequel.migration do
  up do
    create_table(:menues) do
      primary_key :id
      String :nombre
      String :precio
      Date :created_on
      Date :updated_on
    end

    from(:menues).insert(id: 1, nombre: 'Individual', precio: '1000')
    from(:menues).insert(id: 2, nombre: 'Pareja', precio: '1500')
    from(:menues).insert(id: 3, nombre: 'Familiar', precio: '2500')
  end

  down do
    drop_table(:menues)
  end
end
