class CreateCalories < ActiveRecord::Migration
  def change
    create_table :calories do |t|
      t.string :name
      t.integer :calorie

      t.timestamps
    end
  end
end
