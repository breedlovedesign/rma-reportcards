# encoding: utf-8
require 'sinatra'
require 'haml'
require 'lingua'
require 'differ'

require "sinatra"
require "bundler/setup"
require "haml"
require "mongoid"
require "sinatra/flash"
require "sinatra/form_helpers"
require "sinatra/simple-navigation"
require 'pp'
require 'stamp'

require_relative 'minify_resources'
class RmaReports < Sinatra::Application
	enable :sessions

	configure :production do
		set :haml, { :ugly=>true }
		set :clean_trace, true
		set :css_files, :blob
		set :js_files,  :blob
		MinifyResources.minify_all
	end

	configure :development do
		set :clean_trace, true
		set :css_files, MinifyResources::CSS_FILES
		set :js_files,  MinifyResources::JS_FILES
		set :session_secret, 'all_your_base'
	end

	helpers do
		include Rack::Utils
		alias_method :h, :escape_html
	end
end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/init'