Sequel.migration do

  up do
    create_table :votes do
      primary_key :id
      Integer :value

      foreign_key :owner_id, :users
      foreign_key :post_id, :posts
      foreign_key :comment_id, :comments
    end

  end

  down do
    drop_table :votes

  end
end