
let carrinho = JSON.parse(localStorage.getItem("carrinho")) || [];

// ADICIONAR AO CARRINHO
function adicionarCarrinho(nome, preco) {
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

// ATUALIZAR CARRINHO
function atualizarCarrinho() {
    const lista = document.getElementById("listaCarrinho");
    const totalElemento = document.getElementById("total");

    if (!lista || !totalElemento) return;

    lista.innerHTML = "";

    let total = 0;

    carrinho.forEach(item => {
        total += item.preco * item.quantidade;

        lista.innerHTML += `
            <li>
                <img src="${item.imagem}" alt="${item.nome}">

                <div class="item-info">
                    <strong>${item.nome}</strong>
                    <span>R$ ${item.preco.toFixed(2).replace(".", ",")}</span>
                    <span>Quantidade: ${item.quantidade}</span>
                </div>
            </li>
        `;
    });

    totalElemento.textContent =
        "Total: R$ " + total.toFixed(2).replace(".", ",");

    localStorage.setItem("carrinho", JSON.stringify(carrinho));
}

// LIMPAR CARRINHO
function limparCarrinho() {
    carrinho = [];
    localStorage.removeItem("carrinho");
    atualizarCarrinho();
}

// FINALIZAR COMPRA
function finalizarCompra() {
    if (carrinho.length === 0) {
        alert("Seu carrinho está vazio!");
        return;
    }

    localStorage.setItem("carrinho", JSON.stringify(carrinho));

    window.location.href = "../FinalizarCompraUsuario/finalizar.html";
}

// PESQUISAR PRODUTOS
function pesquisarProdutos() {
    const pesquisa = document.getElementById("pesquisa").value
        .toLowerCase()
        .trim();

    const produtos = document.querySelectorAll(".produto");

    produtos.forEach(produto => {
        const nome = produto.querySelector("h3").textContent.toLowerCase();

        if (nome.includes(pesquisa)) {
            produto.style.display = "block";
        } else {
            produto.style.display = "none";
        }
    });
}

// CARREGAR CARRINHO AO ABRIR A PÁGINA
document.addEventListener("DOMContentLoaded", function() {
    atualizarCarrinho();
});
