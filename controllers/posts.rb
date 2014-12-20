class Chit_Chat < Sinatra::Base

  get '/' do
    if !authorized?
      user = User.new
      user.score = 0
      user.save
      session[:user_id] = user.id
    end

    @posts = Post.all
    @votes = current_user.votes_dataset

    erb :main
  end

  post '/new' do

    post = Post.new

    post.creator = current_user
    post.text = params[:text]
    post.score = 0
    post.time_created = Time.now.to_i

    begin
      post.save
    rescue
      redirect url('/')
    end

    redirect url('/')

  end

  post '/post/upvote' do
    post = Post.where(:id => params[:post_id]).first
    vote = post.votes_dataset.where(:owner_id => current_user.id).first
    #puts vote.inspect

    if vote == nil
      vote = Vote.new
      vote.value = 1
      vote.owner = current_user
      vote.post = post
      vote.save
    elsif vote.value == 1
      return {:score => post.score.to_s}.to_json
    elsif vote.value == -1
      vote.value = 1
      vote.save
    end

    post.votes.each do |vote|
      post.score = 0
      post.score += vote.value
    end
   # puts post.score.inspect
    post.save

    return {:score => post.score.to_s}.to_json


  end

  post '/post/downvote' do
    post = Post.where(:id => params[:post_id]).first
    vote = post.votes_dataset.where(:owner_id => current_user.id).first
    #puts vote.inspect

    if vote == nil
      vote = Vote.new
      vote.value = -1
      vote.owner = current_user
      vote.post = post
      vote.save
    elsif vote.value == -1
      return {:score => post.score.to_s}.to_json
    elsif vote.value == 1
      vote.value = -1
      vote.save
    end

    post.votes.each do |vote|
      post.score = 0
      post.score += vote.value
    end
   # puts post.score.inspect
    post.save
    return {:score => post.score.to_s}.to_json

  end
end


