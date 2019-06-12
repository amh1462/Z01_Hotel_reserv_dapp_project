package dto;

public class CavinVO {
	private int cavinId;
	private String cavinName;
	private String bedType;
	private String views; // 공항뷰, 마운틴뷰..
	private int personal; // 몇 명?
	private String options;
	private int rate; // 금액
	private int weekendRate; // 주말가
	
	public int getCavinId() {
		return cavinId;
	}
	public void setCavinId(int cavinId) {
		this.cavinId = cavinId;
	}
	public String getCavinName() {
		return cavinName;
	}
	public void setCavinName(String cavinName) {
		this.cavinName = cavinName;
	}
	public String getBedType() {
		return bedType;
	}
	public void setBedType(String bedType) {
		this.bedType = bedType;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	public int getPersonal() {
		return personal;
	}
	public void setPersonal(int personal) {
		this.personal = personal;
	}
	public String getOptions() {
		return options;
	}
	public void setOptions(String options) {
		this.options = options;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public int getWeekendRate() {
		return weekendRate;
	}
	public void setWeekendRate(int weekendRate) {
		this.weekendRate = weekendRate;
	}
	
	
}
