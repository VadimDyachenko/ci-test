package service.clients;

import org.junit.Test;
import org.junit.runner.RunWith;
import javax.inject.Inject;

import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import service.clients.controller.ClientController;

import static org.hamcrest.Matchers.hasSize;
import static org.springframework.http.MediaType.APPLICATION_JSON;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@WebMvcTest(ClientController.class)
public class ClientControllerTest {

    @Inject
    private MockMvc mockMvc;

    @Test
    public void create_ok() throws Exception {
        mockMvc
                .perform(post("/clients").contentType(APPLICATION_JSON).content("{\"name\": \"Super Man\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value(hasSize(1)))
                .andExpect(jsonPath("$[0]").value("Super Man"));

        mockMvc
                .perform(post("/clients").contentType(APPLICATION_JSON).content("{\"name\": \"Iron man\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").value(hasSize(2)))
                .andExpect(jsonPath("$[0]").value("Super Man"))
                .andExpect(jsonPath("$[1]").value("Iron man"));
    }

    @Test
    public void create_badRequest() throws Exception {
        mockMvc
                .perform(post("/clients").contentType(APPLICATION_JSON).content("{\"typoName\": \"Hudson Mendes\"}"))
                .andExpect(status().isBadRequest())
                .andExpect(content().string("'name' is required."));
    }
}
