Sequel.migration do
  up do
    create_table(:posts) do
      primary_key :id
      String :text
      String :name
      Integer :score
      Integer :time_created
      Float :latitude
      Float :longitude
      Integer :num_comments

      foreign_key :creator_id, :users
    end
  end

  down do
    drop_table(:posts)
  end
end