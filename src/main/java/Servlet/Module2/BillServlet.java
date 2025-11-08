package Servlet.Module2;

import DAO.BillDAO;
import DAO.FoodOrderDAO;
import DAO.TableOrderDAO;
import Model.Bill;
import Model.TableOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    private BillDAO billDAO;
    private TableOrderDAO tableOrderDAO;
    private FoodOrderDAO foodOrderDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
        tableOrderDAO = new TableOrderDAO();
        foodOrderDAO = new FoodOrderDAO();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            HttpSession session = req.getSession();
            Bill bill = (Bill) session.getAttribute("currentBill");
            TableOrder tableOrder = (TableOrder) session.getAttribute("currentTableOrder");
            
            if (bill == null || tableOrder == null) {
                resp.sendRedirect(req.getContextPath() + "/searchTableOrdered");
                return;
            }
            String[] foodOrderIds = req.getParameterValues("foodOrderId");
            String[] quantities = req.getParameterValues("quantity");

            boolean allUpdatesSuccess = true;
            
            if (foodOrderIds != null && quantities != null && foodOrderIds.length == quantities.length) {
                for (int i = 0; i < foodOrderIds.length; i++) {
                    int foodOrderId = Integer.parseInt(foodOrderIds[i]);
                    int newQuantity = Integer.parseInt(quantities[i]);
                    
                    boolean updateResult;
                    if (newQuantity <= 0) {
                        updateResult = foodOrderDAO.deleteFoodOrder(foodOrderId); 
                    } else {
                        updateResult = foodOrderDAO.updateFoodOrderQuantity(foodOrderId, newQuantity);
                    }
                    if (!updateResult) {
                        allUpdatesSuccess = false;
                    }
                }
            }
            if (!allUpdatesSuccess) {
                resp.sendRedirect(req.getContextPath() + "/View/Customer/ConfirmOrderView.jsp?status=fail");
                return;
            }
            if ("confirm".equals(action)) {
                boolean success = billDAO.updateBill(bill); 
                boolean success2 = tableOrderDAO.updateTableOrder(tableOrder.getId());
                boolean success3 = foodOrderDAO.updateStatusFO(bill.getId());
                String status = success && success2 && success3 ? "success" : "fail";
                resp.sendRedirect(req.getContextPath() + "/View/Customer/ConfirmOrderView.jsp?status=" + status);
            } else if ("save_and_back".equals(action)) {
                resp.sendRedirect(req.getContextPath() + "/MenuFood2Servlet?action=search");
            } else {
                resp.sendRedirect(req.getContextPath() + "/View/Customer/ConfirmOrderView.jsp?status=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/View/Customer/ConfirmOrderView.jsp?status=fail");
        }
    }
}