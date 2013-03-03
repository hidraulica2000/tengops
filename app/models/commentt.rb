class Commentt < ActiveRecord::Base
  attr_accessible :content, :new_id, :user_id
  belongs_to :new
  belongs_to :user
end
