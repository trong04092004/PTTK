package DAO;


import Model.MenuFood;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuFoodDAO extends DAO {

    public MenuFoodDAO() {
        super();
    }

    public List<MenuFood> getAllMenuFood() {
        List<MenuFood> list = new ArrayList<>();
        String sql = "SELECT id, name, type, price, des FROM tblmenufood";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                MenuFood m = new MenuFood();
                m.setId(rs.getInt("id"));
                m.setName(rs.getString("name"));
                m.setType(rs.getString("type"));
                m.setPrice(rs.getFloat("price"));
                m.setDes(rs.getString("des"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<MenuFood> SearchFoodByKey(String keyword) {
        List<MenuFood> list = new ArrayList<>();
        String sql = "SELECT id, name, type, price, des FROM tblmenufood WHERE name LIKE ? OR type LIKE ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MenuFood m = new MenuFood();
                    m.setId(rs.getInt("id"));
                    m.setName(rs.getString("name"));
                    m.setType(rs.getString("type"));
                    m.setPrice(rs.getFloat("price"));
                    m.setDes(rs.getString("des"));
                    list.add(m);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean editFood(MenuFood food) {
        String sql = "UPDATE tblmenufood SET name=?, type=?, price=?, des=? WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, food.getName());
            ps.setString(2, food.getType());
            ps.setFloat(3, food.getPrice());
            ps.setString(4, food.getDes());
            ps.setInt(5, food.getId());
            int updated = ps.executeUpdate();
            return updated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}

