class CreatePostcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :postcodes do |t|
      t.string :name

      t.timestamps
    end
  end
end
