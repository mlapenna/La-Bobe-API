require 'integracion_helper'

describe Persistencia::Repositorios::RepositorioMenu do
  let(:menu_repo) { Persistencia::Repositorios::RepositorioMenu.new }

  it 'deberían existir 3 menúes' do
    expect(menu_repo.todos.count).to eq(3)
  end
end
