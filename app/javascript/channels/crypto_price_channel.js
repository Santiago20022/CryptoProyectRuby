import consumer from "./consumer"

consumer.subscriptions.create("CryptoPriceChannel", {
  connected() {
    console.log("Conectado al canal de precios de criptomonedas")
  },

  disconnected() {
    console.log("Desconectado del canal de precios de criptomonedas")
  },

  received(data) {
    const priceElement = document.querySelector(`#price-${data.crypto_id}`);
    if (priceElement) {
      priceElement.innerHTML = `$${data.price}`;
    }
  }
})
