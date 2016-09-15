require 'net/smtp'

class ContactController < ApplicationController
    layout "merepresentalogged"
    
    include LoggedHelper;

    before_filter :load_logged

    def create
    	contato_login = ENV['MEREP_CONTATO_LOGIN']
    	contato_senha = ENV['MEREP_CONTATO_PASS']

    	message = <<MESSAGE_END
From: Sistema de Contatos <testes@tamanhofamilia.com.br>
To: <pirola@nossascidades.org>
Subject: CONTATO

* Nome: #{params[:nome]}
* Email: #{params[:email]}
* Cidade: #{params[:city_id]} - #{params[:city]}
* Mensagem:
#{params[:mensagem]}
MESSAGE_END
    	Net::SMTP.start('mail.tamanhofamilia.com.br', 587, 'localhost', contato_login, contato_senha) do |smtp| 
    		smtp.send_message(message, 'testes@tamanhofamilia.com.br', 'pirola@nossascidades.org', 'testes@tamanhofamilia.com.br')
		end
    end
    
    def show
    end
end