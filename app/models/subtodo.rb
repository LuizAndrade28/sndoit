class Subtodo < ApplicationRecord
  belongs_to :todo
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }

  default_scope -> { order(created_at: :desc) }
end
