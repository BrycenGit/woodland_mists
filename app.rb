require('sinatra')
require('sinatra/reloader')
require('./lib/stage')
require('./lib/artist')
also_reload('lib/**/*.rb')

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
  erb(:artist)
end

post('/stages') do
  location = params[:location]
  name = params[:name]
  stage = Stage.new(name, location, nil)
  stage.save
  @stages = Stage.all
  erb(:stages)
end

post('/stages/:id/artists') do
  @stage = Stage.find(params[:id].to_i)
  artist = Artist.new(params[:artist_name], @stage.id, nil)
  artist.save
  erb(:stage)
end



