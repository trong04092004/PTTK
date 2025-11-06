package Servlet.Module2;

import DAO.FoodOrderDAO;
import Model.FoodOrder;
import Model.MenuFood;
import Model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/FoodOrderServlet")
public class FoodOrderServlet extends HttpServlet {
    private FoodOrderDAO foodOrderDAO;

    @Override
    public void init() {
        foodOrderDAO = new FoodOrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            List<MenuFood> listFood = (List<MenuFood>) req.getSession().getAttribute("listFood");
            Bill bill = (Bill) req.getSession().getAttribute("currentBill");
            String lastSearchKey = (String) req.getSession().getAttribute("lastSearchKey");

            boolean success = false;
            if (listFood != null && bill != null) {
                for (MenuFood f : listFood) {
                    if (f.getId() == id) {
                        FoodOrder order = new FoodOrder();
                        order.setMenuFood(f);
                        order.setQuantity(quantity);
                        order.setPrice(f.getPrice());
                        order.setFoodOrderStatus("Đang đặt");
                        order.setNote("");
                        success = foodOrderDAO.saveFoodOrder(order, bill.getId());
                        break;
                    }
                }
            }

            String redirectURL = req.getContextPath() + "/MenuFood2Servlet?action=search";
            if (lastSearchKey != null && !lastSearchKey.trim().isEmpty()) {
                redirectURL += "&key=" + URLEncoder.encode(lastSearchKey, "UTF-8");
            }
            redirectURL += success ? "&status=success" : "&status=fail";
            resp.sendRedirect(redirectURL);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thêm món ăn vào đơn hàng!");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/MenuFood2Servlet?action=search").forward(req, resp);
    }
}
