class Chit_Chat < Sinatra::Base

  post '/user/location' do

    puts "params " + params[:latitude].to_s
    puts "params " + params[:longitude].to_s

    user = User.where(:id => session[:user_id]).first

    user.latitude = params[:latitude].to_f
    user.longitude = params[:longitude].to_f

    user.save

    puts current_user.inspect

    redirect url('/')

  end
end

