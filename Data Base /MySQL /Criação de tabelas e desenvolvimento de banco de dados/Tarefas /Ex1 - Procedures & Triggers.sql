
/*
-- Tabelas de referência
CREATE TABLE tbl_ativos_ti (
    id_ativo INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL, 
    numero_patrimonio VARCHAR(50) NOT NULL UNIQUE,
    id_setor_alocado INT NOT NULL,
    id_funcionario_responsavel INT,
    id_status_ti INT NOT NULL,
    CONSTRAINT fk_ti_produto FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto),
    CONSTRAINT fk_ti_setor FOREIGN KEY (id_setor_alocado) REFERENCES tbl_setores(id_setor),
    CONSTRAINT fk_ti_func FOREIGN KEY (id_funcionario_responsavel) REFERENCES tbl_funcionarios(id_funcionario),
    CONSTRAINT fk_ti_status FOREIGN KEY (id_status_ti) REFERENCES aux_status_ativos_ti(id_status_ti)
);


CREATE TABLE aux_status_ativos_ti (
    id_status_ti INT AUTO_INCREMENT PRIMARY KEY,
    nome_status VARCHAR(20) NOT NULL UNIQUE
);


CREATE TABLE tbl_historico_acessos_log (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    data_hora_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    acao_realizada VARCHAR(100) NOT NULL,
    tabela_afetada VARCHAR(50),
    CONSTRAINT fk_log_func FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionarios(id_funcionario)
);


CREATE TABLE aux_niveis_acesso (
    id_nivel_acesso INT AUTO_INCREMENT PRIMARY KEY,
    nome_nivel VARCHAR(20) NOT NULL UNIQUE
);
*/

use db_empresa_integrada



delimiter $$
create procedure proc_dius_P(
	in p_operacao char (1), -- (I) insert; (D) delete; (U) update; (S) select]
    in id int,
	in produto int,
    in patrimonio varchar(50),
    in setor int,
    in funcionario int,
    in id_status int,
    out mensagem varchar(50)
)
begin 
	-- OPERAÇÃO I
	if p_operacao = 'I' then
		insert into tbl_ativos_ti(
			id_produto,
			numero_patrimonio,
            id_setor_alocado,
            id_funcionario_responsavel,
            id_status_ti
        ) values (
			produto,
            patrimonio,
            setor,
            funcionario,
            id_status
        );
        
        set mensagem = 'Ação registrada, valores inseridos com sucesso';
	end if;
    
    -- OPERAÇÃO D
    if p_operacao = 'D' then
		delete from  tbl_ativos_ti where id = id_ativo;
        set mensagem = 'Linha deletada';
	end if;
    
    -- OPERAÇÃO U
    if p_operacao = 'U' then
		update  tbl_ativos_ti
        set	id_produto = produto,
			numero_patrimonio = patrimonio,
            id_setor_alocado = setor,
            id_funcionario_responsavel = funcionario,
            id_status_ti  = id_status
		where id = id_ativo;
        set mensagem = 'Ativo alterado com sucesso';
	end if;
    
    -- OPERAÇÃO S 
    if p_operacao = 'S' then 
		select * from tbl_ativos_ti where id = id_ativo;
        set mensagem = 'Dados exibidos com sucesso';
	end if;
end $$
delimiter ;

-- p_operacao (1), -- (I) insert; (D) delete; (U) update; (S) select;  id int; produto int; patrimonio varchar; setor int; funcionario int; id_status int; mensagem

call proc_dius_P("I", null, 5, "12", 7, 1, 2, @mensagem);
select @mensagem;

call proc_dius_P("S", 1, null, null, null, null, null, @mensagem);
select @mensagem;

call proc_dius_P("U", 1, 5, "9999", 7, 1, 2, @mensagem);
select @mensagem;

call proc_dius_P("D", 1, null, null, null, null, null, @mensagem);
select @mensagem;

-- PROCEDURE FOR TRIGGER
delimiter $$
create procedure proc_log(
		in id int,
        in funcionario int,
        in data_hora timestamp,
        in acao varchar (100),
        in tabela varchar (50)
)
begin
	insert into tbl_historico_acessos_log (
		id_log,
        id_funcionario,
        data_hora_acesso,
        acao_realizada,
        tabela_afetada
        )values(
        id,
        funcionario,
        default,
        acao,
        tabela
        );
	
end $$
delimiter ;
-- TRIGGER

delimiter $$
create trigger trg_historico_acessos_log
after insert 
on tbl_ativos_ti
for each row 
begin
    call proc_log(null, 1, null, "Novo insert na tabela ativos ti", "tbl_ativos_ti") ;
end$$
delimiter ;
select * from tbl_historico_acessos_log;

drop trigger if exists trg_historico_acessos_log;
drop procedure if exists proc_log;
drop procedure if exists proc_dius_P
