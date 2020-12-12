class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  validates :comment, presence: true
  validates :user, presence: true
  validates :prototype, presence: true
end
