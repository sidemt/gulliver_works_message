# frozen_string_literal: true
# ApplicationController
class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authenticate_account!

  attr_reader :current_account

  def render(*args)
    options = args.extract_options!
    if options[:json].is_a?(Enumerable)
      options[:adapter] = :json
    end
    args << options
    super(*args)
  end

  def authenticate_account!
    @current_jwt = /Bearer (.*)/.match(request.headers[:Authorization]).to_a[1]
    @current_account = Account.authenticate!(@current_jwt)
  end

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end
end
