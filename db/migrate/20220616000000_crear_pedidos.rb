Sequel.migration do
  up do
    create_table(:pedidos) do
      primary_key :id
      String :menu
      String :usuario
    end
  end

  down do
    drop_table(:pedidos)
  end
end
