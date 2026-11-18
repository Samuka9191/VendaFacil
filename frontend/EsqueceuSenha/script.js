
const formulario = document.getElementById("formRecuperacao");
const mensagem = document.getElementById("mensagem");

formulario.addEventListener("submit", async function(event) {

    event.preventDefault();

    const email = document.getElementById("email").value.trim();

    if (!email) {
        mensagem.textContent = "Digite seu e-mail.";
        mensagem.className = "erro";
        return;
    }

    try {

        const resposta = await fetch("/api/recuperacao/solicitar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ email: email })
        });

        const dados = await resposta.json();

        if (resposta.ok) {
            mensagem.textContent =
                dados.mensagem || "Se o e-mail estiver cadastrado, você receberá as instruções de recuperação.";

            mensagem.className = "sucesso";
        } else {
            mensagem.textContent =
                dados.mensagem || "Não foi possível solicitar a recuperação.";

            mensagem.className = "erro";
        }

    } catch (erro) {

        mensagem.textContent =
            "Não foi possível conectar ao servidor. Tente novamente.";

        mensagem.className = "erro";

        console.error(erro);
    }

});
