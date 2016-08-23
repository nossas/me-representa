class Party < ActiveRecord::Base
  has_and_belongs_to_many :unions

  attr_accessible :number, :symbol, :union #, :union_id
  validates :symbol, :uniqueness => true
  has_many :candidates
  has_many :answers, :through => :candidates
  scope :unrelated, where(:union => nil)
  
  def self.match_for_user user_id
    connection.select_all(
      Party.
      select("parties.symbol as name, parties.id, round(sum((CASE WHEN answers.short_answer = ua.short_answer THEN 100 WHEN ua.short_answer IS NULL THEN NULL ELSE 0 END)::numeric * ua.weight)::numeric / sum(ua.weight)) as score, 'Party' as type").
      joins(:answers).
      joins(:candidates).
      joins("INNER JOIN users us ON us.city_id = candidates.city_id and us.id = #{user_id}" ).
      joins("LEFT JOIN answers ua ON ua.question_id = answers.question_id AND ua.responder_type = 'User'").
      where("ua.responder_id = us.id", user_id).
      order("score DESC").
      group("parties.symbol, parties.id")
    )
  end
end
