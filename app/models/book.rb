class Book < ApplicationRecord

  # アクセス数カウント用
  is_impressionable counter_cache: true

  # 投稿数カウント
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } #前日
  scope :created_2days, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3days, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4days, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5days, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6days, -> { where(created_at: 6.day.ago.all_day) }

  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }


  scope :latest, -> {order(updated_at: :desc)}
  scope :star, -> {order(star: :desc)}
  scope :impressions, -> {order(impressions_count: :desc)}

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :user

  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :category, presence:true
  validates :star, presence:true

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
