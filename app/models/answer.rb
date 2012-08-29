class Answer < ActiveRecord::Base
  attr_accessible :long_answer, :question_id, :responder_id, :responder_type, :short_answer
  belongs_to :responder, :polymorphic => true
  belongs_to :question
  validates :question_id, :responder_id, :short_answer, :presence => true
end
