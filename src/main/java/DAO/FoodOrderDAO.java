package DAO;

import Model.FoodOrder;
import Model.MenuFood;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FoodOrderDAO extends DAO {

	public boolean saveFoodOrder(FoodOrder order, int idBill) {
	    String sql = "INSERT INTO tblFoodOrder (tblMenuFoodid, tblBillid, quantity, price, foodOrderStatus, note) "
	               + "VALUES (?, ?, ?, ?, ?, ?) "
	               + "ON DUPLICATE KEY UPDATE "
	               + "quantity = quantity + VALUES(quantity)";

	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, order.getMenuFood().getId());
	        ps.setInt(2, idBill);
	        ps.setInt(3, order.getQuantity());
	        ps.setFloat(4, order.getPrice());
	        ps.setString(5, order.getFoodOrderStatus());
	        ps.setString(6, order.getNote());
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public ArrayList<FoodOrder> getFoodOrdered(int idBill){
		ArrayList<FoodOrder> list = new ArrayList<>();
        String sql = "SELECT fo.*, mf.name, mf.price AS menuFoodPrice, mf.type, mf.des " +
                     "FROM tblFoodOrder fo " +
                     "JOIN tblMenuFood mf ON fo.tblMenuFoodid = mf.id " +
                     "WHERE fo.tblBillid = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idBill);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MenuFood menuFood = new MenuFood();
                menuFood.setId(rs.getInt("tblMenuFoodid"));
                menuFood.setName(rs.getString("name"));
                menuFood.setPrice(rs.getFloat("menuFoodPrice"));
                menuFood.setType(rs.getString("type"));
                menuFood.setDes(rs.getString("des"));

                FoodOrder order = new FoodOrder();
                order.setId(rs.getInt("id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setPrice(rs.getFloat("price"));
                order.setFoodOrderStatus(rs.getString("foodOrderStatus"));
                order.setNote(rs.getString("note"));
                order.setMenuFood(menuFood);

                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
	}

