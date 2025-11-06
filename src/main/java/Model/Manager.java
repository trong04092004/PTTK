package Model;

import java.util.Date;

public class Manager extends User {
	public Manager() {
		super();
	}

	public Manager(int id, String username, String password, String name, String address, String tel, Date bod,
			String role) {
		super(id, username, password, name, address, tel, bod, "Manager");
	}
}
