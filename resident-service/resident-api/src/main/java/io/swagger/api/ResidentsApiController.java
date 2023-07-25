package io.swagger.api;

import io.swagger.model.Resident;
import io.swagger.model.SearchField;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.repo.ResidentRepo;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2023-07-25T04:20:14.086140772Z[GMT]")
@RestController
public class ResidentsApiController implements ResidentsApi {

    private static final Logger log = LoggerFactory.getLogger(ResidentsApiController.class);

    private final ObjectMapper objectMapper;

    private final HttpServletRequest request;

    @Autowired
    private ResidentRepo residentRepo;


    @org.springframework.beans.factory.annotation.Autowired
    public ResidentsApiController(ObjectMapper objectMapper, HttpServletRequest request) {
        this.objectMapper = objectMapper;
        this.request = request;
    }

    @RequestMapping(value = "/residents",
            produces = { "application/json", "text/plain" },
            method = RequestMethod.GET)
    public ResponseEntity<List<Resident>> getResidents() throws IOException {
        List<Resident> residentsFromDB = residentRepo.findAll();
        return new ResponseEntity<List<Resident>>(residentsFromDB, HttpStatus.OK);
    }

    @RequestMapping(value = "/residents/search",
            produces = { "application/json", "text/plain" },
            method = RequestMethod.GET)
//    public ResponseEntity<List<Resident>> getResidentsSearch(@Valid @RequestParam(value = "searchField", required = true) String searchField) {
    public ResponseEntity<List<Resident>> getResidentsSearch(@NotNull @Valid @RequestParam(value = "searchField", required = true) String searchField,@NotNull @Valid @RequestParam(value = "value", required = true) final String value) {
        List<Resident> residentsFromDB = residentRepo.findAll();
        List<Resident> searchResult = new ArrayList<>();
        if (SearchField.NAME.toString().equals(searchField)) {
            searchResult = residentsFromDB.stream().filter(r -> r.getName().contains(value)).collect(Collectors.toList());
        } else if (SearchField.EMAIL.toString().equals(searchField)) {
            searchResult = residentsFromDB.stream().filter(r -> r.getName().equals(value)).collect(Collectors.toList());
        }

        return new ResponseEntity<List<Resident>>(searchResult, HttpStatus.OK);
    }

}
