Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      Integer :score
      Float :latitude
      Float :longitude


    end
  end

  down do
    drop_table(:users)
  end
end