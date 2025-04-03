package com.dahaedream.spring.test.controller;

import com.dahaedream.spring.test.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @Autowired
    public TestService testService;

    @GetMapping("/")
    public String index() {
        return "index";
    }
}
