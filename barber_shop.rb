!#/usr/bin/ruby
require 'sinatra'
require 'sqlite3'

configure do
  @db = SQLite3::Database.new 'barber_shop.db'
  @db.execute 'CREATE TABLE "users"
  (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "username" TEXT,
    "phone" TEXT,
    "date" TEXT, 
    "barber" TEXT
  );'
end

get '/' do
  erb :index
end

post '/' do
  @user_name = params[:username]
  @phone = params[:phone]
  @date = params[:date]
  @barber = params[:barber]
  File.open('./public/client.txt','a') do |file|
    file.puts "Client: #{@user_name};Phone: #{@phone}; Date and time: #{@date}, barber: #{@barber}"
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
    @client_file = File.open('./public/client.txt','r')
    erb :clients
  else
    erb :error
  end
end