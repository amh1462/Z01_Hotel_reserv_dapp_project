package dto;

public class HotelVO {
	private String hotelid; 
	private String password;
	private String hotelname;
	private String city;
	private String detailaddr; // 상세주소
	private String phone;
	private String photo;
	private String hwallet; // 호텔 이더지갑 주소
	private String auth; // 인증여부(호텔 인증)
	private String country;
	private String photo2;
	private String photo3;
	private String photo4;
	private String photo5;
	private String cancelfee1; // 당일 취소시 %
	private String cancelfee2; // 1일전 취소시 %
	private String cancelfee3; // cancelday1일전 취소시 %
	private String cancelfee4; // cancelday2일전 취소시 %
	private String cancelday1;
	private String cancelday2;
	
	
	public String getHotelid() {
		return hotelid;
	}
	public void setHotelid(String hotelid) {
		this.hotelid = hotelid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getHotelname() {
		return hotelname;
	}
	public void setHotelname(String hotelname) {
		this.hotelname = hotelname;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDetailaddr() {
		return detailaddr;
	}
	public void setDetailaddr(String detailaddr) {
		this.detailaddr = detailaddr;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getHwallet() {
		return hwallet;
	}
	public void setHwallet(String hwallet) {
		this.hwallet = hwallet;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPhoto2() {
		return photo2;
	}
	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}
	public String getPhoto3() {
		return photo3;
	}
	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}
	public String getPhoto4() {
		return photo4;
	}
	public void setPhoto4(String photo4) {
		this.photo4 = photo4;
	}
	public String getPhoto5() {
		return photo5;
	}
	public void setPhoto5(String photo5) {
		this.photo5 = photo5;
	}
	public String getCancelfee1() {
		return cancelfee1;
	}
	public void setCancelfee1(String cancelfee1) {
		this.cancelfee1 = cancelfee1;
	}
	public String getCancelfee2() {
		return cancelfee2;
	}
	public void setCancelfee2(String cancelfee2) {
		this.cancelfee2 = cancelfee2;
	}
	public String getCancelfee3() {
		return cancelfee3;
	}
	public void setCancelfee3(String cancelfee3) {
		this.cancelfee3 = cancelfee3;
	}
	public String getCancelfee4() {
		return cancelfee4;
	}
	public void setCancelfee4(String cancelfee4) {
		this.cancelfee4 = cancelfee4;
	}
	public String getCancelday1() {
		return cancelday1;
	}
	public void setCancelday1(String cancelday1) {
		this.cancelday1 = cancelday1;
	}
	public String getCancelday2() {
		return cancelday2;
	}
	public void setCancelday2(String cancelday2) {
		this.cancelday2 = cancelday2;
	}

	
	@Override
	public String toString() {
		return String.format("hotelid = %s, password = %s, hotelname = %s, city = %s, country = %s"
				+ " detailaddr= %s, phone= %s, photo = %s, hwallet = %s, auth = %s, photo2 = %s, photo3 = %s, photo4 = %s, photo5 = %s",
				hotelid, password, hotelname, city, country, detailaddr, phone, photo, hwallet, auth, photo2, photo3, photo4, photo5); 
	}
}
