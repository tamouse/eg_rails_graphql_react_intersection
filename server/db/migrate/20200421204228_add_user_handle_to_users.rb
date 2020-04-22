class AddUserHandleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :handle, :string
  end
end
