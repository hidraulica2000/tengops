class Game < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :esrb
  belongs_to :genre
  belongs_to :platform
  belongs_to :publisher
  belongs_to :developer
end
