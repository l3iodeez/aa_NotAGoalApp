class Goal < ActiveRecord::Base
  validates :user_id, :title, presence: true
  after_initialize :ensure_defaults

  belongs_to :user, inverse_of: :goals
  has_many :comments, as: :commentable

  private

    def ensure_defaults
      self.completed ||= false
      self.private ||= false
    end
end
