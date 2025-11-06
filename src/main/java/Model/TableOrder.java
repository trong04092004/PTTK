package Model;

import java.util.Date;

public class TableOrder {
	private int id;
	private Date date;
	private Date startTime;
	private Date endTime;
	private String tableOrderStatus;
	private String note;
	private Table table;
	private Customer customer;

	public TableOrder() {
	}

	public TableOrder(int id, Date date, Date startTime, Date endTime, String tableOrderStatus, String note,
			Table table, Customer customer) {
		this.id = id;
		this.date = date;
		this.startTime = startTime;
		this.endTime = endTime;
		this.tableOrderStatus = tableOrderStatus;
		this.note = note;
		this.table = table;
		this.customer=customer;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getTableOrderStatus() {
		return tableOrderStatus;
	}

	public void setTableOrderStatus(String tableOrderStatus) {
		this.tableOrderStatus = tableOrderStatus;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Table getTable() {
		return table;
	}

	public void setTable(Table table) {
		this.table = table;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer=customer;
	}
}
