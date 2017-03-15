class ConferenceRoomsController < ApplicationController

  def index
    render locals: { conference_rooms: ConferenceRoom::CONFERENCE_ROOMS_AREAS }
  end
end