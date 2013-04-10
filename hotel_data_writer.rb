require 'sinatra'

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

put '/:state/:zip/:city/:name.json' do |state, zip, city, name|
    content_type 'application/json', :charset => 'utf-8'
    content = request.body.read

    hotelPath = "./#{state}/#{zip}/#{city}/#{name}.json"
    hotelFile = File.open(hotelPath, 'w')
    hotelFile.write(content)
    hotelFile.close

    content
end

get '/:state/:zip/:city/:name' do |state, zip, city, name|
    send_file 'edit.html'
end
