class CreateRsvps < ActiveRecord::Migration[5.1]
  def change
    create_table :rsvps do |t|
      t.string :email
      t.string :name
      t.timestamps
    end
  end
end
