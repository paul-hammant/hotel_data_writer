require 'sinatra'

set :public_folder, File.dirname(__FILE__)

get '/' do
    redirect "index.html"
end

post '/createOrLocate' do
    redirect "/hotel/" + params[:state] + "/" + params[:zip] + "/" + params[:city] + "/" + params[:name]
end

get '/hotel/:state/:zip/:city/:name' do |state, zip, city, name|
    send_file 'edit.html'
end
