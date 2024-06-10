# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module UsuarioHelper
      def usuario_repo
        Persistencia::Repositorios::RepositorioUsuario.new
      end

      def usuario_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def usuario_a_json(usuario)
        usuario_atributos(usuario).to_json
      end

      def usuarios_a_json(usuarios)
        usuarios.map { |usuario| usuario_atributos(usuario) }.to_json
      end

      private

      def usuario_atributos(usuario)
        {id: usuario.id, name: usuario.nombre, 'respuesta': "Bienvenido #{usuario.nombre}"}
      end

      def usuario_mapper
        Persistence::Mappers::UserMapper.new
      end
    end

    helpers UsuarioHelper
  end
end
