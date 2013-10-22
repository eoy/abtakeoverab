class AddHasAcceptedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_accepted, :boolean, :default => false
  end
end
