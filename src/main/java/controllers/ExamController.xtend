package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.Exam
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import services.ExamsService
import utils.Parsers

@Controller
class ExamController {
	extension JSONUtils = new JSONUtils
	ExamsService examsService = new ExamsService

	@Post("/classroom/:id/exam")
	def createPost(@Body String body) {
		try {
			val exam = body.fromJson(Exam)
			examsService.create(exam,id)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/exam")
	def editExam(@Body String body) {
		try {
			val exam = body.fromJson(Exam)
			examsService.updateExam(exam)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Get("/classroom/:id/user/:uid/exams")
	def getExams() {
		try {
			val exams = examsService.clasroomsExams(id,uid)
			return ok(exams.toJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(e.toJson)
		}
	}
	
	@Post("/exam/:eid/user/:uid")
	def startExam() {
		try {
			examsService.startExam(eid,uid)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/exam/:eid/user/:uid")
	def finishExam(@Body String body) {
		try {
			val answers = body.fromJson(Exam).questions
			examsService.finishExam(eid,uid,answers)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Get("/exam/:eid")
	def finishedExam() {
		try {
			val solved = examsService.uploadedExams(eid)
			return ok(solved.toJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/exam/:eid/user/:id/comment")
	def teachercomment(@Body String body) {
		try {
			val comment = body.fromJson(ParseComment)
			examsService.comment(eid,id,comment.teacherComment,comment.grade)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/classroom/:id/exam/:eid/activate")
	def getExassms() {
		try {
			examsService.enableExam(eid,id)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(e.toJson)
		}
	}

}

@Accessors
class ParseComment{
	String teacherComment
	double grade
}