Sequel.migration do
  up do
    add_column :repartidores, :volumen_ocupado, Integer
  end

  down do
    remove_column :repartidores, :volumen_ocupado
  end
end
