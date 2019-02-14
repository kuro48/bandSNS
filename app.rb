require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'
require 'pry'

require './models'

require 'bcrypt'
# require "./show_table_action"

enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

get '/' do
    if current_user.nil?
        @posts = Post.none
        erb :sign_in
    else
        @posts = Post.order("id DESC")
        erb :index
    end
end

get '/signup' do
    erb :sign_up
end

post '/signup' do
    o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten

    @user = User.create(
        nickname: params[:nickname],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        username: (0...8).map { o[rand(o.length)] }.join
    )
    if @user.persisted?
        session[:user] = @user.id
    end
    redirect '/'
end

get '/signin' do
    erb :sign_in
end

post '/signin' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/users/:username/useredit' do
    erb :user_edit
end

post '/users/:username/useredit' do
    user = User.find(session[:user])
    user.discription = params[:discription]
    user.save!
    redirect '/users/:username'
end

get '/users/:username' do
    if current_user.nil?
        @posts = Post.none
    else
        @posts = current_user.posts
    end
    erb :user_page
end

get '/newpost' do
    erb :new_post
end

post '/newpost' do
    current_user.posts.create(text: params[:text])
    redirect '/'
end

post '/post/:id/delete' do
    post = Post.find(params[:id])
    if post.user_id == current_user.id
    post.destroy
    end
    redirect '/'
end

get '/mordal' do
    @post = Post.find(params[:id])
    erb :mordal, :layout => false
end