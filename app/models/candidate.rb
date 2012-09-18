class Candidate < ActiveRecord::Base
  attr_accessible :born_at, :male, :name, :nickname, :number, :party_id, :party, :email, :mobile_phone, :bio, :finished_at, :group_id, :short_url, :politician, :occupation, :scholarity
  validates :number, :token, :uniqueness => true
  validates :name, :number, :party_id, :presence => true
  belongs_to :party
  has_many :answers, :as => :responder
  before_create { self.token = Digest::SHA1.hexdigest("#{Time.now.to_s}#{self.number}") }

  def self.assign_next_group candidate
    if candidate && candidate.group_id.nil?
      if Candidate.where(:group_id => 1).count <= Candidate.where(:group_id => 2).count
        candidate.update_attribute :group_id, 1
      else
        candidate.update_attribute :group_id, 2
      end
    end
  end

  def self.match_for_user user_id, options = {:party_id => nil, :union_id => nil}
    candidates = 
      Candidate.
      select("candidates.id, candidates.name, round(avg((CASE WHEN answers.short_answer = ua.short_answer THEN 100 WHEN ua.short_answer IS NULL THEN NULL ELSE 0 END)::numeric)) as score").
      joins(:answers).
      joins(:party).
      joins("LEFT JOIN answers ua ON ua.question_id = answers.question_id AND ua.responder_type = 'User'").
      where("ua.responder_id = ?", user_id)
    if options[:party_id] then candidates = candidates.where(:party_id => options[:party_id]) end
    if options[:union_id] then candidates = candidates.where("parties.union_id = ?", options[:union_id]) end
    connection.select_all(candidates.order("score DESC").group("candidates.name, candidates.id"))
  end

end
