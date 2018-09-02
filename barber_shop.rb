!#/usr/bin/ruby
require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  @user_name = params[:username]
  @phone = params[:phone]
  @date = params[:date]
  File.open('./public/client.txt','a') do |file|
    file.puts "Client: #{@user_name};Phone: #{@phone}; Date and time: #{@date}"
  end
  erb :messages
end

get '/admin' do
  erb :admins
end

post '/admin' do
  @login = params[:login]
  @password = params[:password]
  if @login == "admin" && @password == "password"
    erb :clients
  else
    erb :error
  end
end