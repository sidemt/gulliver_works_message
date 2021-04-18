# frozen_string_literal: true
# EnterpriseController
class EnterpriseController < ActionController::API
  include ExceptionHandler

  before_action :authenticate_employee!

  attr_reader :current_employee

  def render(*args)
    options = args.extract_options!
    if options[:json].is_a?(Enumerable)
      options[:adapter] = :json
    end
    args << options
    super(*args)
  end

  def authenticate_employee!
    @current_jwt = /Bearer (.*)/.match(request.headers[:Authorization]).to_a[1]
    @current_employee = Employee.authenticate!(@current_jwt)
  end

  def current_ability
    @current_ability ||= EnterpriseAbility.new(current_employee)
  end
end
