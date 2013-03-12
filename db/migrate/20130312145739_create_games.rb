class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game_title
      t.string :platform
      t.date   :release_date
      t.text   :overview
      t.string :esrb
      t.string :genres
      t.string :players
      t.string :coop
      t.string :youtube
      t.string :publisher
      t.string :developer
      t.string :boxart
      t.string :boxart_thumb
      t.string :boxart_normal
      t.timestamps
    end
  end
end
