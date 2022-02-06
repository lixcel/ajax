class Book < ApplicationRecord
  scope :latest, -> {order(updated_at: :desc)}
  scope :star, -> {order(star: :desc)}

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :user

  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :category, presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end

  def sort_books(sort)
    if sort[:sort] == "updated_at_asc"
      order("updated_at ASC")
    elsif sort[:sort] == "updated_at_desc"
      order("updated_at DESC")
    end
  end

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "新着順" => "updated_at_asc",
      "古い順" => "updated_at_desc"
    }
  }

end
