class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos, as: :photoable, class_name: 'User'
  has_many :albums
  # has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_one_attached :avatar
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following
  mount_uploader :avatars, AvatarUploader
  has_many :albums_photos, -> {order "created_at desc"},through: :albums, source: :photos
  # attr_accessor :email, :password, :remember_me, :avatar, :avatar_cache, :remove_avatar

  def name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def like
    pust ""
  end

  def unlike
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def follow(user)
    following_relationships.create(following_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

end
