class Event < ApplicationRecord
  searchkick language: 'japanese'

  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_should_be_before_end_at

  has_many :tickets, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  def created_by?(user)
    return false unless user

    owner_id == user.id
  end

  def search_data
    {
      name: name,
      place: place,
      content: content,
      owner_name: owner&.name,
      start_at: start_at
    }
  end

  private

  def start_at_should_be_before_end_at
    return unless start_at && end_at

    errors.add(:start_at, 'は終了時刻よりも前に設定してください') if start_at >= end_at
  end
end
