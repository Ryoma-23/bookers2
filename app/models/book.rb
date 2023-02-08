class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: {maximum: 200}

  has_one_attached :profile_image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
