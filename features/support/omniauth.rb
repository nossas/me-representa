# coding: utf-8

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:meurio] = OmniAuth::AuthHash.new(:provider => "meurio", :uid => "112", :info => {:email => "nicolas@engage.is", :first_name => "Nícolas", :last_name => "Iensen", :picture => "http://www.gravatar.com/avatar/e1ff427530e3fe61b67729327f83c5d1.jpg?s=260&d=http://meurio.org.br/assets/avatar_blank.png", :id => "122"})
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
