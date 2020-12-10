class WelcomeController < ApplicationController
  skipbefore_action :authenticate

  def index
  end
end
