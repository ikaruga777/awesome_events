class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    @events = Event.where('start_at > ?', Time.current).order(:start_at)
  end
end
