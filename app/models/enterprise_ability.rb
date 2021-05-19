# frozen_string_literal: true
# EnterpriseAbility
class EnterpriseAbility
  include CanCan::Ability

  def initialize(employee)
    employee ||= Employee.new

    can :read, Employee
    can :manage, Employee, id: employee.id
    can :read, Company
    can :manage, Company, id: employee.company_id
    can :read, OccupationMainCategory
    can :read, OccupationSubCategory
    can :read, Occupation
    can :read, IndustryCategory
    can :read, Industry
    can :read, Prefecture
    can :read, EmploymentStatus
    can [:read, :create], Room, company: { id: employee.company_id }
    can [:read, :create], Message, room: { company_id: employee.company_id }
  end
end
