class Vote < Sequel::Model
  many_to_one :post, :key => :post_id, :class => :Post
  many_to_one :owner, :key => :owner_id, :class => :User
  many_to_one :comment, :key => :comment_id, :class => :Comment
end