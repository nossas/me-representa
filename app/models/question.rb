class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :votes
  validates_presence_of :text, :role_type, :category, :user
  validates_inclusion_of :role_type, :in => %Q{truth dare}, :message => "Only truth or dare."

  scope :by_type, ->(type){ where(['role_type = ?', type]) }
  scope :recent_first, order('created_at DESC')

  def truth?
    role_type == "truth"
  end

  def dare?
    role_type == "dare"
  end
end
