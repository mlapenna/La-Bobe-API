module Persistencia
  module Repositorios
    class RepositorioMenu < RepositorioAbstracto
      self.table_name = :menues
      self.model_class = 'Menu'

      def buscar_por_nombre(nombre)
        found_record = dataset.first(:nombre => nombre)
        raise ErrorObjetoNoEncontrado.new(self.class.model_class, nombre) if found_record.nil?
        cargar_objeto dataset.first(found_record)
      end

      protected

      def cargar_objeto(a_hash)
        Menu.new(a_hash[:nombre], a_hash[:precio])
      end

      def cambio(menu)
        {
          nombre: menu.nombre,
          precio: menu.precio
        }
      end
    end
  end
end
