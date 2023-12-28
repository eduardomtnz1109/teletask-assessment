class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :doctor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
