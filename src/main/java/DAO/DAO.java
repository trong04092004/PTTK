package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
	protected Connection con;
	private static final String URL = "jdbc:mysql://localhost:3306/pttk2?useSSL=false";
    private static final String USER = "trong";
    private static final String PASS = "Trong2004@"; 
    public DAO() {
        this.con = getConnection();
    }
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
