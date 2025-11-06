package Model;

import java.util.Date;
import java.util.List;

public class Bill {
	private int id;
	private Date paymentDate;
	private float totalPayment;
	private String note;
    private String status;
	private Customer customer;
	private SaleStaff saleStaff;
	private List<FoodOrder> foodOrder;
	private List<TableOrder> tableOrder;

	public Bill() {
	}

	public Bill(int id, Date paymentDate, float totalPayment, String note, Customer customer, SaleStaff saleStaff,
			List<FoodOrder> foodOrder, List<TableOrder> tableOrder, String status) {
		this.id = id;
		this.paymentDate = paymentDate;
		this.totalPayment = totalPayment;
		this.note = note;
		this.customer = customer;
		this.saleStaff = saleStaff;
		this.foodOrder = foodOrder;
		this.tableOrder = tableOrder;
		this.status=status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public float getTotalPayment() {
		return totalPayment;
	}

	public void setTotalPayment(float totalPayment) {
		this.totalPayment = totalPayment;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public SaleStaff getSaleStaff() {
		return saleStaff;
	}

	public void setSaleStaff(SaleStaff saleStaff) {
		this.saleStaff = saleStaff;
	}

	public List<FoodOrder> getFoodOrder() {
		return foodOrder;
	}

	public void setFoodOrder(List<FoodOrder> foodOrder) {
		this.foodOrder = foodOrder;
	}

	public List<TableOrder> getTableOrder() {
		return tableOrder;
	}

	public void setTableOrder(List<TableOrder> tableOrder) {
		this.tableOrder = tableOrder;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
