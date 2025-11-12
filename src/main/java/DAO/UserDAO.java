package DAO;
import java.sql.*;

import Model.User;
public class UserDAO extends DAO {
   public UserDAO() {
	   super();
   }
   public boolean checkLogin(User user) {
	   String query = "select * from tblUser where username = ? and password = ?";
	   try (PreparedStatement sql = con.prepareStatement(query)) {
		   sql.setString(1, user.getUsername());
		   sql.setString(2, user.getPassword());
		   ResultSet rs = sql.executeQuery();
		   if(rs.next()) {
			   user.setName(rs.getString("name"));
			   user.setRole(rs.getString("role"));
			   user.setAddress(rs.getString("address"));
			   user.setTel(rs.getString("tel"));
			   user.setId(rs.getInt("id"));
			   return true;
		   }
	   }
	   catch(Exception e) {
		   e.printStackTrace();
	   }
	   return false;
   }
}
