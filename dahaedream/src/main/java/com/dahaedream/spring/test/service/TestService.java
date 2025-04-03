package com.dahaedream.spring.test.service;

import com.dahaedream.spring.test.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestService {

    @Autowired
    public TestMapper testMapper;
}
