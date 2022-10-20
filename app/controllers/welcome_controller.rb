class WelcomeController < ApplicationController

  def index
    @clients = Client.all
  end

end
