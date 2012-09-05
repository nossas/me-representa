class Candidate < ActiveRecord::Base
  attr_accessible :born_at, :male, :name, :nickname, :number, :party_id, :party, :email, :mobile_phone, :bio, :finished_at, :group_id, :short_url
  validates :number, :token, :uniqueness => true
  validates :name, :number, :party_id, :presence => true
  belongs_to :party
  has_many :answers, :as => :responder
  before_create { self.token = Digest::SHA1.hexdigest("#{Time.now.to_s}#{self.number}") }
  after_create { self.update_attributes(:short_url => Googl.shorten(Rails.application.routes.url_helpers.new_candidate_answer_url(self, :token => self.token)).short_url) if !self.mobile_phone.blank? }

  def self.assign_next_group candidate
    if candidate && candidate.group_id.nil?
      if Candidate.where(:group_id => 1).count <= Candidate.where(:group_id => 2).count
        candidate.update_attribute :group_id, 1
      else
        candidate.update_attribute :group_id, 2
      end
    end
  end
end
