class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities, options: 'ENGINE=MyISAM' do |t|
      t.string :name
      t.column :location, :point, null: false

      t.timestamps

      t.index :location, spatial: true
    end
  end
end
