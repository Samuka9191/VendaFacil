
let carrinho = [];

function adicionarCarrinho(nome, preco) {
    // Localiza o card do produto pelo nome
    const produtos = document.querySelectorAll(".produto");
    let imagem = "";

    produtos.forEach(produto => {
        const titulo = produto.querySelector("h3");

        if (titulo && titulo.textContent.includes(nome)) {
            imagem = produto.querySelector("img").src;
        }
    });

    const itemExistente = carrinho.find(item => item.nome === nome);

    if (itemExistente) {
        itemExistente.quantidade++;
    } else {
        carrinho.push({
            nome: nome,
            preco: preco,
            imagem: imagem,
            quantidade: 1
        });
    }

    atualizarCarrinho();
}

function atualizarCarrinho() {
    const lista = document.getElementById("listaCarrinho");
    const totalElemento = document.getElementById("total");

    lista.innerHTML = "";

    let total = 0;

    carrinho.forEach(item => {
        total += item.preco * item.quantidade;

        const li = document.createElement("li");

        li.innerHTML = `
            <img src="${item.imagem}" alt="${item.nome}">

            <div class="item-info">
                <strong>${item.nome}</strong>
                <span>R$ ${item.preco.toFixed(2).replace(".", ",")}</span>
                <span>Quantidade: ${item.quantidade}</span>
            </div>
        `;

        lista.appendChild(li);
    });

    totalElemento.textContent =
        "Total: R$ " + total.toFixed(2).replace(".", ",");
}

function limparCarrinho() {
    carrinho = [];
    atualizarCarrinho();
}

function finalizarCompra() {
    if (carrinho.length === 0) {
        alert("Seu carrinho está vazio!");
        return;
    }

    alert("Compra finalizada com sucesso!");
    carrinho = [];
    atualizarCarrinho();
}
