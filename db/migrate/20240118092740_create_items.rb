class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :word
      t.string :description

      t.timestamps
    end
  end
end
