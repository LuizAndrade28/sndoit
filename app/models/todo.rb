class Todo < ApplicationRecord
  belongs_to :user
  has_many :subtodos, dependent: :destroy

  validates :title, presence: true

  def date_created
    created_at.strftime("%d/%m/%Y")
  end

  def date_updated
    updated_at.strftime("%d/%m/%Y")
  end

  default_scope -> { order(created_at: :desc) }
end
