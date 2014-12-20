class User < Sequel::Model

  one_to_many :comments, :key => :creator_id, :class => :Post
  one_to_many :posts, :key => :creator_id, :class => :Comment
  one_to_many :votes, :key => :owner_id, :class => :Vote

  #many_to_many :voted_posts, :left_key => :user_id, :right_key => :post_id, :class => :Post, :join_table => :posts_users

end