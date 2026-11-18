
CREATE DATABASE IF NOT EXISTS vendaFacil;
USE vendaFacil;



CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATE,
    status VARCHAR(30)
);


CREATE TABLE Recuperacao_Senha (
    id_recuperacao INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    codigo VARCHAR(100),
    expiracao DATETIME,
    utilizado BOOLEAN,
    FOREIGN KEY (id_usuario)
        REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT
);


CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10,2),
    estoque INT,
    ativo BOOLEAN,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria)
        REFERENCES Categorias(id_categoria)
);



CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    status VARCHAR(30),
    FOREIGN KEY (id_usuario)
        REFERENCES Usuarios(id_usuario)
);



CREATE TABLE Item_Pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido)
        REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto)
        REFERENCES Produtos(id_produto)
);



CREATE TABLE Pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    metodo_pagamento VARCHAR(50),
    valor DECIMAL(10,2),
    data_pagamento DATE,
    status VARCHAR(30),
    FOREIGN KEY (id_pedido)
        REFERENCES Pedidos(id_pedido)
);



CREATE TABLE Entregas (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    tipo_entrega VARCHAR(50),
    endereco VARCHAR(255),
    data_envio DATE,
    status VARCHAR(30),
    codigo_rastreio VARCHAR(100),
    FOREIGN KEY (id_pedido)
        REFERENCES Pedidos(id_pedido)
);



INSERT INTO Usuarios
(nome, email, senha, cpf, telefone, data_cadastro, status)
VALUES
('Joao Silva', 'joao@gmail.com', '123456',
 '111.111.111-11', '(11) 99999-1111',
 '2026-11-10', 'Ativo'),

('Maria Santos', 'maria@gmail.com', '123456',
 '222.222.222-22', '(11) 99999-2222',
 '2026-11-11', 'Ativo'),

('Pedro Oliveira', 'pedro@gmail.com', '123456',
 '333.333.333-33', '(11) 99999-3333',
 '2026-11-12', 'Ativo');



INSERT INTO Recuperacao_Senha
(id_usuario, codigo, expiracao, utilizado)
VALUES
(1, 'ABC123', '2026-11-20 12:00:00', FALSE),
(2, 'DEF456', '2026-11-20 13:00:00', TRUE),
(3, 'GHI789', '2026-11-20 14:00:00', FALSE);


INSERT INTO Categorias
(nome, descricao)
VALUES
('Eletronicos', 'Produtos eletronicos'),
('Roupas', 'Roupas masculinas e femininas'),
('Acessorios', 'Acessorios diversos');



INSERT INTO Produtos
(nome, descricao, preco, estoque, ativo, id_categoria)
VALUES
('Notebook', 'Notebook Dell', 3500.00, 10, TRUE, 1),
('Celular', 'Samsung Galaxy', 2200.00, 15, TRUE, 1),
('Camiseta', 'Camiseta de algodao', 59.90, 30, TRUE, 2),
('Relogio', 'Relogio digital', 150.00, 20, TRUE, 3);



INSERT INTO Pedidos
(id_usuario, data_pedido, valor_total, status)
VALUES
(1, '2026-11-10', 3500.00, 'Pago'),
(2, '2026-11-11', 2259.90, 'Pendente'),
(3, '2026-11-12', 150.00, 'Enviado');



INSERT INTO Item_Pedido
(id_pedido, id_produto, quantidade, preco_unitario)
VALUES
(1, 1, 1, 3500.00),
(2, 2, 1, 2200.00),
(2, 3, 1, 59.90),
(3, 4, 1, 150.00);



INSERT INTO Pagamentos
(id_pedido, metodo_pagamento, valor, data_pagamento, status)
VALUES
(1, 'PIX', 3500.00, '2026-11-10', 'Aprovado'),
(2, 'Cartao de credito', 2259.90, NULL, 'Pendente'),
(3, 'Boleto', 150.00, '2026-11-12', 'Aprovado');


