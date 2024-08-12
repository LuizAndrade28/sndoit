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

  def importance_icon
    if importance == "High"
      '<i class="fa-solid fa-circle" style="color: #ff0000;"></i>'.html_safe
    elsif importance == "Medium"
      '<i class="fa-regular fa-circle" style="color: #cf8d30;"></i>'.html_safe
    elsif importance == "Low"
      '<i class="fa-regular fa-circle" style="color: #50ce69;"></i>'.html_safe
    end
  end

  # default_scope -> { order(created_at: :desc) }
end
