class Chit_Chat < Sinatra::Base

  post '/user/update' do

    if params[:user_id] == 0
      user = User.new
      user.score = 0
      user.save

      session[:user_id] = user.id
      return {:new_user_id => user.id}.to_json
    else
      session[:user_id] = params[:user_id]
      return true
    end

  end

end

