Create DataBase CRUD_Clientes
go
use CRUD_CLientes
go
Create table Cliente(
cpf char(11) not null,
nome varchar(100) not null,
email varchar(200) not null,
limite_credito decimal(7,2) not null,
dt_Nascimento date not null
Primary Key(cpf)
)
go

-- Inserir Cliente
Create Procedure sp_insertCliente(@cpf char(11), @nome varchar(100), @email varchar(200), @limite_credito decimal(7,2), @dt_Nascimento date, @out varchar(100) output)
As
	Exec sp_algoritmoCPF @cpf, @out output

	If(@out Like 'CPF Valido') Begin
		Insert into Cliente Values(@cpf, @nome, @email, @limite_credito, @dt_Nascimento)
		set @out = 'Cliente Cadastrado com Sucesso'
	End

-- Update Cliente
Create Procedure sp_updateCliente(@cpf char(11), @nome varchar(100), @email varchar(200), @limite_credito decimal(7,2), @dt_Nascimento date, @out varchar(100) output)
as
	
	set @cpf =  (Select cpf from Cliente where cpf=@cpf)
	If (@cpf is not null) Begin
		Update Cliente set nome = @nome, email = @email, limite_credito = @limite_credito, dt_Nascimento = @dt_Nascimento where cpf = @cpf
		set @out = 'Cliente Atualizado com Sucesso'
	End
	Else Begin
		RaisError('CPF Inexistente', 16, 1)
	End


--Delete Cliente
Create Procedure sp_deleteCliente(@cpf char(11), @out varchar(100) output)
As
	set @cpf =  (Select cpf from Cliente where cpf=@cpf)
	If (@cpf is not null) Begin
		Delete from Cliente where cpf = @cpf 
	End
	Else Begin
		RaisError('CPF Inexistente', 16, 1)
	End

-- Testes
Declare @out varchar(100)
Exec sp_insertCliente '71024364160','Kauan','Teste@gmail.com',100,'01/01/2004', @out output
print @out

Declare @out varchar(100)
Exec sp_updateCliente '71024364160','Kauan Paulino Farias','Teste@gmail.com',100,'01/01/2004', @out output
print @out

Declare @out varchar(100)
Exec sp_deleteCliente '71024364160', @out output
print @out

Select * from Cliente
Delete from Cliente
drop Procedure sp_updateCliente




-- Algoritmo Do Cpf
Create Procedure sp_algoritmoCPF(@cpf char(11), @saida varchar(100) output )
As
--Declarações de Variaveis
Declare @cont int,
		@valor int,
		@status int,
		@x int

-- Atribuindo Valores
set @status = 0
set @cont = 0 
set @x = 2

-- Verifica se contem 11 digitos
	If(LEN(@cpf) = 11) Begin
		-- Verificando se os 11 digitos são iguais
		While(@cont<10) begin
			If(SUBSTRING(@cpf,1,1) = SUBSTRING(@cpf,@x,1) ) begin	
				set @status = @status + 1
			end
		set @cont = @cont + 1
		set @x = @x+1
		End
		If(@status < 10) Begin
			-- Realizando calculo do primeiro digito
			Declare @valorMutiplicado int
			set @valor = 10
			set @cont = 0
			set @x = 1
			set @valorMutiplicado = 0

			While(@cont<9) Begin
				set @valorMutiplicado = CAST(SUBSTRING(@cpf,@x,1) as int) * @valor + @valorMutiplicado
				set @x = @x+1
				set @cont = @cont + 1
				set @valor = @valor - 1
			End

			Declare @valorDivido int,
					@primeiroDigito int
			set @valorDivido = @valorMutiplicado % 11

			If (@valorDivido < 2) Begin
				set @primeiroDigito = 0
			End
			Else Begin
				set @primeiroDigito = 11 - @valorDivido
			End

			-- Verifica se o digito calculado é igual o digito inserido
			If( CAST(SUBSTRING(@cpf,10,1)as int) = @primeiroDigito) Begin
				-- Calculando o segundo digito
				set @valor = 11
				set @cont = 0
				set @x = 1
				set @valorMutiplicado = 0

				While(@cont<10) Begin
				set @valorMutiplicado = CAST(SUBSTRING(@cpf,@x,1) as int) * @valor + @valorMutiplicado
				set @x = @x+1
				set @cont = @cont + 1
				set @valor = @valor - 1
				End
				
				Declare @segundoDigito int
				set @valorDivido = @valorMutiplicado % 11

				If (@valorDivido < 2) Begin
				set @segundoDigito = 0
				End
				Else Begin
				set @segundoDigito = 11 - @valorDivido
				End

				-- Verifica se o ultimo digito calculado correponde a o ultimo digito inserido
				If( CAST(SUBSTRING(@cpf,11,1)as int) = @segundoDigito) Begin
					set @saida = 'CPF Valido'
				End
				Else Begin
					RaisError('CPF Invalido', 16,1)
				End

			End
			Else Begin
				RaisError('CPF Invalido', 16,1)
			End
		End
		Else Begin
		RaisError('Todos os digitos são iguais ', 16,1)
		End
	End
	Else Begin
	RaisError('Numero de digitos invalido', 16,1)
	End





-- Teste
Declare @out varchar(100),
		@cpf char(11)
set @cpf = '22222222221'
Exec sp_algoritmoCPF @cpf,@out output
print @out

	
drop Procedure sp_algoritmoCPF		


