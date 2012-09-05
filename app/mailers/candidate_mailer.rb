# coding: utf-8
class CandidateMailer < ActionMailer::Base
  default from: "equipe@verdadeouconsequencia.org.br"

  def finished candidate
    @candidate = candidate
    if @candidate.email
      mail(:to => [@candidate.email, "equipe@verdadeouconsequencia.org.br"], :subject => "Obrigado por responder o questionário do Verdade ou Consequencia")
    else
      mail(:to => "equipe@verdadeouconsequencia.org.br", :subject => "Obrigado por responder o questionário do Verdade ou Consequencia")
    end
  end

  def resend_unique_url(candidate)
    @candidate = candidate
    mail(to: candidate.email, subject: t('email.resend_unique_url.subject'))
  end
end
