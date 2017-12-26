package service.orders;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import service.orders.controller.OrderController;


import javax.inject.Inject;

import static org.hamcrest.Matchers.hasSize;
import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@WebMvcTest(OrderController.class)
public class OrderControllerTest {

    @Inject
    private MockMvc mockMvc;

    @Test
    public void create_ok() throws Exception {
        mockMvc
                .perform(post("/orders").contentType(APPLICATION_JSON).content("{\"order\": \"order 1\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value(hasSize(1)))
                .andExpect(jsonPath("$[0]").value("order 1"));

        mockMvc
                .perform(post("/orders").contentType(APPLICATION_JSON).content("{\"order\": \"order 2\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value(hasSize(2)))
                .andExpect(jsonPath("$[0]").value("order 1"))
                .andExpect(jsonPath("$[1]").value("order 2"));
    }

    @Test
    public void create_badRequest() throws Exception {
        mockMvc
                .perform(post("/orders").contentType(APPLICATION_JSON).content("{\"typoorder\": \"order N\"}"))
                .andExpect(status().isBadRequest())
                .andExpect(content().string("'order' is required."));
    }
}
