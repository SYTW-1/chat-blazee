# -*- coding: utf-8 -*-
require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../app.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'rspec'


include Rack::Test::Methods

=begin
describe "Test APP chat: Comprobacion de enlaces" do

	def app
	   Sinatra::Application
	end

   before :each do
	  @browser = Selenium::WebDriver.for :firefox
	  @site = 'https://chat-blazee.herokuapp.com/'
	  if (ARGV[0].to_s == "local")
		 @site = 'localhost:9292/'
	  end
	  @browser.get(@site)
   end
   
   after :each do
	  @browser.quit
   end

   it "The user Prueba can access to chat" do
	 	@browser.manage.timeouts.implicit_wait = 5
		element = @browser.find_element(:id,"username")
		element.send_keys("Prueba")
		element.submit 
	 	expect(@browser.find_element(:id,"welcome").text).to eq("Welcome: Prueba\nLog Out")
   end
   it "The user send a post" do
   		@browser.get(@site)
	 	@browser.manage.timeouts.implicit_wait = 5
		element = @browser.find_element(:id,"username")
		element.send_keys("Prueba")
		element.submit 
	 	element = @browser.find_element(:id,"text")
	 	element.send_keys("Hola")
		element.send_keys:return
		expect(@browser.find_element(:id,"name").text).to eq("Hola")
   end
   it "User prueba logout" do
	 	@browser.manage.timeouts.implicit_wait = 5
		element = @browser.find_element(:id,"username")
		element.send_keys("Prueba")
		element.submit 
	 	element = @browser.find_element(:id,"logout")
		element.click
		expect(@browser.find_element(:id,"title").text).to eq("Please sign in")
   end
end
=end
describe "Test APP chat: Comprobacion de funciones" do

	def app
	   Sinatra::Application
	end

	it "No hay sesion iniciada" do
		get '/'
		expect(last_response).to be_ok
	end

	it "post" do
		post '/'
		expect(last_response).to be_ok
	end

	it "Cierre de sesion" do
		get '/logout'
		expect(last_response.body).to eq("")
	end

	it "Envio" do
		get '/send'
		expect(last_response.body).to eq("")
	end

	it "Update" do
		get '/update'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "User" do
		get '/user'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "chat update" do
		get '/chat/update'
		expect(last_response.body).to eq("Not an ajax request")
	end

end