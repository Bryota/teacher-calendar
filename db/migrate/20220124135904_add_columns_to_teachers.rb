class AddColumnsToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :email, :string
    add_column :teachers, :password_digest, :string
  end
end
