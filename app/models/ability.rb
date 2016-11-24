class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :read, :update, :destroy, to: :rud

    # The ability rules further down in a file will override a previous one.
    # So start with generic things here, and override where necessary

    # The fail-safe.
    cannot :manage, :all


    # User
    can :manage, User, id: user.id

    # Workout
    can :create, Workout, user_id: user.id
    can :read, Workout, user_id: user.id

    # WorkoutType
    can :read, WorkoutType
  end
end
