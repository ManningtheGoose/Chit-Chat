Sequel.migration do
  up do
    create_table(:comments) do
      primary_key :id
      String :text
      String :name
      Integer :score

      foreign_key :creator_id, :users
    end
  end

  down do
    drop_table(:comments)
  end
end