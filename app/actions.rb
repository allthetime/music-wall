require 'digest'

helpers do
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
  def users
    @users = User.all
  end
  def songs
    @songs = Song.all
  end
end

get '/' do
  @users = User.all
  @songs = Song.all
  erb :index
end

get '/new' do
  @song = Song.new
  erb :new
end

post '/new' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  if session[:user_id]
    User.find(session[:user_id]).songs << @song
    redirect '/'
  elsif @song.save
    redirect '/'
  else
    erb :new
  end
end

get '/signup' do
  @user = User.new
  erb :signup
end

post '/signup' do
  password = Digest::SHA256.hexdigest params[:password]
  @user = User.new(
    name: params[:name].downcase,
    password: password
  )
  if @user.save
    redirect '/'
  else
    erb :signup
  end
end

post '/login' do
  password = Digest::SHA256.hexdigest params[:password]
  if User.find_by(name: params[:name].downcase).password == password
    session[:user_id] = User.find_by(name: params[:name])
    redirect '/'
  else
    erb :index
  end 
end

post '/logout' do
  session.clear
  redirect '/'
end

get '/:id' do
  @song = Song.find(params[:id])
  erb :song
end

get '/users/:name' do 
  @user = User.find_by(name: params[:name])
  @songs = Song.where(user_id: @user.id)
  erb :'users/index'
end

post '/like' do
  vote = Vote.new(
    user_id: current_user.id,
    song_id: params[:id]
  )
  if !(current_user.votes.to_a.include? Vote.find_by(song_id: params[:id],user_id:current_user.id)) 
    vote.save
    redirect '/'
  elsif current_user.nil?
    erb :index
  else
    erb :index
  end
end


post '/unlike' do
  if current_user.votes.to_a.include? Vote.find_by(song_id: params[:id],user_id:current_user.id)
    Vote.find_by(song_id: params[:id],user_id:current_user.id).destroy
    redirect '/'
  elsif current_user.nil?
    erb :index
  else
    erb :index
  end
end



