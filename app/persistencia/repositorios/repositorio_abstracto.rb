require 'byebug'

module Persistencia
  module Repositorios
    class RepositorioAbstracto
      def guardar(un_registro)
        resultado = un_registro
        if buscar_por_id(un_registro.id).first
          actualizar(un_registro)
        else
          resultado = insertar(un_registro)
        end
        resultado
      end
    
      def destruir(un_registro)
        buscar_por_id(un_registro.id).delete
      end
      alias borrar destruir
    
      def borrar_todos
        dataset.delete
      end
    
      def todos
        cargar_colleccion dataset.all
      end
    
      def buscar(id)
        registro_encontrado = dataset.first(pk_columna => id)
        raise ErrorObjetoNoEncontrado.new(self.class.model_class, id) if registro_encontrado.nil?
        cargar_objeto dataset.first(registro_encontrado)
      end
    
      def primero
        cargar_colleccion dataset.where(is_active: true)
        cargar_objeto dataset.first
      end
    
      class << self
        attr_accessor :table_name, :model_class
      end
    
      protected
    
      def dataset
        DB[self.class.table_name]
      end
    
      def cargar_colleccion(filas)
        filas.map { |un_registro| cargar_objeto(un_registro) }
      end
    
      def actualizar(un_registro)
        buscar_por_id(un_registro.id).update(actualizar_cambio(un_registro))
      end
    
      def insertar(un_registro)
        id = dataset.insert(insertar_cambio(un_registro))
        un_registro.id = id
        un_registro
      end
    
      def buscar_por_id(id)
        dataset.where(pk_columna => id)
      end
    
      def cargar_objeto(un_registro)
        raise 'Subclass must implement'
      end

      def cambio(un_objecto)
        raise 'Subclass must implement'
      end
    
      def insertar_cambio(un_registro)
        cambio_con_timestamps(un_registro).merge(created_on: Date.today)
      end
    
      def actualizar_cambio(un_registro)
        cambio_con_timestamps(un_registro).merge(updated_on: Date.today)
      end
    
      def cambio_con_timestamps(un_registro)
        cambio(un_registro).merge(created_on: un_registro.created_on, updated_on: un_registro.updated_on)
      end
        
      def nombre_de_clase
        self.class.model_class
      end
    
      def pk_columna
        Sequel[self.class.table_name][:id]
      end
    end
  end
end

