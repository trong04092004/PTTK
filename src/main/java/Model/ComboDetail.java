package Model;

public class ComboDetail {
	private int id;
	private int quantity;
	private String type;
	private String name;
	private Dish dish;

	public ComboDetail() {
		
	}

	public ComboDetail(String name, String type, int quantity, Dish dish) {
		super();
		this.name = name;
		this.type = type;
		this.quantity = quantity;
		this.dish = dish;
	}

	public int getId() {
		return id;
	}

	public int getQuantity() {
		return quantity;
	}

	public String getType() {
		return type;
	}

	public String getName() {
		return name;
	}

	public Dish getDish() {
		return dish;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDish(Dish dish) {
		this.dish = dish;
	}
}
