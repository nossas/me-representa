class Ability
  include CanCan::Ability

  def initialize(user, request)
    can :read, :all
    can :create, Question
    can :create, Vote
    can :finish, Candidate
    can :update, Candidate

    if request.format == "csv"
      cannot :read, Candidate
    end

    if user
      can :create, Answer
      can :update, Answer do |a|
        a.user == user
      end
      can :create, Like
      can :update, Like do |like|
        like.user == user
      end
    end


    if user and user.admin?
      can :manage, :all
    end
  end
end
