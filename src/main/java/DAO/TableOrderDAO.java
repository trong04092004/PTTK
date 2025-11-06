package DAO;

import Model.TableOrder;
import Model.Table;
import Model.Customer; // <-- Cần import Customer
import java.util.*;
import java.sql.*;

public class TableOrderDAO extends DAO {

    public TableOrderDAO() {
        super();
    }
    public List<TableOrder> searchTableOrdered(String infoCustomer) {
        List<TableOrder> list = new ArrayList<>();
        String sql = """
        	    SELECT 
        	        todr.id AS orderId, todr.date, todr.startTime, todr.endTime, 
        	        todr.tableOrderStatus, todr.note,
        	        t.id AS tableId, t.numOfTable, t.floor, t.des,
        	        u.id AS customerId, u.name, u.tel, u.address
        	    FROM tblTableOrder AS todr
        	    JOIN tblTable AS t ON todr.tblTableid = t.id
        	    JOIN tblCustomer AS c ON todr.tblCustomerid = c.id
        	    JOIN tblUser AS u ON c.id = u.id
        	    WHERE (u.name COLLATE utf8mb4_vietnamese_ci LIKE ? OR u.tel LIKE ?) and todr.tableOrderStatus="Chưa gọi món"
        	""";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            String key = "%" + infoCustomer + "%";
            ps.setString(1, key);
            ps.setString(2, key);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
	                    Table table = new Table(
	                        rs.getInt("tableId"),
	                        rs.getString("numOfTable"),
	                        rs.getString("floor"),
	                        rs.getString("des")
	                    );
                    Customer customer = new Customer();
                    customer.setId(rs.getInt("customerId"));
                    customer.setName(rs.getString("name"));
                    customer.setTel(rs.getString("tel")); 
                    customer.setAddress(rs.getString("address"));
    
                    TableOrder tableOrder = new TableOrder();
                    tableOrder.setId(rs.getInt("orderId"));
                    tableOrder.setDate(rs.getDate("date"));
                    tableOrder.setStartTime(rs.getTime("startTime"));
                    tableOrder.setEndTime(rs.getTime("endTime"));
                    tableOrder.setTableOrderStatus(rs.getString("tableOrderStatus"));
                    tableOrder.setNote(rs.getString("note"));
                    
                    tableOrder.setTable(table);
                    tableOrder.setCustomer(customer);
                    
                    list.add(tableOrder);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean updateTableOrder(int idTableOrder) {
    	String sql="UPDATE tblTableOrder SET tableOrderStatus = ? WHERE id = ?";
    	try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "Đã đặt món");
            ps.setInt(2, idTableOrder);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}