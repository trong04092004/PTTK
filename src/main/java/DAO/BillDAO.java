package DAO;

import Model.Bill;

import Model.Customer;
import Model.SaleStaff;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO extends DAO {

    public BillDAO() {
        super();
    }

    public Bill getBillByTableId(int tableorderId) {
        Bill bill = null;
        String sql = "SELECT b.id, b.paymentDate, b.note, b.status " +
                "FROM tblBill b " +
                "JOIN tblTableOrder t ON b.id = t.tblBillid " +
                "WHERE t.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, tableorderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bill = new Bill();
                bill.setId(rs.getInt("id"));
                bill.setPaymentDate(rs.getDate("paymentDate"));
                bill.setNote(rs.getString("note"));
                bill.setStatus(rs.getString("status"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bill;
    }
    public boolean updateBill(Bill bill) {
    	String sql = "UPDATE tblBill SET status = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "Đã đặt món");
            ps.setInt(2, bill.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
