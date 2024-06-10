Sequel.migration do
  up do
    alter_table(:menues) do
      set_column_type :precio, :Integer, using: "precio::integer"
    end
  end

  down do
    alter_table(:menues) do
      set_column_type :precio, String, using: "precio::string"
    end
  end
end
