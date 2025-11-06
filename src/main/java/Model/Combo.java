package Model;

import java.util.List;

public class Combo extends MenuFood {
	private List<ComboDetail> listDish;

	public Combo() {
		super();
	}

	public Combo(int id, String name,float price,  String des, String type, List<ComboDetail> listDish) {
		super(id, name,price,des, type);
		this.listDish = listDish;
	}

	public List<ComboDetail> getListDish() {
		return listDish;
	}

	public void setListDish(List<ComboDetail> listDish) {
		this.listDish = listDish;
	}
}
