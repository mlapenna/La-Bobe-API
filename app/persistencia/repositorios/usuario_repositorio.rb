module Persistencia
  module Repositorios
    class RepositorioUsuario < RepositorioAbstracto
      self.table_name = :usuarios
      self.model_class = 'Usuario'

      def find_por_id_usuario(id_usuario)
        cargar_colleccion dataset.where(id_usuario: id_usuario)
        usuarios = []
        dataset.each do |item|
          usuario = cargar_objeto item
          next if usuario.id_usuario != id_usuario.to_i
          usuarios.append(usuario)
        end
        raise UsuarioInvalido if usuarios.empty?
        usuarios.first
      end

      def contain_usuario_con_telefono(telefono)
        cargar_colleccion dataset.where(telefono: telefono)
        dataset.each do |item|
          usuario = cargar_objeto item
          next if usuario.telefono != telefono.to_i
          return true
        end
        false
      end

      protected

      def cargar_objeto(a_hash)
        Usuario.new(a_hash[:nombre], a_hash[:direccion], a_hash[:telefono], a_hash[:id_usuario])
      end

      def cambio(usuario)
        {
          nombre: usuario.nombre,
          direccion: usuario.direccion,
          telefono: usuario.telefono,
          id_usuario: usuario.id_usuario.to_i
        }
      end
    end
  end
end
