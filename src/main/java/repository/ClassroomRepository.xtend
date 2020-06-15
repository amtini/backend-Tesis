package repository

import domain.Classroom
import domain.Homework
import domain.User
import javax.persistence.NoResultException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import utils.BadCredentialsException

class ClassroomRepository extends HibernateRepository<Classroom> {

	static ClassroomRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new ClassroomRepository()
		}
		instance
	}

	override getEntityType() {
		Classroom
	}

	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<Classroom> query, Root<Classroom> from) {
		query.select(from).where(builder.equal(from.get("id"), id))
	}

	override allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}
	
	def getClassroomByListType(String id, String dataJoinType){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch(dataJoinType, JoinType.LEFT)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("id"), Long.parseLong(id))
				)
			)			
			entityManager.createQuery(query).singleResult
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
	
	
	def notAddedUsers(String idClassroom){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(User)
			val from = query.from(User)
			val classroom = searchById(idClassroom)
			query.select(from).where(
				criteria.not(
					from.get("id").in(classroom.users.map[it.id].toSet)	
				),
				criteria.or(
					criteria.equal(from.get("role"), "STUDENT"),
					criteria.equal(from.get("role"), "TEACHER")
				),
				criteria.equal(from.get("active"), true)
			)			
			entityManager.createQuery(query).resultList
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
	
	def getClassroomsByUser(String idUser){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("users", JoinType.LEFT)
			query.select(from).where(
				
				criteria.equal(from.get("active"), true)
			)			
			entityManager.createQuery(query).resultList
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
	
	def enabledHomework(String string) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}