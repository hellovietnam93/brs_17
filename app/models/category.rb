class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  private
  UNRANSACKABLE_ATTRIBUTES = ["id", "updated_at", "created_at", "slug"]

  def self.ransackable_attributes auth_object = nil
    column_names - UNRANSACKABLE_ATTRIBUTES + _ransackers.keys
  end
end
