package dto;

public class ReservVO {
	
	private String resno;
	private String roomno;
	private String guestname;
	private String email;
	private String phone;
	private String uwallet;
	private String totalprice;
	private String ordernum;
	private String checkin;
	private String checkout;
	private String iscancel;
	private String iswithdraw;
	private String time;
	
	public String getResno() {
		return resno;
	}
	public void setResno(String resno) {
		this.resno = resno;
	}
	public String getRoomno() {
		return roomno;
	}
	public void setRoomno(String roomno) {
		this.roomno = roomno;
	}
	public String getGuestname() {
		return guestname;
	}
	public void setGuestname(String guestname) {
		this.guestname = guestname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUwallet() {
		return uwallet;
	}
	public void setUwallet(String uwallet) {
		this.uwallet = uwallet;
	}
	public String getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(String totalprice) {
		this.totalprice = totalprice;
	}
	public String getOrdernum() {
		return ordernum;
	}
	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getIscancel() {
		return iscancel;
	}
	public void setIscancel(String iscancel) {
		this.iscancel = iscancel;
	}
	public String getIswithdraw() {
		return iswithdraw;
	}
	public void setIswithdraw(String iswithdraw) {
		this.iswithdraw = iswithdraw;
	}
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	@Override
	public String toString() {
		return String.format("resno = %s, roomno  = %s, "+ 
							 "guestname = %s, email = %s, "+
							 "phone = %s, uwallet = %s, " + 
							 "totalprice = %s, ordernum = %s, "+
							 "checkin = %s, checkout = %s, " +
							 "iscancel = %s, iswithdraw = %s, "+
							 "time = %s"
							 ,resno, roomno, guestname, email, 
							 uwallet, totalprice, ordernum, 
							 checkin, checkout, iscancel, iswithdraw,
							 time);
	}
}
