package azure.trainning.ci.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

    @GetMapping
    String returnMessage(){
        return "Hello Pipeline";
    }
}
