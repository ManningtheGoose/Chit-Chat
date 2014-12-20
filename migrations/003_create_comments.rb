Sequel.migration do
  up do
    create_table(:comments) do
      primary_key :id
      String :text
      String :name
      Integer :score
      Integer :time_created

      foreign_key :creator_id, :users
      foreign_key :post_id, :posts
    end
  end

  down do
    drop_table(:comments)
  end
end