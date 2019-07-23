class Album < ApplicationRecord
  belongs_to :user,optional: true
  has_many :photos, as: :photoable

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |attributes| attributes['image'].blank? }

  paginates_per 6

end
