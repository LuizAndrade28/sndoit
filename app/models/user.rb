class User < ApplicationRecord
  has_one :friends_list, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :friends, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
