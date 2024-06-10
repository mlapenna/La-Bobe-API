# rubocop:disable all
require 'spec_helper'
require_relative './factories/usuario_factory'

RSpec.configure do |config|
  config.include UsuarioFactory
  config.after :each do
    Persistencia::Repositorios::RepositorioUsuario.new.borrar_todos
    Persistencia::Repositorios::RepositorioRepartidor.new.borrar_todos
    Persistencia::Repositorios::RepositorioPedido.new.borrar_todos
  end
end
