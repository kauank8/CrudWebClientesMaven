package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Cliente;

public class ClienteDao implements ICrud<Cliente> {
	
	private GenericDao gDao;
	
	public ClienteDao(GenericDao gDao) {
		super();
		this.gDao = gDao;
	}
	
	@Override
	public String inserir(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_insertCliente (?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cl.getCpf());
		cs.setString(2, cl.getNome());
		cs.setString(3, cl.getEmail());
		cs.setDouble(4, cl.getLimite_credito());
		cs.setString(5, cl.getDt_nasc().toString());
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(6);
		cs.close();
		c.close();
		
		return saida;
	}

	@Override
	public String atualizar(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_updateCliente (?, ?, ?, ?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cl.getCpf());
		cs.setString(2, cl.getNome());
		cs.setString(3, cl.getEmail());
		cs.setDouble(4, cl.getLimite_credito());
		cs.setString(5, cl.getDt_nasc().toString());
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(6);
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public String excluir(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_updateCliente (?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cl.getCpf());
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(2);
		cs.close();
		c.close();
		return saida;
	}

	@Override
	public Cliente consultar(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Select * from Cliente Where cpf = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, cl.getCpf());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			cl.setCpf(rs.getString("cpf"));
			cl.setNome(rs.getString("nome"));
			cl.setEmail(rs.getString("email"));
			cl.setLimite_credito(rs.getDouble("limite_credito"));
			cl.setDt_nasc(rs.getString("dt_Nascimento"));
		}
		rs.close();
		ps.close();
		c.close();
		return cl;
	}

	@Override
	public List<Cliente> listar() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Cliente> clientes = new ArrayList<>();
		String sql = "Select * From Cliente";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Cliente cl = new Cliente();
			cl.setCpf(rs.getString("cpf"));
			cl.setNome(rs.getString("nome"));
			cl.setEmail(rs.getString("email"));
			cl.setLimite_credito(rs.getDouble("limite_credito"));
			cl.setDt_nasc(rs.getString("dt_Nascimento"));
			clientes.add(cl);
		}
		rs.close();
		ps.close();
		c.close();
		return clientes;
	}

}
