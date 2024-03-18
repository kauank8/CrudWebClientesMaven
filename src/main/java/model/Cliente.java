package model;

import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Cliente {
	private String cpf;
	private String nome;
	private String email;
	private Double limite_credito;
	private String dt_nasc;
	
}
