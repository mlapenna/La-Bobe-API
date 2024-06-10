# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module RepartidorHelper
      def repartidor_repo
        Persistencia::Repositorios::RepositorioRepartidor.new
      end

      def repartidor_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def repartidor_a_json(repartidor)
        repartidor_atributos(repartidor).to_json
      end

      def repartidores_a_json(repartidores)
        repartidores.map { |repartidor| repartidor_atributos(repartidor) }.to_json
      end

      private

      def repartidor_atributos(repartidor)
        {
            id: "#{repartidor.id}",
            name: repartidor.nombre,
            'respuesta': "Bienvenido repartidor #{repartidor.nombre}",
            id_pedido: repartidor.id_pedidos
        }
      end

      def repartidor_mapper
        Persistence::Mappers::RepartidorMapper.new
      end
    end

    helpers RepartidorHelper
  end
end
