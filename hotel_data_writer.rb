require 'sinatra'
require 'json'

set :public_folder, File.dirname(__FILE__)

get '/' do
    redirect 'index.html'
end

post '/createOrLocate' do
    redirect '/' + params[:state] + '/' + params[:zip] + '/' + params[:city] + '/' + params[:name]
end

get '/:state/:zip/:city/:name.json' do |state, zip, city, name|
    content_type 'application/json', :charset => 'utf-8'

    hotelPath = "./#{state}/#{zip}/#{city}/#{name}.json"
    hotelFile = File.open(hotelPath, 'r')
    hotelFile.read
end

post '/:state/:zip/:city/:name.json' do |state, zip, city, name|
    content_type 'application/json', :charset => 'utf-8'
    content = request.body.read
    contentJson = JSON.parse(content)
    contentPrettyPrint = JSON.pretty_generate(contentJson)

    hotelPath = "./#{state}/#{zip}/#{city}/#{name}.json"
    hotelFile = File.open(hotelPath, 'w')
    hotelFile.write(contentPrettyPrint)
    hotelFile.close

    contentPrettyPrint
end

get '/:state/:zip/:city/:name' do |state, zip, city, name|
    send_file 'edit.html'
end
