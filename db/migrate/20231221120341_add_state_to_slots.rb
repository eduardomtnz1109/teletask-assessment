class AddStateToSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :slots, :state, :boolean, default: true
  end
end
