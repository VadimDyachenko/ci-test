package service.orders.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.springframework.http.ResponseEntity.badRequest;
import static org.springframework.http.ResponseEntity.ok;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
@RequestMapping(path = "orders")
public class OrderController {
    private static final List<String> ORDERS = new ArrayList<>();

    @RequestMapping(path = "", method = POST)
    public ResponseEntity<?> writeDownOrder(@RequestBody Map<String, Object> request) {
        if (request.containsKey("order") && request.get("order") != null) {
            ORDERS.add(request.get("order").toString());
            return ok(ORDERS);
        } else {
            return badRequest().body("'order' is required.");
        }
    }
  // added changes
    //
    // added some changes
}