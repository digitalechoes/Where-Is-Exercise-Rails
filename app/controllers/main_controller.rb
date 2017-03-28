class MainController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :incoming

  def index
    query = params[:query]

    p query.nil?
    p "??????"
    render "index" && return if query.nil?

    p "Dang it"
    render_index("No query has been entered") && return if query.blank?

    if query.downcase.eql?("list conference rooms")
      render_index(ConferenceRoom.list_rooms)
    else
      render_index(ConferenceRoom.reply_for(query))
    end
  end

  def incoming
    body = params["Body"]
    response = ConferenceRoom.reply_for(body)
    twilio_number = '4694164526'
    client = Twilio::REST::Client.new '(account_sid)', '(auth_token)'
    message = client.account.messages.create(
      from: twilio_number,
      to: params["From"],
      body: response
      )
    render nothing: true
  end

  private

  def render_index(response)
    render locals: {query: params[:query], result: response}
  end
end
