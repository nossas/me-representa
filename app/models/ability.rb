class Ability
  include CanCan::Ability

  def initialize(user, request)
    can :read, :all

    if request.format == "csv"
      cannot :read, Candidate
    end

    if user
      can :create, Question
      can :create, Vote

      can :finish, Candidate
      can :create, Candidate
      can :update, Candidate
      can :confirm, Candidate  
      can :confirm, Candidate  

      can :create, Answer
      can :update, Answer do |a|
        a.responder = user
      end
      can :update, User
      can :matchup, User
      can :matchup_data, User
    end


    if user and user.admin?
      can :manage, :all
      can :free, User
      can :destroy, Candidate
      can :management, Candidate
    else
      cannot :free, User
      cannot :destroy, Candidate
    end
  end
end
