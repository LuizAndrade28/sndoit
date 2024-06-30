class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', optional: true
  has_many :subtodos, dependent: :destroy
end