INSERT INTO Entregas
(id_pedido, tipo_entrega, endereco, data_envio, status, codigo_rastreio)
VALUES
(1, 'Normal', 'Rua A, 100', '2026-11-11',
 'Em transito', 'BR123456'),

(2, 'Expressa', 'Rua B, 200', NULL,
 'Aguardando pagamento', NULL),

(3, 'Normal', 'Rua C, 300', '2026-11-13',
 'Enviado', 'BR789012');


SELECT * FROM Usuarios;



SELECT
    id_usuario,
    nome,
    email,
    cpf,
    telefone,
    data_cadastro,
    status
FROM Usuarios;



SELECT * FROM Recuperacao_Senha;



SELECT * FROM Categorias;


SELECT * FROM Produtos;



SELECT * FROM Pedidos;



SELECT * FROM Item_Pedido;



SELECT * FROM Pagamentos;



SELECT * FROM Entregas;


SELECT
    Usuarios.id_usuario,
    Usuarios.nome,
    Usuarios.cpf,
    Pedidos.id_pedido,
    Pedidos.data_pedido,
    Pedidos.valor_total,
    Pedidos.status
FROM Usuarios
INNER JOIN Pedidos
ON Usuarios.id_usuario = Pedidos.id_usuario;

SELECT
    Produtos.id_produto,
    Produtos.nome AS produto,
    Produtos.preco,
    Categorias.nome AS categoria
FROM Produtos
INNER JOIN Categorias
ON Produtos.id_categoria = Categorias.id_categoria;


SELECT
    Item_Pedido.id_item,
    Item_Pedido.id_pedido,
    Produtos.nome AS produto,
    Item_Pedido.quantidade,
    Item_Pedido.preco_unitario
FROM Item_Pedido
INNER JOIN Produtos
ON Item_Pedido.id_produto = Produtos.id_produto;


SELECT
    Usuarios.nome,
    Usuarios.email,
    Recuperacao_Senha.codigo,
    Recuperacao_Senha.expiracao,
    Recuperacao_Senha.utilizado
FROM Usuarios
INNER JOIN Recuperacao_Senha
ON Usuarios.id_usuario = Recuperacao_Senha.id_usuario;


SELECT
    Pedidos.id_pedido,
    Pedidos.valor_total,
    Pagamentos.id_pagamento,
    Pagamentos.metodo_pagamento,
    Pagamentos.valor,
    Pagamentos.data_pagamento,
    Pagamentos.status
FROM Pedidos
INNER JOIN Pagamentos
ON Pedidos.id_pedido = Pagamentos.id_pedido;


SELECT
    Pedidos.id_pedido,
    Entregas.id_entrega,
    Entregas.tipo_entrega,
    Entregas.endereco,
    Entregas.data_envio,
    Entregas.status,
    Entregas.codigo_rastreio
FROM Pedidos
INNER JOIN Entregas
ON Pedidos.id_pedido = Entregas.id_pedido;



SELECT nome, preco
FROM Produtos
WHERE preco > 100;



SELECT *
FROM Pedidos
WHERE valor_total > 1000;


SELECT nome, estoque
FROM Produtos
WHERE estoque > 0 AND ativo = TRUE;



SELECT
    Usuarios.nome AS usuario,
    Usuarios.cpf,
    Pedidos.id_pedido,
    Pedidos.data_pedido,
    Produtos.nome AS produto,
    Item_Pedido.quantidade,
    Item_Pedido.preco_unitario,
    (Item_Pedido.quantidade * Item_Pedido.preco_unitario)
        AS total_item,
    Pedidos.valor_total,
    Pedidos.status
FROM Usuarios
INNER JOIN Pedidos
    ON Usuarios.id_usuario = Pedidos.id_usuario
INNER JOIN Item_Pedido
    ON Pedidos.id_pedido = Item_Pedido.id_pedido
INNER JOIN Produtos
    ON Item_Pedido.id_produto = Produtos.id_produto;


SHOW TABLES;
