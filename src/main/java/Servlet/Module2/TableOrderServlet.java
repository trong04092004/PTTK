package Servlet.Module2;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/searchTableOrdered")
public class TableOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TableOrderServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String rowIndexParam = request.getParameter("rowIndex");
		HttpSession session = request.getSession();
		if (rowIndexParam != null) {
			doOnRow(request, response, rowIndexParam, session);
			return;
		}

		String infoCustomer = request.getParameter("infoCustomer");
		List<TableOrder> list = null;

		if (infoCustomer != null && !infoCustomer.trim().isEmpty()) {
			TableOrderDAO dao = new TableOrderDAO();
			list = dao.searchTableOrdered(infoCustomer);
		}
		session.setAttribute("listTableOrder", list);

		request.setAttribute("infoCustomer", infoCustomer);
		request.setAttribute("listTableOrder", list);
		request.getRequestDispatcher("/View/Customer/SearchTableOrderedView.jsp").forward(request, response);
	}

	private void doOnRow(HttpServletRequest request, HttpServletResponse response, String rowIndexParam,
			HttpSession session) throws ServletException, IOException {
		try {
			int index = Integer.parseInt(rowIndexParam);
			List<TableOrder> list = (List<TableOrder>) session.getAttribute("listTableOrder");

			if (list != null && index >= 0 && index < list.size()) {
				TableOrder selectedOrder = list.get(index);
				int tableorderId = selectedOrder.getId();
				BillDAO billDAO = new BillDAO();
				Bill bill = billDAO.getBill(tableorderId);

				if (bill != null) {
					session.setAttribute("currentBill", bill);
					session.setAttribute("currentTableOrder", selectedOrder);
					request.getRequestDispatcher("/View/Customer/SearchFood2View.jsp").forward(request, response);
				} else {
					response.getWriter()
							.println("<script>alert('Không tìm thấy hóa đơn cho bàn này!');history.back();</script>");
				}

			} else {
				response.sendRedirect(request.getContextPath() + "/searchTableOrdered");
			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/searchTableOrdered");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
