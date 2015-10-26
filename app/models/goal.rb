class Goal < ActiveRecord::Base
  validates :user_id, :title, presence: true
  belongs_to :user, inverse_of: :goals
  after_initialize :ensure_defaults

  private

    def ensure_defaults
      self.completed ||= false
      self.private ||= false
    end
end
