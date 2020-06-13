package utils

class Parsers{
	static def errorJson(String message) {
		'{ "error": "' + message + '" }'
	}
	static def statusOkJson() {
		'{ "status": "ok" }'
	}
	static def parsearDeStringALong(String unString) {
		Long.parseLong(unString)
	}
	
	static def parsearDeLongAString(Long unLong){
		Long.toString(unLong)
	}
}