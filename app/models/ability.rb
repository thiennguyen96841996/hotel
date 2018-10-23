class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :edit, [Review, Comment, Replie]
      can :destroy, [Review, Comment, Replie]
      can :edit, [Review, Comment, Replie], user_id: user.id

    elsif user.mod?
      can :manage, [Equipment, Room, Motel]
      can :destroy, [Review, Comment, Replie]
      can :show, User, user_id: user.id
    else
      can :manage, [User, Review, Comment, Replie], user_id: user.id
      can [:show], [Motel, Review, Comment, Replie]
    end
  end
end
