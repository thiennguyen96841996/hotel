class StaticPagesController < ApplicationController

  def home
    @motels = Motel.page(params[:page])
                   .per Settings.per_page
  end
end
