class AddDialectIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :dialect, foreign_key: true
  end
end
