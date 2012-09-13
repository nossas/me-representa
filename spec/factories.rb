FactoryGirl.define do
  sequence(:name) { |s| "User #{s}" }
  sequence(:email) { |s| "user#{s}@email.com" }
  sequence(:uid) { |s| "#{s * 116}" }
  sequence(:number) { |s| s * 116 }

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

  factory(:candidate) do |c|
    c.name { generate(:name) }
    c.nickname "Tony"
    c.number { generate(:number) }
    c.bio "I'm good. You know it."
    c.association :party
    c.male true
    c.born_at Date.new(1986, 3, 6)
  end

  factory(:party) do |p|
    p.symbol { generate(:name) }
    p.number 22
    p.association :union
  end

  factory(:union) do |u|
    u.name { generate(:name) }
  end
  
  factory(:candidate_answer, :class => Answer) do |a|
    a.association :responder, :factory => :candidate
    a.association :question
    a.short_answer "Sim"
  end
  
  factory(:user_answer, :class => Answer) do |a|
    a.association :responder, :factory => :user
    a.association :question
    a.short_answer "Sim"
  end
end
