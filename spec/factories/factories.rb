Factory.sequence(:name) { |s| "User #{s}" }
Factory.sequence(:email) { |s| "user#{s}@email.com" }
Factory.define :user do |user|
  user.name Factory.next(:name)
  user.email Factory.next(:email)
end
