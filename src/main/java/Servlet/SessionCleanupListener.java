package Servlet;

import DAO.FoodOrderDAO;
import Model.Bill;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
@WebListener 
public class SessionCleanupListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        try {
            HttpSession session = se.getSession();
            Bill currentBill = (Bill) session.getAttribute("currentBill");

            if (currentBill != null) {
                FoodOrderDAO foodOrderDAO = new FoodOrderDAO();
                boolean result = foodOrderDAO.deletePendingOrders(currentBill.getId());
                
                if (result) {
                    System.out.println("[LISTENER] Đã dọn dẹp đơn hàng rác cho Bill ID: " + currentBill.getId() + " (Session Timeout)");
                } else {
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
