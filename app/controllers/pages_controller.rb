class PagesController < ApplicationController
  def index
  end

  def rsvp

  end

  private

  def rsvp_params
    params.permit(:name)
  end
end
