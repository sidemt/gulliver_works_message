# frozen_string_literal: true
# Ability
class Ability
  include CanCan::Ability

  def initialize(account)
    account ||= Account.new

    can :read, Account
    can :manage, Account, id: account.id
    can :read, OccupationMainCategory
    can :read, OccupationSubCategory
    can :read, Occupation
    can :read, IndustryCategory
    can :read, Industry
    can :read, Prefecture
    can :read, EmploymentStatus
    can [:read, :create], Room, account: { id: account.id }
  end
end
