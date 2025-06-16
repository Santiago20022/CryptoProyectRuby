class CryptoPriceChannel < ApplicationCable::Channel
  def subscribed
    # Nos suscribimos al canal de precios de la criptomoneda
    stream_from "crypto_price_#{params[:crypto_id]}"
  end

  def unsubscribed
    # Limpiar los recursos cuando el canal se desconecte
  end
end
