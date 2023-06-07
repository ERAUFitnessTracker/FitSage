package com.example.FitSage;

import java.sql.*;


public class UserDao {
    private final Connection connection;

    public UserDao() throws SQLException {
        this.connection = DriverManager.getConnection(null);
        String createTableSql = "CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, weight REAL, height REAL, age INTEGER, gender TEXT)";
        PreparedStatement createTableStatement = connection.prepareStatement(createTableSql);
        createTableStatement.execute();
    }

    public void addUser(User user) throws SQLException {
        String sql = "INSERT INTO user (name, weight, height, age, gender) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, user.getName());
        statement.setDouble(2, user.getWeight());
        statement.setDouble(3, user.getHeight());
        statement.setInt(4, user.getAge());
        statement.setString(5, user.getGender());
        statement.executeUpdate();
    }

    public void close() throws SQLException {
        connection.close();
    }
}