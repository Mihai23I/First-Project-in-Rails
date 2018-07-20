class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
    before_save { self.email = email.downcase }
  end
end
