package Servlet.Module2;

import DAO.BillDAO;
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

    @Override
    public void init() {
        billDAO = new BillDAO();
        tableOrderDAO = new TableOrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String tableIdParam = req.getParameter("tableId");

        if ("getBill".equals(action) && tableIdParam != null) {
            try {
                int tableId = Integer.parseInt(tableIdParam);
                Bill bill = billDAO.getBillByTableId(tableId);

                if (bill != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("currentBill", bill);
                    resp.sendRedirect(req.getContextPath() + "/MenuFood2Servlet?action=search");
                } else {
                    resp.getWriter().println("<script>alert('Không tìm thấy hóa đơn cho bàn này!');history.back();</script>");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                resp.getWriter().println("<script>alert('Dữ liệu không hợp lệ!');history.back();</script>");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/searchTableOrdered");
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = req.getSession();
            Bill bill = (Bill) session.getAttribute("currentBill");
            TableOrder tableOrder = (TableOrder) session.getAttribute("currentTableOrder");
            if (bill == null) {
                resp.sendRedirect(req.getContextPath() + "/searchTableOrdered");
                return;
            }
            boolean success = billDAO.updateBill(bill);
            boolean success2 = tableOrderDAO.updateTableOrder(tableOrder.getId());
            String status = success && success2 ? "success" : "fail";
            resp.sendRedirect(req.getContextPath() + "/View/Customer/ConfirmOrderView.jsp?status=" + status);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/View/Customer/ConfirmOrderView.jsp?status=fail");
        }
    }
}