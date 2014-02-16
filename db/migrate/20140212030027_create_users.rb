class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :password_digest
    	t.string :username
		t.integer :first_login
      t.timestamps
    end
  end
end
