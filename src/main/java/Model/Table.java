package Model;

public class Table {
	private int id;
	private String numberTable;
	private String floor;
	private String des;

	public Table() {
	}

	public Table(int id, String numberTable, String floor, String des) {
		this.id = id;
		this.numberTable = numberTable;
		this.floor = floor;
		this.des = des;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumberTable() {
		return numberTable;
	}

	public void setNumberTable(String numberTable) {
		this.numberTable = numberTable;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}
}
