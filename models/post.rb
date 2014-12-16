class Post < Sequel::Model

  many_to_one :creator, :key => :creator_id, :class => :User
  one_to_many :comments

end