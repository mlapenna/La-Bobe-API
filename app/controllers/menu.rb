WebTemplate::App.controllers :menu, :provides => [:json] do
  get :index do
    menu_repo = Persistencia::Repositorios::RepositorioMenu.new
    menu_final = ''

    menu_repo.todos.each do |un_menu|
      menu_final += ', ' if menu_final != ''
      menu_final = "#{menu_final}#{un_menu.nombre} #{un_menu.precio}"
    end

    {menu: menu_final}.to_json
  end
end
