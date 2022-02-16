class AddColumnsCanceledPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :canceled, :boolean
  end
end
