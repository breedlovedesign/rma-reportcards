# encoding: utf-8
require 'sinatra'
require 'omniauth'
require 'omniauth-twitter'

require_relative 'minify_resources'
class RmaReports < Sinatra::Application
	enable :sessions

	use Rack::Session::Cookie
	use OmniAuth::Strategies::Developer
	use OmniAuth::Strategies::Twitter, 'YRbqYF5AtGpj4CPYwLFsIQ', 'PqgnFQZBoKu9mdAfEwc16k46PhwNEych2lw344Uo'


	
	configure :production do
		set :haml, { :ugly=>true }
		set :clean_trace, true
		set :css_files, :blob
		set :js_files,  :blob
		MinifyResources.minify_all
	end

	configure :development do
		set :css_files, MinifyResources::CSS_FILES
		set :js_files,  MinifyResources::JS_FILES
	end

	helpers do
		include Rack::Utils
		alias_method :h, :escape_html

		def current_user
			@current_user ||= User.get(session[:user_id]) if session[:user_id]
		end
	end
end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/init'