FactoryGirl.define do
  sequence(:name) { |s| "User #{s}" }
  sequence(:email) { |s| "user#{s}@email.com" }
  sequence(:uid) { |s| "#{s * 116}" }

  factory(:user) do |user|
    user.name FactoryGirl.generate(:name)
    user.email FactoryGirl.generate(:email)
  end

  factory(:authorization) do |service|
    service.association :user
    service.uid FactoryGirl.generate(:uid)
    service.provider "meurio"
  end

  factory(:category) do |c|
    sequence(:name){|n| "Category #{n}"}
  end

  factory(:question) do |q|
    q.text "Text"
    q.role_type "truth"
    q.association :user
    q.association :category
  end

  factory(:vote) do |v|
    v.association :question
    v.association :user
  end
end
