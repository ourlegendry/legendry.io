class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @organizations = Organization.where user_id: current_user.id
  end
end
