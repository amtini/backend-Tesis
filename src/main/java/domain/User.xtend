package domain

import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Accessors
class User{
	
	@Id
	@GeneratedValue
	Long id
	
	@Column
	boolean active = true
	
	@Column
	String name
	
	@Column
	String lastName
	
	@Column
	String email
	
	@Column
	int dni
	
	@Column
	String password
}