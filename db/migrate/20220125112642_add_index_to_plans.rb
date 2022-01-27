class AddIndexToPlans < ActiveRecord::Migration[7.0]
  def change
    add_index :plans, [:start_time, :teacher_id], unique: true
  end
end
