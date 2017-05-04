class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :picture
      t.string :cover

      t.timestamps
    end
  end
end
