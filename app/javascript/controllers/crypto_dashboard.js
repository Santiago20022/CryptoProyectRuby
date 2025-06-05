// app/javascript/controllers/crypto_dashboard.js
document.addEventListener("DOMContentLoaded", function () {
  window.selectRandomCoin = function () {
    const rows = document.querySelectorAll("table tbody tr");
    if (rows.length === 0) return;

    rows.forEach(row => row.style.backgroundColor = "");
    const randomRow = rows[Math.floor(Math.random() * rows.length)];
    randomRow.style.backgroundColor = "yellow";

    const name = randomRow.querySelector(".coin-name").innerText;
    const price = parseFloat(randomRow.querySelector(".coin-price").innerText.replace("$", ""));

    console.log("Seleccionada:", name, price);

    // Opcional: guardar en el backend
    fetch("/random_selections", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ name: name, price: price })
    }).then(res => res.json()).then(data => {
      console.log("Guardado en DB:", data);
    });
  };
});
