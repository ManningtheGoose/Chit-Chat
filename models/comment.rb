class Comment < Sequel::Model

  many_to_one :post
  many_to_one :creator, :key => :creator_id, :class => :User
  one_to_many :votes, :key => :comment_id, :class => :Vote

end