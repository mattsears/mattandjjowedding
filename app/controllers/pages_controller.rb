class PagesController < ApplicationController
  def index
  end

  def rsvp
    if @rsvp = Rsvp.create(rsvp_params)
      render :json => 'ok'
    else
      render json: { error: "Unable to create comment" }
    end
  end

  private

  def rsvp_params
    params.permit(:name, :email)
  end
end
