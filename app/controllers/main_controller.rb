class MainController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :incoming

  def index
  	if params[:query]
  		@response = [params[:query], ConferenceRoom.reply_for(params[:query])]
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
end
