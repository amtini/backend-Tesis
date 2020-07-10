package serializers

import com.fasterxml.jackson.core.JsonParser
import com.fasterxml.jackson.core.JsonProcessingException
import com.fasterxml.jackson.databind.DeserializationContext
import com.fasterxml.jackson.databind.deser.std.StdDeserializer
import java.io.IOException
import java.time.LocalDate
import utils.Parsers

class LocalDateDeserializer extends StdDeserializer<LocalDate> {

    new() {
        super(LocalDate);
    }
    
    override LocalDate deserialize(JsonParser jp, DeserializationContext ctxt)
            throws IOException, JsonProcessingException {
        return Parsers.ParseStringToDate(jp.readValueAs(String));
    }

}