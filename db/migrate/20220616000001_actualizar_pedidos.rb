Sequel.migration do
  up do
    add_column :pedidos, :created_on, Date
    from(:pedidos).update(created_on: '2022-06-16')
    add_column :pedidos, :updated_on, Date
    from(:pedidos).update(updated_on: '2022-06-16')
  end

  down do
    remove_column :pedidos, :created_on
    remove_column :pedidos, :updated_on
  end
end
