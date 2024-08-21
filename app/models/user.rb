class User < ApplicationRecord
  has_many :todos, dependent: :destroy

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end
