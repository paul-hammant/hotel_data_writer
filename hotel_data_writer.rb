require 'rubygems'
require 'sinatra'
require 'json'
require 'fileutils'

set :public_folder, File.dirname(__FILE__)

get '/' do
    redirect 'index.html'
end

post '/createOrLocate' do
    redirect '/' + params[:state] + '/' + params[:zip] + '/' + params[:city].gsub(" ", "_") + '/' + params[:name].gsub(" ", "_")
end

get '/:state/:zip/:city/:name.json' do |state, zip, city, name|
    content_type 'application/json', :charset => 'utf-8'

    hotelPath = "./#{state}/#{zip}/#{city.gsub(" ", "_")}/#{name.gsub(" ", "_")}.json"
    hotelFile = File.open(hotelPath, 'r')
    hotelFile.read
end

post '/:state/:zip/:city/:name.json' do |state, zip, city, name|
    content_type 'application/json', :charset => 'utf-8'
    content = request.body.read
    contentJson = JSON.parse(content)
    hotelDir = "./#{state}/#{zip}/#{city}"
    FileUtils.mkdir_p(hotelDir)
    hotelPath = "#{hotelDir}/#{name}.json"
    hotelFile = File.open(hotelPath, 'w+')
    // pretty_generate does not reorder nodes alphabetically, jshon does.
    %x[jshon -ISF ./#{hotelPath}]
    hotelFile.write(contentJson)

    hotelFile.close

    contentJson
end

get '/:state/:zip/:city/:name' do |state, zip, city, name|
    send_file 'edit.html'
end
