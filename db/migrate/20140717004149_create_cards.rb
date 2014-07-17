class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :type
      t.integer :set
      t.integer :id_api
      t.integer :class
      t.text :description
      t.integer :quality
      t.integer :cost
      t.integer :health
      t.integer :attack

      t.timestamps
    end
  end
end
