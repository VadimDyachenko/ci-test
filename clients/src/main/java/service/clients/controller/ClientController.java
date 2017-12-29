package service.clients.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.springframework.http.ResponseEntity.badRequest;
import static org.springframework.http.ResponseEntity.ok;
import static org.springframework.web.bind.annotation.RequestMethod.*;

@RestController
@RequestMapping(path = "clients")
public class ClientController {
    private static final List<String> CLIENTS = new ArrayList<>();

    @RequestMapping(path = "", method = POST)
    public ResponseEntity<?> writeDownClient(@RequestBody Map<String, Object> request) {
        if (request.containsKey("name") && request.get("name") != null) {
            CLIENTS.add(request.get("name").toString());
            return ok(CLIENTS);
        } else {
            return badRequest().body("'name' is required.");
        }
    }
    //add some changes
    //add some changes
    //Added test feature
}