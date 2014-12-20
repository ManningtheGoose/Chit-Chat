class Post < Sequel::Model

  many_to_one :creator, :key => :creator_id, :class => :User
  one_to_many :comments
  one_to_many :votes, :key => :post_id, :class => :Vote
  #many_to_many :voters, :left_key => :post_id, :right_key => :user_id, :class => :User, :join_table => :posts_users

end