delimiter $$
create procedure media (
  in nota1 double,
  in nota2 double, 
  in nota3 double,
  out mensagem varchar(100)
)
begin
  if (((nota1 + nota2 + nota3)/3)>=6) then
    set mensagem = 'Aprovado';
  else
    set mensagem = 'Reprovado';
  end if;
end $$
delimiter ;

set @msg = '';

call media(4.3, 6.7, 9, @msg);

select @msg;
