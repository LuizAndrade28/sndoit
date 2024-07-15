class Todo < ApplicationRecord
  belongs_to :user
  has_many :subtodos, dependent: :destroy

  validates :title, presence: true
end
