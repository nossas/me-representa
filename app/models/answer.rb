class Answer < ActiveRecord::Base
  attr_accessible :long_answer, :question_id, :responder_id, :responder_type, :short_answer
end
