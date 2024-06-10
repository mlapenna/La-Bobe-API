# rubocop:disable all
ENV['RACK_ENV'] = 'test'
ENV['ENABLE_RESET'] = 'true'

require File.expand_path("#{File.dirname(__FILE__)}/../../config/boot")

require 'rspec/expectations'

if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  BASE_URL = 'http://localhost:3000'.freeze
  include Rack::Test::Methods
  def app
    Padrino.application
  end
end

def header
  {'Content-Type' => 'application/json'}
end

def find_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def find_task_url(task_id)
  "#{BASE_URL}/tasks/#{task_id}"
end

def update_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def find_all_users_url
  "#{BASE_URL}/users"
end

def create_user_url
  "#{BASE_URL}/users"
end

def create_repartidor_url
  "#{BASE_URL}/repartidor"
end

def asignar_pedido_url
  "#{BASE_URL}/repartidor"
end

def create_pedido_url
  "#{BASE_URL}/pedidos"
end

def create_pedido_de_usuario_url
  "#{BASE_URL}/pedidos_de_usuario"
end

def devolver_pedido_url
  "#{BASE_URL}/pedidos"
end

def progresar_estado_pedido_url
  "#{BASE_URL}/progresar_estado"
end

def estado_pedido_url
  "#{BASE_URL}/pedidos"
end

def comision_pedido_url
  "#{BASE_URL}/comision_pedido"
end

def devolver_repartidor_url
  "#{BASE_URL}/repartidor"
end

def delete_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def calificar_pedido_url
  "#{BASE_URL}/calificar_pedido"
end

def cancelar_pedido_url
  "#{BASE_URL}/cancelar_pedido"
end

def reset_url
  "#{BASE_URL}/reset"
end

def mock_lluvia_url
  "#{BASE_URL}/mock_lluvia_activar"
end

After do |_scenario|
  Faraday.post(reset_url)
end

