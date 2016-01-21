class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :submitter_id, null: false
      t.integer :url_id, null: false
      t.timestamp
    end

    add_index(:visits, :submitter_id, unique: false)
    add_index(:visits, :url_id, unique: false)
  end
end
