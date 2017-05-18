class User < ApplicationRecord
  has_many :authentications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :messages

  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_one :user_profile, dependent: :destroy

  accepts_nested_attributes_for :user_profile, allow_destroy: true

  after_create :create_user_profile!

  def profile
    self.user_profile
  end
  def full_name
    self.profile.first_name+" "+self.profile.last_name    
  end

  def self.create_with_omniauth data
    new_user = User.new(email: data["info"]["email"], provider: data["provider"], uid: data["uid"], password: "12345678", password_confirmation: "12345678")
    new_user.save!
    profile = data["info"]
    new_user.user_profile.update(first_name: profile["first_name"], last_name: profile["last_name"], picture: profile["image"])
    return new_user
  end

  def self.update_omniauth data
    debugger
  end
end
