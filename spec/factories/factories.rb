Factory.sequence(:name) { |s| "User #{s}" }
Factory.sequence(:email) { |s| "user#{s}@email.com" }


Factory.define(:user) do |user|
  user.email Factory.next(:email)
end


Factory.define(:category) do |c|
  c.name "Name"
end

Factory.define(:question) do |q|
  role = ['truth', 'dare']
  q.text "Text"
  q.role_type role[rand(2)]
  q.association :user, :factory => :user
  q.association :category, :factory => :category
end
