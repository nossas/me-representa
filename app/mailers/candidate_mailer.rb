class CandidateMailer < ActionMailer::Base
  default from: "from@example.com"


  def resend_unique_url(candidate)
    @candidate = candidate
    mail(to: candidate.email, subject: t('email.resend_unique_url.subject'))
  end
end
