class AddUidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gh_uid, :integer
  end
end
