package Servlet.Module1;

import DAO.MenuFoodDAO;
import Model.MenuFood;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator; // Đã thêm import
import java.util.List;

@WebServlet("/MenuFoodServlet")
public class MenuFoodServlet extends HttpServlet {
    private MenuFoodDAO menuFoodDAO;

    @Override
    public void init() {
        menuFoodDAO = new MenuFoodDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String key = req.getParameter("key");
        if (key != null) {
            req.getSession().setAttribute("lastSearchKey", key.trim());
        }
        try {
            if (action == null || action.equals("search")) {
                List<MenuFood> listFood;
                if (key != null && !key.trim().isEmpty()) {
                    listFood = menuFoodDAO.SearchFoodByKey(key.trim());
                } else {
                    listFood = menuFoodDAO.getAllMenuFood();
                }

                // --- SỬA LẠI: Đưa đoạn sort ra ngoài để áp dụng cho cả Tìm kiếm và GetAll ---
                if (listFood != null) {
                    Collections.sort(listFood, new Comparator<MenuFood>() {
                        @Override
                        public int compare(MenuFood f1, MenuFood f2) {
                            return Double.compare(f1.getPrice(), f2.getPrice());
                        }
                    });
                }
                // --------------------------------------------------------------------------

                req.getSession().setAttribute("listFood", listFood);
                req.setAttribute("listFood", listFood);
                req.getRequestDispatcher("/View/Manager/SearchFoodView.jsp").forward(req, resp);
            } else if (action.equals("edit")) {
                String idStr = req.getParameter("id");
                if (idStr != null) {
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
                            req.getRequestDispatcher("/View/Manager/EditInfoFoodView.jsp").forward(req, resp);
                            return;
                        }
                    }
                    resp.sendRedirect(req.getContextPath() + "/MenuFoodServlet");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/MenuFoodServlet");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi xử lý yêu cầu.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        try {
            if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                String priceStr = req.getParameter("price").replace(",", "").trim();
                float price = Float.parseFloat(priceStr);
                String des = req.getParameter("des");
                String type = req.getParameter("type");
                MenuFood food = new MenuFood(id, name, price, des, type);
                boolean success = menuFoodDAO.editFood(food);
                String lastKey = (String) req.getSession().getAttribute("lastSearchKey");
                String redirectURL = req.getContextPath() + "/MenuFoodServlet?action=search";
                if (lastKey != null && !lastKey.trim().isEmpty()) {
                    redirectURL += "&key=" + java.net.URLEncoder.encode(lastKey, "UTF-8");
                }
                if (success) {
                    resp.sendRedirect(redirectURL + "&status=success");
                } else {
                    resp.sendRedirect(redirectURL + "&status=fail");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi cập nhật món ăn!");
        }
    }
}