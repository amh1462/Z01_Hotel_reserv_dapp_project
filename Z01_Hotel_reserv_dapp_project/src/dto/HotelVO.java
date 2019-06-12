package dto;

public class HotelVO {
	private String hotelid; 
	private String password;
	private String hotelname;
	private String city;
	private String detailaddr;
	private String phone;
	private String photo;
	private String hwallet;
	private String auth;
	private String country;
	private String photo2;
	private String photo3;
	private String photo4;
	private String photo5;
	
	
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
	
	@Override
	public String toString() {
		return String.format("hotelid = %s, password = %s, hotelname = %s, city = %s, country = %s"
				+ " detailaddr= %s, phone= %s, photo = %s, hwallet = %s, auth = %s", hotelid, password, hotelname, city, country, detailaddr, phone, photo, hwallet, auth); 
	}
}
