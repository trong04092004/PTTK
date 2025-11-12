package Servlet;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import Model.User;

@WebServlet("/login")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        if (userDAO.checkLogin(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setMaxInactiveInterval(60*1); 
            String role = user.getRole();
            if ("Manager".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/View/Manager/ManagerHomeView.jsp");
            } else if ("Customer".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/View/Customer/CustomerHomeView.jsp");
            } else if ("SalesStaff".equalsIgnoreCase(role) || "SaleStaff".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/View/SalesStaff/SaleStaffHomeView.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/View/InventoryStaff/InventoryStaffHomeView.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Sai username hoặc password!");
            request.getRequestDispatcher("/View/User/LoginView.jsp").forward(request, response);
        }
    }
}