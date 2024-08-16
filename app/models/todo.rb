class Todo < ApplicationRecord
  include ActionView::Helpers::TextHelper

  belongs_to :user
  has_many :subtodos, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }

  def date_created
    created_at.strftime("%d/%m/%Y")
  end

  def date_updated
    updated_at.strftime("%d/%m/%Y")
  end

  def importance_icon
    if importance == "High"
      '<i class="fa-solid fa-circle" style="color: #ff0000 !important;"></i>'.html_safe
    elsif importance == "Medium"
      '<i class="fa-solid fa-circle" style="color: #ebeb1e !important;"></i>'.html_safe
    elsif importance == "Low"
      '<i class="fa-solid fa-circle" style="color: #50ce69 !important;"></i>'.html_safe
    end
  end

  def title_with_icon
    "#{truncate(title.capitalize, length: 55)} #{importance_icon}".html_safe
  end

  def title_short
    truncate(title.capitalize, length: 15)
  end

end
