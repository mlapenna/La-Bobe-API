module Persistencia
  module Repositorios
    class RepositorioPedido < RepositorioAbstracto
      self.table_name = :pedidos
      self.model_class = 'Pedido'

      def guardar(un_registro)
        begin
          menu_repo = Persistencia::Repositorios::RepositorioMenu.new
          menu_repo.buscar_por_nombre(un_registro.menu)
        rescue ErrorObjetoNoEncontrado => e
          raise ErrorMenuInexistente
        end

        if buscar_por_id(un_registro.id).first
          actualizar(un_registro)
        else
          insertar(un_registro)
        end
        un_registro
      end

      def find_asignados_a_repartidor(id_repartidor)
        cargar_colleccion dataset.where(id_repartidor: id_repartidor)
        pedidos = []
        dataset.each do |item|
          pedido = cargar_objeto item
          next if pedido.id_repartidor != id_repartidor.to_i
          pedidos.append(pedido)
        end
        pedidos
      end

      protected

      def cargar_objeto(un_hash)
        Pedido.new(un_hash[:menu], un_hash[:usuario], CARGAR_ESTADO_MAPPER[un_hash[:estado]], un_hash[:id_usuario], un_hash[:comision], un_hash[:id_repartidor],
                   un_hash[:id], un_hash[:puntaje])
      end

      CARGAR_ESTADO_MAPPER =
        {
          1 => EstadoRecibido.new,
          2 => EstadoPreparando.new,
          3 => EstadoEnviando.new,
          4 => EstadoEntregado.new,
          5 => EstadoCancelado.new
        }

      def cambio(pedido)
        {
            menu: pedido.menu,
            usuario: pedido.usuario,
            estado: pedido.estado.orden.to_i,
            id_usuario: pedido.id_usuario.to_i,
            id_repartidor: pedido.id_repartidor.to_i,
            comision: pedido.comision,
            puntaje: pedido.puntaje
        }
      end
    end
  end
end
