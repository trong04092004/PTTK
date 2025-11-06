package Model;

import java.util.*;

public class Customer extends User {
	private String membershipCardStatus;
	private String membershipCode;

	public Customer() {
		super();
	}

	public Customer(int id, String username, String password, String name, String address, Date bod, String tel,
			String role, String membershipCardStatus, String membershipCode) {
		super(id, username, password, name, address, tel, bod, role);
		this.membershipCardStatus = membershipCardStatus;
		this.membershipCode = membershipCode;
	}

	public String getMembershipCardStatus() {
		return membershipCardStatus;
	}

	public void setMembershipCardStatus(String membershipCardStatus) {
		this.membershipCardStatus = membershipCardStatus;
	}

	public String getMembershipCode() {
		return membershipCode;
	}

	public void setMembershipCode(String membershipCode) {
		this.membershipCode = membershipCode;
	}
}
