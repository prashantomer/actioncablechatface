class UserProfile < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  mount_uploader :cover, PictureUploader
end
