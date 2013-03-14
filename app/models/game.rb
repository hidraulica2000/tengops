class Game < ActiveRecord::Base
  # attr_accessible :title, :body
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
