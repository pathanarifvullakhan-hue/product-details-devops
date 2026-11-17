const container = document.getElementById("products");
function render(list) {
  container.innerHTML = list.map(p =>
    `<div class="card"><h2>${p.name}</h2><div class="price">\u20B9${p.price.toLocaleString("en-IN")}</div><p>${p.details}</p></div>`
  ).join("") || "<p>No products found.</p>";
}
document.getElementById("search").addEventListener("input", e => {
  const q = e.target.value.toLowerCase();
  render(products.filter(p => p.name.toLowerCase().includes(q)));
});
render(products);
