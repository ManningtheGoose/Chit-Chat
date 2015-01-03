class Chit_Chat < Sinatra::Base

  get '/post/:post_id/comments' do

    if !params["order"]
      params["order"] = "newest"
    end

    if params["order"] == "newest"
      @comments = Comment.where(:post_id => params[:post_id]).order(:time_created).reverse
    elsif params["order"] == "voted"
      @comments = Comment.where(:post_id => params[:post_id]).order(:score).reverse
    end
    @post = Post.where(:id => params[:post_id]).first
    @votes = current_user.votes_dataset
    erb :post
  end

  post '/:post_id/comment/new' do
    comment = Comment.new
    comment.text = params[:text]
    comment.creator = current_user
    comment.post = Post.where(:id => params[:post_id]).first
    comment.post.num_comments += 1
    comment.score = 0
    comment.time_created = Time.now.to_i

    comment.post.save
    comment.save

    redirect url('/post/'+params[:post_id]+'/comments')
  end

  post '/comment/:id/delete' do
    comment = Comment.where(:id => params[:comment_id])
    comment.destroy
  end

  post '/comment/upvote' do
    comment = Comment.where(:id => params[:comment_id]).first
    vote = comment.votes_dataset.where(:owner_id => current_user.id).first
    #puts vote.inspect

    if vote == nil
      vote = Vote.new
      vote.value = 1
      vote.owner = current_user
      vote.comment = comment
      vote.save
    elsif vote.value == 1
      return {:score => comment.score.to_s}.to_json
    elsif vote.value == -1
      vote.value = 1
      vote.save
    end

    comment.votes.each do |vote|
      comment.score = 0
      comment.score += vote.value
    end
    # puts post.score.inspect
    comment.save

    return {:score => comment.score.to_s}.to_json


  end

  post '/comment/downvote' do
    comment = Comment.where(:id => params[:comment_id]).first
    vote = comment.votes_dataset.where(:owner_id => current_user.id).first
    #puts vote.inspect

    if vote == nil
      vote = Vote.new
      vote.value = -1
      vote.owner = current_user
      vote.comment = comment
      vote.save
    elsif vote.value == -1
      return {:score => comment.score.to_s}.to_json
    elsif vote.value == 1
      vote.value = -1
      vote.save
    end

    comment.votes.each do |vote|
      comment.score = 0
      comment.score += vote.value
    end
    # puts post.score.inspect
    comment.save
    return {:score => comment.score.to_s}.to_json

  end

end