package asm.osaki.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReCapChaDemo {
    @GetMapping("recapcha")
    public String recapcha(){

        return "ReCapChaDemo";
    }
}
