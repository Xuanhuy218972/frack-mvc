require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Rack::Builder.new do
    eval(File.read(File.expand_path('./config.ru')))
end

describe 'user#index' do
    before {visit '/' }

    it  'renders layout' do 
        expect(page).to have_content('application#layout')
    end

    it 'renders index view' do 
        expect(page).to have_content('user#index')
    end

    it 'show a list of user' do
        expect(page).to have_selector('li', 
            text: /Stark|Parker|Wayne/, count: 3)
    end
end