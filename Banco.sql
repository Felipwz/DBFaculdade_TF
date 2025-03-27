CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    tipo ENUM('Aluno', 'Professor', 'Funcionário') NOT NULL
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cargo VARCHAR(50) NOT NULL
);

CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    editora VARCHAR(100),
    ano_publicacao YEAR,
    categoria VARCHAR(50),
    qtd_exemplares INT NOT NULL
);

CREATE TABLE emprestimos (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_livro INT,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE NOT NULL,
    status ENUM('Em andamento', 'Finalizado', 'Atrasado') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_livro INT,
    data_reserva DATE NOT NULL,
    status ENUM('Ativa', 'Expirada', 'Cancelada') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

CREATE TABLE multas (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    valor DECIMAL(10,2) NOT NULL,
    descricao TEXT,
    status_pagamento ENUM('Pendente', 'Pago') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

DELIMITER //

CREATE PROCEDURE inserir_usuario(
    IN p_nome VARCHAR(100), 
    IN p_email VARCHAR(100), 
    IN p_telefone VARCHAR(20),
    IN p_tipo ENUM('Aluno', 'Professor', 'Funcionário')
)
BEGIN
    INSERT INTO usuarios (nome, email, telefone, tipo) 
    VALUES (p_nome, p_email, p_telefone, p_tipo);
END //

CREATE PROCEDURE inserir_livro(
    IN p_titulo VARCHAR(255),
    IN p_autor VARCHAR(100),
    IN p_editora VARCHAR(100),
    IN p_ano_publicacao YEAR,
    IN p_categoria VARCHAR(50),
    IN p_qtd_exemplares INT
)
BEGIN
    INSERT INTO livros (titulo, autor, editora, ano_publicacao, categoria, qtd_exemplares) 
    VALUES (p_titulo, p_autor, p_editora, p_ano_publicacao, p_categoria, p_qtd_exemplares);
END //

CREATE PROCEDURE selecionar_usuarios()
BEGIN
    SELECT * FROM usuarios;
END //

CREATE PROCEDURE selecionar_livros()
BEGIN
    SELECT * FROM livros;
END //

CREATE PROCEDURE atualizar_usuario(
    IN p_id_usuario INT, 
    IN p_nome VARCHAR(100), 
    IN p_email VARCHAR(100), 
    IN p_telefone VARCHAR(20),
    IN p_tipo ENUM('Aluno', 'Professor', 'Funcionário')
)
BEGIN
    UPDATE usuarios 
    SET nome = p_nome, email = p_email, telefone = p_telefone, tipo = p_tipo
    WHERE id_usuario = p_id_usuario;
END //

CREATE PROCEDURE deletar_usuario(IN p_id_usuario INT)
BEGIN
    DELETE FROM usuarios WHERE id_usuario = p_id_usuario;
END //

DELIMITER ;
