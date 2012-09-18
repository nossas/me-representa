class Party < ActiveRecord::Base
  attr_accessible :number, :symbol, :union_id, :union
  validates :symbol, :uniqueness => true
  belongs_to :union
  has_many :candidates
  has_many :answers, :through => :candidates
  scope :unrelated, where(:union_id => nil)
  
  def self.match_for_user user_id
    connection.select_all(
      Party.
      select("parties.symbol as name, parties.id, round(avg((CASE WHEN answers.short_answer = ua.short_answer THEN 100 WHEN ua.short_answer IS NULL THEN NULL ELSE 0 END)::numeric)) as score, 'Party' as type").
      joins(:answers).
      joins(:candidates).
      joins("LEFT JOIN answers ua ON ua.question_id = answers.question_id AND ua.responder_type = 'User'").
      where("ua.responder_id = ?", user_id).
      order("score DESC").
      group("parties.symbol, parties.id")
    )
  end
end
