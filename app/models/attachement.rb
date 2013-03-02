class Attachement < ActiveRecord::Base
  attr_accessible :new_id, :url, :format
  scope :video, where(:format => "video")
  scope :cover, where(:format => "cover")
  scope :picture, where(:format => "picture")
  belongs_to :new

  def video_html(x, y, url, name)
    code = '<video id="video1" class="sublime" width='+ x +' height='+ y +'
    data-youtube-id='+ url +' data-autoresize="fit" data-uid='+ url +'
    data-name='+ name +' preload="none"> </video>'
  end
end
