Sequel.migration do
  up do
    alter_table(:repartidores) do
      rename_column :name, :nombre
    end
  end

  down do
    alter_table(:repartidores) do
      rename_column :nombre, :name
    end
  end
end
