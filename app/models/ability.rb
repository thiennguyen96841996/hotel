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
      cannot :edit, [Review, Comment, Replie]
      can :edit, [Review, Comment, Replie], user_id: user.id
      can :destroy, [Review, Comment, Replie]
      can :manage, [User, Review, Comment, Replie, Like], user_id: user.id
      can [:show], [Review, Comment, Replie, User]
    else
      can :manage, [User, Review, Comment, Replie, Like], user_id: user.id
      can [:show], [Motel, Review, Comment, Replie, User]
    end
  end
end
