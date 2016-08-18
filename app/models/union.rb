class Union < ActiveRecord::Base
  attr_accessible :name
  validates :name, :uniqueness => true
  has_many :parties
  has_many :candidates, :through => :parties
  has_many :answers, :through => :candidates
  belongs_to :city

  def self.match_for_user user_id
    connection.select_all(
      Union.
      select("unions.name, unions.id, round(sum((CASE WHEN answers.short_answer = ua.short_answer THEN 100 WHEN ua.short_answer IS NULL THEN NULL ELSE 0 END)::numeric * ua.weight)::numeric / sum(ua.weight)) as score, 'Union' as type").
      joins(:answers).
      joins(:candidates).
      joins("LEFT JOIN answers ua ON ua.question_id = answers.question_id AND ua.responder_type = 'User'").
      where("ua.responder_id = ?", user_id).
      order("score DESC").
      group("unions.name, unions.id")
    )
  end

end
