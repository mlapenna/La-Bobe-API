# Given(/^que el Usuario "([^"]*)" esta registrado$/) do |name|
#   @request = {name: name}.to_json
#   @response = Faraday.post(create_user_url, @request, header)
#   expect(@response.status).to eq(201)
# end

Given(/^que existe un menu$/) do
  @response = Faraday.get("#{BASE_URL}/menu")
  expect(@response.status).to eq(200)
end

When(/^consulto las opciones de menu$/) do
  menu = JSON.parse(@response.body)
  @expected_menu = menu['menu']
end

Then(/^obtengo "([^"]*)", con precio (\d+)$/) do |message, price|
  expect(@expected_menu).to include(message)
  expect(@expected_menu).to include(price.to_s)
end
