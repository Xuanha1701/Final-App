class Post < ApplicationRecord

  has_many :likes, dependent: :destroy


  belongs_to :user
  has_one_attached :image

  has_many :post_hash_tags
  has_many :post_hash_tags_tags, through: :post_hash_tags
  has_many :comments
  validate :image_presence
  after_commit :create_hash_tags, on: :create

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end

  def create_hash_tags
    extract_name_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end

  def extract_name_hash_tags
    description.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

  scope :of_followed_users, -> (following_users) { where user_id: following_users }
end