# coding: utf-8
class CandidateMailer < ActionMailer::Base
  default from: "Alessandra Orofino - Nossas Cidades <alessandra@nossascidades.org>"
  MR = "pirola@nossascidades.org"

  def welcome candidate
    @candidate = candidate
    mail(:to => @candidate.email, :subject => "O novo jeito de conseguir mais votos.")
  end


  def finished candidate
    @candidate = candidate
    if @candidate.email
      mail(:to => [@candidate.email, MR], :subject => "Obrigado por responder o questionário do Verdade ou Consequencia")
    else
      mail(:to => MR, :subject => "Obrigado por responder o questionário do Verdade ou Consequencia")
    end
  end

  def resend_unique_url(candidate)
    @candidate = candidate
    mail(to: [candidate.email, MR], subject: "Obrigado por participar do Verdade ou Consequência!")
  end

  def notify_meurio(candidate)
    @candidate = candidate
    mail(to: MR, subject: "[VOC] Um candidato acabou de requisitar sua URL única")
  end

  def welcome_again candidate
    @candidate = candidate
    mail(:to => @candidate.email, :subject => "12 horas para salvar sua campanha")
  end

  def share candidate
    @candidate = candidate
    mail(to: @candidate.email, subject: "Compartilhe o seu perfil no Verdade ou Consequência!")
  end
end
