class Chit_Chat < Sinatra::Base

  get '/' do

    if !params["order"]
      params["order"] = "newest"
    end

    if !params["myDisplay"]
      params["myDisplay"] = "chats"
    end

    if !authorized?

      puts "unauthorized"
      user = User.new
      user.score = 0
      user.save
      session[:user_id] = user.id
    end

    @posts = []

    if current_user.latitude and current_user.longitude

      if params["order"] == "newest"
        Post.order(:time_created).reverse.each do |post|
          if find_distance(current_user.latitude,current_user.longitude,post.latitude,post.longitude) <= 20
            @posts << post
          end
        end
      elsif params["order"] == "voted"
        Post.order(:score).reverse.each do |post|
          if find_distance(current_user.latitude,current_user.longitude,post.latitude,post.longitude) <= 20
            @posts << post
          end
        end
      elsif params["order"] == "commented"
        Post.order(:num_comments).reverse.each do |post|
          if find_distance(current_user.latitude,current_user.longitude,post.latitude,post.longitude) <= 20
            @posts << post
          end
        end
      end
    end

    @votes = current_user.votes_dataset

    if params["myDisplay"] == "chats"
      @my_posts = Post.where(:creator_id => current_user.id).order(:score).reverse
    elsif params["myDisplay"] == "comments"
      @my_posts = []
      current_user.comments_dataset.each do |comment|
        puts comment
        @my_posts << comment.post
      end
    end
    erb :main
  end

  post '/new' do

    post = Post.new
    puts params[:latitude].inspect
    puts params[:longitude].inspect

    post.creator = current_user
    post.text = params[:text]
    post.latitude = params[:latitude]
    post.longitude = params[:longitude]
    post.score = 0
    post.num_comments = 0
    post.time_created = Time.now.to_i

    post.save

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

  post '/post/:post_id/delete' do

    post = Post.where(:id => params[:post_id]).first
    post.comments_dataset.destroy
    post.destroy
    redirect url('/')
  end
end