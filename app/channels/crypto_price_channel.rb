class CryptoPriceChannel < ApplicationCable::Channel
  def subscribed
    # Se suscribe a un canal de precios de criptomonedas
    stream_from "crypto_price_#{params[:crypto_id]}"
  end

  def unsubscribed
    # Limpiar cualquier recurso cuando el canal se desconecte
  end
end
