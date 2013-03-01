class Attachement < ActiveRecord::Base
  attr_accessible :new_id, :url, :format
  scope :preview, where(:format => "preview")
  scope :cover, where(:format => "cover")
  scope :picture, where(:format => "picture")
  scope :videop, where(:format => "video-preview")
  scope :videopost, where(:format => "videopost")
  attr_accessor :type
  belongs_to :new
end
