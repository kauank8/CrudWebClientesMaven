package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cliente;
import persistence.ClienteDao;
import persistence.GenericDao;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ClienteServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// Entrada
			String cmd = request.getParameter("botao");
			String cpf = request.getParameter("cpf");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String limite = request.getParameter("limite");
			String dt_nasc = request.getParameter("datanasc");
			
			// Retorno
			String saida = "";
			String erro = "";
			Cliente cl = new Cliente();
			List<Cliente> clientes = new ArrayList<>();
			
			if (!cmd.contains("Listar")) {
				cl.setCpf(cpf);
			}
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				cl.setNome(nome);
				cl.setEmail(email);
				if(limite !="") {
				cl.setLimite_credito(Double.parseDouble(limite));
				}
				cl.setDt_nasc(dt_nasc);
			}
			
			try {
				if (cmd.contains("Cadastrar")) {
					if(limite.isEmpty() || nome.isEmpty() || email.isEmpty() || dt_nasc.isEmpty()) {
						saida = "Preencha Todos os Campos";
					} else {
					saida = cadastrarCliente(cl);
					cl = null;
					}
				}
				if (cmd.contains("Alterar")) {
					saida = alterarCliente(cl);
					saida="Cliente Atualizado com sucesso";
					cl = null;
				}
				if (cmd.contains("Excluir")) {
					saida = excluirCliente(cl);
					saida="Cliente Excluido com sucesso";
					cl = null;
				}
				if (cmd.contains("Buscar")) {
					cl = buscarCliente(cl);
				}
				if (cmd.contains("Listar")) {
					clientes = listarCliente();
				}
			} catch (SQLException | ClassNotFoundException e) {
				erro = e.getMessage();
			} finally {
				request.setAttribute("saida", saida);
				request.setAttribute("erro", erro);
				request.setAttribute("cliente", cl);
				request.setAttribute("clientes", clientes);

				RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
				rd.forward(request, response);
			}
	}
	private String cadastrarCliente(Cliente cl) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ClienteDao cDao = new ClienteDao(gDao);
		String saida = cDao.inserir(cl);
		return saida;
	}
	
	private String alterarCliente(Cliente cl) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ClienteDao cDao = new ClienteDao(gDao);
		String saida = cDao.atualizar(cl);
		return saida;
	}
	
	private String excluirCliente(Cliente cl) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ClienteDao cDao = new ClienteDao(gDao);
		String saida = cDao.excluir(cl);
		return saida;
	}
	
	private List<Cliente> listarCliente() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ClienteDao cDao = new ClienteDao(gDao);
		List<Cliente> clientes = cDao.listar();
		return clientes;
	}

	private Cliente buscarCliente(Cliente cl) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ClienteDao cDao = new ClienteDao(gDao);
		cl = cDao.consultar(cl);
		return cl;
	}

	

	



}
