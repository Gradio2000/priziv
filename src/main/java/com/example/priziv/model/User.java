package com.example.priziv.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class User {
    private Integer userId;
    private String name;
    private List<Role> roles;
}
