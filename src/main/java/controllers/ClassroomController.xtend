package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.Classroom
import javax.persistence.NoResultException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import services.ClassroomService
import utils.Parsers

@Controller
class ClassroomController {
	ClassroomService classroomService = new ClassroomService
	extension JSONUtils = new JSONUtils

	@Get("/classrooms")
	def getClassrooms() {
		try {
			return ok(classroomService.getClassrooms().toJson)

		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/classroom/:id/users")
	def getClassroomUsers() {
		try {
			return ok(classroomService.getClassroomUsers(id).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Get("/classroom/:id")
	def getClassroomById(){
		try {
			val users = classroomService.getClassroomById(id)
			return ok(users.toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/classroom")
	def createClassroom(@Body String body){
		try {
			val classroom = body.fromJson(Classroom)
			classroomService.createClassroom(classroom)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Delete("/classroom/:id")
	def deleteClassroom(){
		try {
			classroomService.deleteClassroom(id)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/classroom/:id")
	def editClassroom(@Body String body) {
		try {
			val classroom = body.fromJson(Classroom)
			classroomService.editClassroom(classroom,id)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/classroom/:id/homework/:userId")
	def getClassroomHomework() {
		try {
			val a = classroomService.getClassroomHomework(id, userId)
			return ok(a.toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Get("/classroom/:id/homeworkuploaded/:userId")
	def getUserUploadedHomework() {
		try {
			val a = classroomService.getUserUploadedHomework(id, userId)
			return ok(a.toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	
	
	@Get("/classroom/:id/users/notadded")
	def getSubs() {
		try {
			return ok(classroomService.getNotAddedSubjects(id).toJson)
		} catch (NoResultException e) {
			return internalServerError(Parsers.errorJson(e.message))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/classroom/:id/posts/:userId")
	def getClassroomPosts() {
		try {
			return ok(classroomService.getClassroomPosts(id).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	
	@Get("/user/:id/classrooms")
	def getClassrooms() {
		try {
			return ok(classroomService.getClassroomsByUser(id).toJson)
		} catch (NoResultException e) {
			return internalServerError(Parsers.errorJson(e.message))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
