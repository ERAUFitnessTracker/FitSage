package com.example.ui_draft1;

public class User {
    private int id;
    private String name;
    private double weight;
    private double height;
    private int age;
    private String gender;

    public User(int id, String name, double weight, double height, int age, String gender) {
        this.id = id;
        this.name = name;
        this.weight = weight;
        this.height = height;
        this.age = age;
        this.gender = gender;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getWeight() {
        return weight;
    }

    public double getHeight() {
        return height;
    }

    public int getAge() {
        return age;
    }

    public String getGender() {
        return gender;
    }
}

