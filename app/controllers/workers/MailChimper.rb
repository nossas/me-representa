class MailChimper
  def self.perform(repo_id)
    Candidate.verify_merge_fields
    Candidate.subscribe_all
    User.subscribe_all
  end
end