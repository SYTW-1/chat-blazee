# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../app.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'

include Rack::Test::Methods

def app
   Sinatra::Application
end

describe "Test APP chat: Comprobacion de enlaces" do

   before :all do
	  @browser = Selenium::WebDriver.for :firefox
	  @site = 'https://chat-blazee.herokuapp.com/'
	  if (ARGV[0].to_s == "local")
		 @site = 'localhost:9292/'
	  end
	  @browser.get(@site)
   end
   
   after :all do
	  @browser.quit
   end

   it "The user Prueba can access to chat" do
	 begin
	 	@browser.manage.timeouts.implicit_wait = 5
		element = @browser.find_element(:id,"username")
		element.send_keys("Prueba")
		element.submit 
	 ensure
		assert_equal("Welcome: Prueba\nLog Out", @browser.find_element(:id,"welcome").text)
	 end
   end
   it "The user send a post" do
	 begin
	 	@browser.manage.timeouts.implicit_wait = 5
		element = @browser.find_element(:id,"username")
		element.send_keys("Prueba")
		element.submit 
	 ensure
	 	element = @browser.find_element(:id,"text")
	 	element.send_keys("Hola")
		element.send_keys:return
		assert_equal("Hola", @browser.find_element(:id,"name").text)
	 end
   end
end