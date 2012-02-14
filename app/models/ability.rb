class Ability
  include CanCan::Ability

  def initialize(user)
    anonymous_privileges

    if user.present?
      user_privileges user
      leader_privileges user if user.has_role? :leader
      manager_privileges user if user.has_role? :manager
      admin_privileges user if user.has_role? :admin
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  def anonymous_privileges
    can :read, News
    can :read, Event
    can :read, Place
    can :create, UserSession
  end

  def user_privileges user
    can :destroy, UserSession
    can :read, User, { id: user.id }
    can :read, Member, { id: user.member.id }
    can :reset_password, User, { id: user.id }
  end
  
  def leader_privileges user
    can [:read, :create], Member
    can :manage, Member, organisational_unit_id: user.member.organisational_unit.descendants.collect { |ou| ou.id } 
    
    can :manage, Event, organisational_unit_id: user.member.organisational_unit.descendants.collect { |ou| ou.id } 
    can :create, Event
    
    can :manage, Address
    can :manage, Contact
    can :manage, PhoneNumber
  end
  
  def manager_privileges user
    can :manage, MeetingProtocol
    can :manage, News
    can :manage, Event
    can :manage, Member
    can :manage, Address
    can :manage, Contact
    can :manage, PhoneNumber
    can :manage, PhotoCollection::AlbumUpload
  end

  def admin_privileges user
    can :manage, :all
  end
end
