require 'integracion_helper'

describe Persistencia::Repositorios::RepositorioUsuario do
  let(:usuario_repo) { Persistencia::Repositorios::RepositorioUsuario.new }
  let(:un_usuario) { Usuario.new('Juan', 'La Pampa 123', '12345644') }

  it 'debería guardar el nuevo usuario' do
    usuario_repo.guardar(un_usuario)
    expect(usuario_repo.todos.count).to eq(1)
  end

  it 'debería asignar un id al nuevo usaurio' do
    nuevo_usuario = usuario_repo.guardar(un_usuario)
    expect(nuevo_usuario.id).to be_present
  end

   context 'cuando un usuario existe' do
    before :each do
      @nuevo_usuario = usuario_repo.guardar(un_usuario)
      @usuario_id = @nuevo_usuario.id
    end

    it 'debería borrar el usaurio' do
      usuario_repo.borrar(@nuevo_usuario)

      expect(usuario_repo.todos.count).to eq(0)
    end

    it 'debería borrar todos los usuarios' do
      usuario_repo.borrar_todos

      expect(usuario_repo.todos.count).to eq(0)
    end

    it 'debería encontrar el usuario por el id' do
      usuario = usuario_repo.buscar(@usuario_id)

      expect(usuario.nombre).to eq(@nuevo_usuario.nombre)
    end
   end

  it 'debería lanzar una excepción cuando trata de encontrar un usuario inexistente' do
    expect do
      usuario_repo.buscar(99_999)
    end.to raise_error(ErrorObjetoNoEncontrado)
  end

end
