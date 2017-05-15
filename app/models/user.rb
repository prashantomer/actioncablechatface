class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :messages
	has_many :conversations, foreign_key: :sender_id, dependent: :destroy
	has_one :user_profile, dependent: :destroy

	accepts_nested_attributes_for :user_profile

	after_create :create_user_profile!

	def profile
		self.user_profile
	end
	def full_name
		self.profile.first_name+" "+self.profile.last_name		
	end
end
