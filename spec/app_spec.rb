# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../app.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'coveralls'
require 'rspec'
Coveralls.wear!

include Rack::Test::Methods

def app
   Sinatra::Application
end

describe "Test APP chat: Comprobacion de enlaces" do

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