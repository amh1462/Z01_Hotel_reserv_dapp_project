package dto;

import java.util.Date;

public class ReservVO {
	private String resNo;
	private String resName;
	private int cabinId;
	private Date checkIn;
	private Date checkOut;
	private String phone;
	private String user_wallet;
	
	public String getResNo() {
		return resNo;
	}
	public void setResNo(String resNo) {
		this.resNo = resNo;
	}
	public String getResName() {
		return resName;
	}
	public void setResName(String resName) {
		this.resName = resName;
	}
	public int getCabinId() {
		return cabinId;
	}
	public void setCabinId(int cabinId) {
		this.cabinId = cabinId;
	}
	public Date getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}
	public Date getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUser_wallet() {
		return user_wallet;
	}
	public void setUser_wallet(String user_wallet) {
		this.user_wallet = user_wallet;
	}
}
