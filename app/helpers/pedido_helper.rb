# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module PedidoHelper
      def pedido_repo
        Persistencia::Repositorios::RepositorioPedido.new
      end

      def menu_repo
        Persistencia::Repositorios::RepositorioMenu.new
      end

      def pedido_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def pedido_a_json(pedido)
        pedido_actualizado = pedido_atributos pedido
        if pedido.estado == ESTADO_PEDIDO::ENVIANDO
          id_repartidor = pedido.id_repartidor
          repartidor = repartidor_repo.buscar(id_repartidor)
          pedido_actualizado.merge!(mensaje: "Pedido asignado al repartidor #{repartidor.nombre}")
        end
        pedido_actualizado.to_json
      end

      def pedido_a_hash(pedido)
        pedido_atributos(pedido)
      end

      def pedidos_a_json(pedidos)
        pedidos.map { |pedido| pedido_atributos(pedido) }.to_json
      end

      private

      def pedido_atributos(pedido)
        {
            id: "#{pedido.id}",
            menu: pedido.menu,
            usuario: pedido.usuario,
            respuesta: "Pedido exitoso del menu: #{pedido.menu}. Tu numero de pedido es: #{pedido.id}",
            estado: "#{ESTADO_PEDIDO_SALIDA[pedido.estado.orden]}",
            id_repartidor: pedido.id_repartidor,
            id_usuario: pedido.id_usuario,
            puntaje: pedido.puntaje
        }
      end

      def respuesta_estado(estado)
        ESTADO_PEDIDO_SALIDA[estado.orden]
      end

      def pedido_mapper
        Persistence::Mappers::PedidoMapper.new
      end
    end
    ESTADO_PEDIDO_SALIDA =
        {
            ESTADO_PEDIDO::RECIBIDO => "Recibido",
            ESTADO_PEDIDO::PREPARANDO => "Preparando",
            ESTADO_PEDIDO::ENVIANDO => "Enviando",
            ESTADO_PEDIDO::ENTREGADO => "Entregado",
            ESTADO_PEDIDO::CANCELADO => "Cancelado"
        }

    helpers PedidoHelper
  end
end
