module OmniAuth
  module Strategies
    class Meurio < OmniAuth::Strategies::OAuth2
      option :name, :meurio

      option :client_options, {
        :site => "http://merepresenta.org.br",
        :authorize_path => "/oauth/authorize"
      }

      uid { info['id'].to_s }

      info do
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meurio, ENV["MEURIO_ID"], ENV["MEURIO_SECRET"]
  provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :scope => "email,public_profile,user_birthday,user_location"
end

# email           ##SA##
# public_profile  ##SA##
# user_about_me   # RETIRADO #
# user_birthday => Ao enviar para análise, seja claro com relação ao motivo da age_range não ser suficiente para seu caso de uso.
# user_location   => Mostre um conteúdo relevante à cidade dessa pessoa.
# user_education_history # RETIRADO #
# + Mostre conteúdo relevante a ex-alunos.
# + Ajude as pessoas a se conectarem com outras pessoas com históricos educacionais em comum.
# - Calcule análises que não estão claramente visíveis no aplicativo.
# user_hometown   # RETIRADO #
# user_relationships          # RETIRADO #
# user_relationship_details   # RETIRADO #
# user_religion_politics      # RETIRADO #
# user_work_history"          # RETIRADO #
# user_interests              # DECREPTED #
# publish_actions             # RETIRADO #