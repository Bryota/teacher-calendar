class AddResetToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :reset_digest, :string
    add_column :teachers, :reset_sent_at, :string
  end
end
