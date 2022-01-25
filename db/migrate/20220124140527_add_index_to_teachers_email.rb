class AddIndexToTeachersEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :teachers, :email, unique: true
  end
end
