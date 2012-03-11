FactoryGirl.define do

  sequence(:name) { |s| "User #{s}" }
  sequence(:email) { |s| "user#{s}@email.com" }

  factory(:user) do |user|
    user.name FactoryGirl.generate(:name)
    user.email FactoryGirl.generate(:email)
  end

  factory(:category) do |c|
    c.name "Name"
  end



  factory(:question) do |q|
    q.text "Text"
    q.role_type "truth"
    q.association :user
    q.association :category
  end
end




