class AddColumnUserIdToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :user_id, :integer
  end
end
