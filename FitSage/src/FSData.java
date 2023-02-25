import java.sql.*;

import java.sql.*;

public class FSData {
    private final Connection connection;

    public FSData(String path) throws Exception {
        Class.forName("org.sqlite.JDBC");
        connection = DriverManager.getConnection("jdbc:sqlite:" + path);
    }

    public void close() throws Exception {
        connection.close();
    }

    public void insert(String name, String email) throws Exception {
        String sql = "INSERT INTO users (name, email) VALUES (?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, email);
        statement.executeUpdate();
        statement.close();
    }

    public void delete(int id) throws Exception {
        String sql = "DELETE FROM users WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        statement.executeUpdate();
        statement.close();
    }

    // add other database operations as needed
}

