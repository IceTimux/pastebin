# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:pastes) do
      primary_key :id
      String :title, null: false
      String :body, text: true, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end

  down do
    drop_table(:pastes)
  end
end
