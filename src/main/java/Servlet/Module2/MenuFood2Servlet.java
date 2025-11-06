package Servlet.Module2;

import DAO.FoodOrderDAO; // Thêm import
import DAO.MenuFoodDAO;
import Model.Bill; // Thêm import
import Model.FoodOrder; // Thêm import
import Model.MenuFood;
import Model.TableOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/MenuFood2Servlet")
public class MenuFood2Servlet extends HttpServlet {
    private MenuFoodDAO menuFoodDAO;
    private FoodOrderDAO foodOrderDAO;

    @Override
    public void init() {
        menuFoodDAO = new MenuFoodDAO();
        foodOrderDAO = new FoodOrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String key = req.getParameter("key");

        try {
            if (action == null || action.equals("search")) {
                List<MenuFood> listFood;
                if (key != null && !key.trim().isEmpty()) {
                    listFood = menuFoodDAO.SearchFoodByKey(key.trim());
                } else {
                    listFood = menuFoodDAO.getAllMenuFood();
                }
                req.getSession().setAttribute("lastSearchKey", key);
                req.getSession().setAttribute("listFood", listFood);
                req.setAttribute("listFood", listFood);

                req.getRequestDispatcher("/View/Customer/SearchFood2View.jsp").forward(req, resp);
            }

            else if (action.equals("choose")) {
                doOnRow(req, resp);
            }
            else if (action.equals("confirm")) {
                doConfirm(req, resp);
            }

            else {
                resp.sendRedirect(req.getContextPath() + "/MenuFood2Servlet?action=search");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Lỗi khi xử lý yêu cầu tìm kiếm món ăn!");
        }
    }
    protected void doConfirm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        try {
            Bill bill = (Bill) session.getAttribute("currentBill");

            TableOrder tableOrder = (TableOrder) session.getAttribute("currentTableOrder");

            if (bill == null || tableOrder == null) {
                resp.sendRedirect(req.getContextPath() + "/searchTableOrdered");
                return;
            }
            List<FoodOrder> orderedList = foodOrderDAO.getFoodOrdered(bill.getId());
            req.setAttribute("orderedList", orderedList);
            req.setAttribute("currentTableOrder", tableOrder);
            req.getRequestDispatcher("/View/Customer/ConfirmOrderView.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy thông tin xác nhận đơn hàng!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void doOnRow(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");

        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                List<MenuFood> listFood = (List<MenuFood>) req.getSession().getAttribute("listFood");

                if (listFood != null) {
                    MenuFood selectedFood = null;
                    for (MenuFood f : listFood) {
                        if (f.getId() == id) {
                            selectedFood = f;
                            break;
                        }
                    }

                    if (selectedFood != null) {
                        req.setAttribute("food", selectedFood);
                        req.getRequestDispatcher("/View/Customer/ChooseQuantityView.jsp").forward(req, resp);
                        return;
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/MenuFood2Servlet?action=search");
    }
}