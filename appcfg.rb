require 'sinatra'

set :public_folder, File.dirname(__FILE__)

get '/' do
    redirect "index.html"
end

post '/createOrLocate' do
    redirect "/" + params[:state] + "/" + params[:zip] + "/" + params[:city] + "/" + params[:name]
end
