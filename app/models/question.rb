class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :votes
  validates_presence_of :text, :role_type, :category, :user
  validates_inclusion_of :role_type, :in => %Q{truth dare}, :message => "Only truth or dare."

  scope :by_type, ->(type){ where(['role_type = ?', type]) }
  scope :by_category_id, ->(id){ where(['category_id = ?', id]) }
  scope :recent_first, order('created_at DESC')
  scope :voted_first, order('(SELECT count(*) FROM votes v WHERE v.question_id = questions.id) DESC')
  scope :by_updated_at, ->(updated_at) { where(['questions.updated_at >= ?', updated_at]) }
  scope :chosen, where(:chosen => true)

  def truth?
    role_type == "truth"
  end

  def dare?
    role_type == "dare"
  end

  def as_json(options = {})
    {
      :id => self.id,
      :text => self.text,
      :user => self.user.id,
      :user_info => self.user,
      :votes => self.votes.size,
      :category => {
        :id => self.category.id,
        :name => self.category.name
      },
      :role_type => self.role_type
    }
  end

  def to_param
    I18n.t "url.#{role_type}", :user => user.name.parameterize, :id => id
  end
end
