class CryptoPriceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "crypto_price_#{params[:crypto_id]}"

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
