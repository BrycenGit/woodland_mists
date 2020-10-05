require('sinatra')
require('sinatra/reloader')
require('./lib/stage')
require('./lib/artist')
require("pg")
require('dotenv/load')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "woodland_mists", :password => ENV['PG_PASS']})

get('/') do
  @stages = Stage.all
  erb(:stages)
end

get('/stages') do
  @stages = Stage.all
  erb(:stages)
end

get('/stages/:id') do
  @stage = Stage.find(params[:id].to_i)
  erb(:stage)
end

get('/stages/:id/artists/:artist_id') do
  @artist = Artist.find(params[:artist_id].to_i)
  @stage = Stage.find(params[:id].to_i)
  erb(:artist)
end

post('/stages') do
  location = params[:location]
  name = params[:name]
  stage = Stage.new({:name => name, :location => location, :id => nil})
  stage.save
  @stages = Stage.all
  erb(:stages)
end

post('/stages/:id/artists') do
  @stage = Stage.find(params[:id].to_i)
  time = params[:artist_time]
  artist = Artist.new({:name => params[:artist_name], :stage_id => @stage.id, :id => nil, :time => time})

  artist.save
  erb(:stage)
end



