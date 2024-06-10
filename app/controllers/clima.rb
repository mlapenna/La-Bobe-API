WebTemplate::App.controllers :clima, :provides => [:json] do
  get :show, :map => '/mock_lluvia' do
    status 200
    { activado: ClimaMockStatus.activado,
      esta_lloviendo: ClimaMockStatus.esta_lloviendo }.to_json
  end

  put :actualizar, :map => '/mock_lluvia_activar' do
    params = JSON.parse(request.body.read).symbolize_keys
    ClimaMockStatus.activar(true, params[:esta_lloviendo])
    status 200
    { activado: ClimaMockStatus.activado,
      esta_lloviendo: ClimaMockStatus.esta_lloviendo }.to_json
  end

  put :actualizar, :map => '/mock_lluvia_desactivar' do
    ClimaMockStatus.activar(false)
    status 200
    { activado: ClimaMockStatus.activado }.to_json
  end
end
