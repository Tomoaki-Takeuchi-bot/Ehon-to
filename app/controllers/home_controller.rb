class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # --[TODO -code books]
  end
end
