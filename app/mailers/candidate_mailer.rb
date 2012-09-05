# coding: utf-8
class CandidateMailer < ActionMailer::Base
  default from: "equipe@verdadeouconsequencia.org.br"
  MR = "equipe@verdadeouconsequencia.org.br"

  def welcome candidate
    @candidate = candidate
    mail(:to => @candidate.email, :subject => "Bem vindo!")
  end


  def finished candidate
    @candidate = candidate
    if @candidate.email
      mail(:to => [@candidate.email, MR], :subject => "Obrigado por responder o questionário do Verdade ou Consequencia")
    else
      mail(:to => "", :subject => "Obrigado por responder o questionário do Verdade ou Consequencia")
    end
  end

  def resend_unique_url(candidate)
    @candidate = candidate
    mail(to: candidate.email, subject: "Obrigado por participar do Verdade ou Consequência!")
  end

  def notify_meurio(candidate)
    @candidate = candidate
    mail(to: MR, subject: "[VOC] Um candidato acabou de requisitar sua URL única")
  end

  def resend_unique_url_and_notify(candidate)
    self.resend_unique_url(candidate)
    self.notify_meurio(candidate)
  end
end
