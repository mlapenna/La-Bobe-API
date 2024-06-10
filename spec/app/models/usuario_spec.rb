require 'spec_helper'

describe Usuario do
  context 'cuando es creado' do

    it 'se crea un usuario con nombre, direccion y telefono, y se verifica' do
      usuario = described_class.new('Juan', 'La Pampa 123', '12345678')
      expect(usuario.nombre).to eq('Juan')
      expect(usuario.direccion).to eq('La Pampa 123')
      expect(usuario.telefono).to eq('12345678')
    end

    it 'se crea un usuario sin nombre y devuelve error' do
      expect { described_class.new('', 'Av.Cabildo 1', '42245252') }.to raise_error(UsuarioInvalido)
    end

    it 'se crea un usuario con nombre mayor a 20 caracteres de largo y devuelve error' do
      expect { described_class.new('', 'Av.Cabildo 1 pero también Cabildo 2', '42245252') }.to raise_error(UsuarioInvalido)
    end

    it 'se crea un usuario sin dirección y devuelve error' do
      expect { described_class.new('Ariel', '', '42245252') }.to raise_error(UsuarioInvalido)
    end

    it 'se crea un usuario con dirección menor a 5 caracteres de tamaño' do
      expect { described_class.new('Ariel', 'Acoy', '42245252') }.to raise_error(UsuarioInvalido)
    end

    it 'se crea un usuario con teléfono vacío y devuelve error' do
      expect { described_class.new('Ariel', 'Acoyte 123', nil) }.to raise_error(UsuarioInvalido)
    end

    it 'se crea un usuario con teléfono no numérico y devuelve error' do
      expect { described_class.new('Ariel', 'Acoyte 123', 'abcdefghi') }.to raise_error(UsuarioInvalido)
    end

  end
end
