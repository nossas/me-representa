class Ability
  include CanCan::Ability

  def initialize(user, request)
    can :read, :all
    can :create, Question
    can :create, Vote
    can :finish, Candidate

    if request.format == "csv"
      cannot :read, Candidate
    end

    if user and user.admin?
      can :manage, :all
    end
  end
end
