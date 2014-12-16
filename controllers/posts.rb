class Chit_Chat < Sinatra::Base

  get '/' do
    if !authorized?
      user = User.new
      user.score = 0
      user.save
      session[:user_id] = user.id
    end

    @posts = Post.all

    erb :main
  end

  post '/new' do

    post = Post.new

    post.creator = current_user
    post.text = params[:text]
    post.score = 0

    begin
      post.save
    rescue
      redirect url('/')
    end

    redirect url('/')

  end

end


