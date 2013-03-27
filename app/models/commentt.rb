class Commentt < ActiveRecord::Base
  attr_accessible :content, :new_id, :user_id
  validates_presence_of :content
  belongs_to :new
  belongs_to :user
end
