class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :title
      t.string :place
      t.string :content
      t.timestamp :start_time

      t.timestamps
    end
  end
end
