class New < ActiveRecord::Base
  attr_accessible :title, :content, :published
  scope :published, where(:published => true)
  has_many :attachements
  has_many :commentts, :dependent => :destroy
  make_flaggable :like
end
