require_relative '../../helpers/pedido_helper'
module Persistencia
  module Repositorios
    class RepositorioRepartidor < RepositorioAbstracto
      self.table_name = :repartidores
      self.model_class = 'Repartidor'

      def primero
        registro_encontrado = dataset.first(:id_pedido => 0)
        if registro_encontrado.nil?
          raise ErrorNoHayRepartidores
        end
        cargar_objeto dataset.first
      end

      protected

      def cargar_objeto(un_hash)
        extend WebTemplate::App::PedidoHelper
        pedidos = pedido_repo.find_asignados_a_repartidor(un_hash[:id])
        id_pedidos = []
        pedidos.each do |pedido|
          id_pedidos.append(pedido.id)
        end
        Repartidor.new(un_hash[:nombre], un_hash[:dni], un_hash[:telefono], un_hash[:id], id_pedidos, un_hash[:volumen_ocupado])
      end

      def cambio(repartidor)
        {
            nombre: repartidor.nombre,
            dni: repartidor.dni.to_i,
            telefono: repartidor.telefono.to_i,
            volumen_ocupado: repartidor.volumen_ocupado.to_i
        }
      end
    end
  end
end
