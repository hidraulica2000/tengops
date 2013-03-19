class Game < ActiveRecord::Base
  attr_accessible :id, :game_title, :platform_id, :release_date, :overview, :esrb_id, :genre_id, :players, :coop, :youtube, :publisher_id, :developer_id, :boxart, :boxart_thumb, :boxart_normal
  belongs_to :esrb
  belongs_to :genre
  belongs_to :platform
  belongs_to :publisher
  belongs_to :developer

  def self.search(search)
    if search
      where(["UNACCENT(LOWER(game_title)) LIKE UNACCENT(?)", "%#{search.to_s.downcase}%"])
    end
  end
end