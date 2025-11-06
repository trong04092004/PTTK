package Model;

import java.util.Date;

public class SaleStaff extends User {
	public SaleStaff() {
		super();
	}

	public SaleStaff(int id, String username, String password, String name, String address, String tel, Date bod,
			String role) {
		super(id, username, password, name, address, tel, bod, "SaleStaff");
	}
}
