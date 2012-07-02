class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :create, Question
    can :create, Vote

    if user and user.admin?
      can :manage, :all
    end
  end
end
