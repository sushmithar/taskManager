class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
end
