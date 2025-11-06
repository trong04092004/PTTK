package Model;

public class FoodOrder {
	private int id;
	private int quantity;
	private float price;
	private String foodOrderStatus;
	private String note;
	private MenuFood menuFood;

	public FoodOrder() {
	}

	public FoodOrder(int id, int quantity, float price, String foodOrderStatus, String note, MenuFood menuFood) {
		this.id = id;
		this.quantity = quantity;
		this.price = price;
		this.foodOrderStatus = foodOrderStatus;
		this.note = note;
		this.menuFood = menuFood;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getFoodOrderStatus() {
		return foodOrderStatus;
	}

	public void setFoodOrderStatus(String foodOrderStatus) {
		this.foodOrderStatus = foodOrderStatus;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public MenuFood getMenuFood() {
		return menuFood;
	}

	public void setMenuFood(MenuFood menuFood) {
		this.menuFood = menuFood;
	}
}
