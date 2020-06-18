package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.LocalDateSerializer

@Entity
@Accessors
class ForumPost {
	
	@Id
	@GeneratedValue
	Long id

	@OneToOne
	User user

	@Column
	boolean isPrivate

	@Column(columnDefinition="TEXT")
	String title

	@Column(columnDefinition="TEXT")
	String text

	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate date
	
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JsonIgnore
	List<ForumPost> responses = new ArrayList<ForumPost>
	
	def addComent(ForumPost comentToAdd){
		responses.add(comentToAdd)
	}
	
	def getCommentsAmount(){
		responses.size
	}
	
	def removeComent(ForumPost comentToRemove){
		responses.remove(comentToRemove)
	}
}