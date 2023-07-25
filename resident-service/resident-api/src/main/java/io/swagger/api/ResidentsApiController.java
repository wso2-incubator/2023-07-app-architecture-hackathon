package io.swagger.api;

import io.swagger.model.Resident;
import io.swagger.model.SearchField;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2023-07-25T04:20:14.086140772Z[GMT]")
@RestController
public class ResidentsApiController implements ResidentsApi {

    private static final Logger log = LoggerFactory.getLogger(ResidentsApiController.class);

    private final ObjectMapper objectMapper;

    private final HttpServletRequest request;

    @org.springframework.beans.factory.annotation.Autowired
    public ResidentsApiController(ObjectMapper objectMapper, HttpServletRequest request) {
        this.objectMapper = objectMapper;
        this.request = request;
    }

    @RequestMapping(value = "/residents",
            produces = { "application/json", "text/plain" },
            method = RequestMethod.GET)
    public ResponseEntity<List<Resident>> getResidents() throws IOException {

        List<Resident> residents = new ArrayList<>();
        Resident resident = new Resident();
        resident.setEmail("s");
        resident.setName("a");
        resident.setNic("1221");
        residents.add(resident);
        return new ResponseEntity<List<Resident>>(residents, HttpStatus.OK);

//
//        String accept = request.getHeader("Accept");
//        if (accept != null && accept.contains("application/json")) {
//            try {
//                return new ResponseEntity<List<Resident>>(objectMapper.readValue("[ {\n  \"name\" : \"name\",\n  \"houseNo\" : \"houseNo\",\n  \"nic\" : \"nic\",\n  \"phoneNo\" : \"phoneNo\",\n  \"email\" : \"email\"\n}, {\n  \"name\" : \"name\",\n  \"houseNo\" : \"houseNo\",\n  \"nic\" : \"nic\",\n  \"phoneNo\" : \"phoneNo\",\n  \"email\" : \"email\"\n} ]", List.class), HttpStatus.OK);
//            } catch (IOException e) {
//                log.error("Couldn't serialize response for content type application/json", e);
//                return new ResponseEntity<List<Resident>>(HttpStatus.INTERNAL_SERVER_ERROR);
//            }
//        }
//
//        return new ResponseEntity<List<Resident>>(HttpStatus.NOT_IMPLEMENTED);
    }

    @RequestMapping(value = "/residents/search",
            produces = { "application/json", "text/plain" },
            method = RequestMethod.GET)
//    public ResponseEntity<List<Resident>> getResidentsSearch(@Valid @RequestParam(value = "searchField", required = true) String searchField) {
    public ResponseEntity<List<Resident>> getResidentsSearch(@NotNull @Valid @RequestParam(value = "searchField", required = true) String searchField,@NotNull @Valid @RequestParam(value = "value", required = true) String value) {
        List<Resident> residents = new ArrayList<>();
        Resident resident = new Resident();
        resident.setEmail("search@gmail.com");
        resident.setName("a");
        resident.setNic("12211232");
        residents.add(resident);
        return new ResponseEntity<List<Resident>>(residents, HttpStatus.OK);

//        String accept = request.getHeader("Accept");
//        if (accept != null && accept.contains("application/json")) {
//            try {
//                return new ResponseEntity<List<Resident>>(objectMapper.readValue("[ {\n  \"name\" : \"name\",\n  \"houseNo\" : \"houseNo\",\n  \"nic\" : \"nic\",\n  \"phoneNo\" : \"phoneNo\",\n  \"email\" : \"email\"\n}, {\n  \"name\" : \"name\",\n  \"houseNo\" : \"houseNo\",\n  \"nic\" : \"nic\",\n  \"phoneNo\" : \"phoneNo\",\n  \"email\" : \"email\"\n} ]", List.class), HttpStatus.NOT_IMPLEMENTED);
//            } catch (IOException e) {
//                log.error("Couldn't serialize response for content type application/json", e);
//                return new ResponseEntity<List<Resident>>(HttpStatus.INTERNAL_SERVER_ERROR);
//            }
//        }
//
//        return new ResponseEntity<List<Resident>>(HttpStatus.NOT_IMPLEMENTED);
    }

}
