require_relative '../helpers/repartidor_helper.rb'
require_relative '../helpers/usuario_helper.rb'
require_relative "../helpers/pedido_helper"

class LaBobe
  extend WebTemplate::App::PedidoHelper
  extend WebTemplate::App::RepartidorHelper
  extend WebTemplate::App::UsuarioHelper

  def self.progresar_estado_pedido(id)
    pedido = pedido_repo.buscar(id)
    pedido = pedido.progresar_estado(self.clima)

    pedido_repo.guardar(pedido)
  end

  def self.borrar_pedido(id)
    pedido = pedido_repo.buscar(id)
    pedido_repo.borrar(pedido)
  end

  def self.crear_pedido(menu, usuario, id_usuario)
    PedidoCreator.new(pedido_repo).crear_pedido(menu, usuario, id_usuario)
  end

  # TODO: pisar a "self.crear_pedido", arreglar errores que pueda causar esto
  def self.crear_pedido_con_usuario_registrado(menu, usuario, id_usuario)
    usuario_repo.find_por_id_usuario id_usuario
    PedidoCreator.new(pedido_repo).crear_pedido(menu, usuario, id_usuario)
  end

  def self.get_pedido(id_pedido)
    pedido_repo.buscar(id_pedido)
  end

  def self.get_pedido_de_usuario(id_usuario, id_pedido)
    pedido = pedido_repo.buscar(id_pedido)
    raise UsuarioNoTienePermisosParaConsultarElPedido unless pedido.id_usuario == id_usuario.to_i
    pedido
  end

  def self.calificar_pedido(pedido, puntaje)
    menues = menu_repo.todos
    pedido.calificar(puntaje, self.clima, menues)
  end

  def self.seleccionar_mejor_candidato_a_ser_asignado(repartidores_candidato)
    mejores_repartidores_candidato = repartidores_candidato.select { |_, v| v == repartidores_candidato.values.max }
    repartidor_repo.buscar(mejores_repartidores_candidato.keys[0])
  end

  def self.asignar_pedido(id, pedido)
    repartidores = repartidor_repo.todos
    if repartidores.nil?
      raise ErrorNoHayRepartidores
    end
    repartidores_candidato = {}
    repartidores.each do |repartidor|
      if repartidor.puedo_asignar_pedido?(VOLUMEN_PEDIDO_MAPPER[pedido.menu])
        repartidores_candidato.merge!({ "#{repartidor.id}" => VOLUMEN_PEDIDO_MAPPER[pedido.menu] + repartidor.volumen_ocupado })
      end
    end
    raise ErrorNoHayRepartidores if repartidores_candidato.empty?
    repartidor_a_ser_asignado = seleccionar_mejor_candidato_a_ser_asignado(repartidores_candidato)
    repartidor_a_ser_asignado.asignar_pedido(id, VOLUMEN_PEDIDO_MAPPER[pedido.menu])
    repartidor_repo.guardar(repartidor_a_ser_asignado)
    pedido.asignar_repartidor(repartidor_a_ser_asignado.id)
    return pedido

  end

  VOLUMEN_PEDIDO_MAPPER =
    {
      'Individual' => VOLUMEN_PEDIDOS::MENU_INDIVIDUAL,
      'Pareja' => VOLUMEN_PEDIDOS::MENU_PAREJA,
      'Familiar' => VOLUMEN_PEDIDOS::MENU_FAMILIAR
    }

  def self.desasignar_pedido(pedido)
    repartidor = repartidor_repo.buscar(pedido.id_repartidor)
    unless repartidor.nil?
      repartidor.desasignar_pedido(pedido.id, VOLUMEN_PEDIDO_MAPPER[pedido.menu])
      pedido.desasignar_repartidor
      repartidor_repo.guardar(repartidor)
    end
    pedido
  rescue ErrorObjetoNoEncontrado
    pedido
  end

  def self.get_todos_los_pedidos
    all_pedidos = pedido_repo.todos
    all_pedidos
  end

  def self.clima
    if ClimaMockStatus.activado
      ClimaMock.new(ClimaMockStatus.esta_lloviendo)
    else
      open_weather_es = OpenWeatherES.new
      Clima.new(open_weather_es.clima)
    end
  end
end
