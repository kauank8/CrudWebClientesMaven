<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/style1.css">
<title>Crud Cliente</title>
</head>
<body>
	<div align="center" class="container">
		<form action="cliente" method="post">
			<p class="title">
				<b>Clientes</b>
			</p>
			<table>
				<tr>
					<td colspan="3">
						<input class="id_input_data"  id="cpf" name="cpf" placeholder="CPF"
						 type="text" pattern="[0-9]*" title="Por favor, digite apenas números."  
						value='<c:out value="${cliente.cpf }"></c:out>'>
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Buscar">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="text"  id="nome" name="nome" placeholder="Nome"
						value='<c:out value="${cliente.nome }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="email"  id="email" name="email" placeholder="Email"
						value='<c:out value="${cliente.email }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="number" min=0 step=100 id="limite" name="limite" placeholder="Limite Credito"
						value='<c:out value="${cliente.limite_credito }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="date"  id="datanasc" name="datanasc" placeholder="Data Nascimento"
						value='<c:out value="${cliente.dt_nasc }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Cadastrar">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Alterar">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Excluir">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Listar">
					</td>	
				</tr>
			</table>
		</form>
	</div>
	
	<div align="center">
		<c:if test="${not empty erro }">
			<h2><b> <c:out value="${erro }" /> </b></h2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida }">
			<h3><b> <c:out value="${saida }" /> </b></h3>	
		</c:if>
	</div>
	<br />
	<br />
	<br />
	<div align="center" >
		<c:if test="${not empty clientes }">
			<table class="table_round">
				<thead>
					<tr>
						<th class="lista">Cpf</th>
						<th class="lista">Nome</th>
						<th class="lista">Email</th>
						<th class="lista">Limite Credito</th>
						<th class="lista_ultimoelemento">Data Nascimento</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${clientes }">
						<tr>
							<td class="lista"><c:out value="${c.cpf } " /></td>
							<td class="lista"><c:out value="${c.nome } " /></td>
							<td class="lista"><c:out value="${c.email } " /></td>
							<td class="lista"><c:out value="${c.limite_credito } " /></td>
							<td class="lista_ultimoelemento"><c:out value="${c.dt_nasc } " /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>	
</body>
</html>