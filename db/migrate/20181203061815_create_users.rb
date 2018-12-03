class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :password
      t.integer :group

      t.timestamps
    end
  end
end
