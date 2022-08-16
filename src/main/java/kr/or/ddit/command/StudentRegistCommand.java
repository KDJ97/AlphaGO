package kr.or.ddit.command;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import kr.or.ddit.dto.StudentVO;

@SuppressWarnings("serial")
public class StudentRegistCommand implements Serializable{
	private String id;
	private String name;
	
	private String schoolName;
	private String picture;
	private String[] phone;
	
	private String[]parentPhone;
	
	private String grade;
	
	
	 private String parentName;
	 
	 private String authority;
	 
	 private int schoolCode;
	 
	 private String address;
	 private String detailAddress;
	 
	 private String captureView;
	 


	 

	 
	 public String getCaptureView() {
		return captureView;
	}




	public void setCaptureView(String captureView) {
		this.captureView = captureView;
	}




	public String getAddress() {
		return address;
	}




	public void setAddress(String address) {
		this.address = address;
	}




	public String getDetailAddress() {
		return detailAddress;
	}




	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}




	public int getSchoolCode() {
		return schoolCode;
	}




	public void setSchoolCode(int schoolCode) {
		this.schoolCode = schoolCode;
	}




	public String getId() {
		return id;
	}




	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}




	public String getSchoolName() {
		return schoolName;
	}



	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}





	public String getPicture() {
		return picture;
	}






	public void setPicture(String picture) {
		this.picture = picture;
	}





	public String[] getPhone() {
		return phone;
	}





	public void setPhone(String[] phone) {
		this.phone = phone;
	}



	



	public String[] getParentPhone() {
		return parentPhone;
	}




	public void setParentPhone(String[] parentPhone) {
		this.parentPhone = parentPhone;
	}




	public String getGrade() {
		return grade;
	}



	public void setGrade(String grade) {
		this.grade = grade;
	}




	public String getParentName() {
		return parentName;
	}












	public void setParentName(String parentName) {
		this.parentName = parentName;
	}












	public String getAuthority() {
		return authority;
	}












	public void setAuthority(String authority) {
		this.authority = authority;
	}




	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
	}
	







	public StudentVO toStudentVO() {
		
		 String phone = "";
			
			for (String data : this.phone) {
				phone += data;
			}
			if (phone.length() == 11) {
				// 010-1234-1234
				phone = phone.substring(0, 3) + "-" +phone.substring(3, 7) + "-" + phone.substring(7);

			} 
			 String parentphone = "";
				
				for (String abc : this.parentPhone) {
					parentphone += abc;
				}
		 
				if (parentphone.length() == 11) {
					// 010-1234-1234
					parentphone = parentphone.substring(0, 3) + "-" +parentphone.substring(3, 7) + "-" + parentphone.substring(7);
				}
		 StudentVO student=new StudentVO();
		 
		 student.setId(id);
		 student.setSchoolName(schoolName);
		 student.setName(name);
		 student.setPicture(picture);
		 student.setPhone(phone);
		 student.setParentPhone(parentphone);
		 student.setGrade(grade);
		 student.setParentName(parentName);
		 student.setRegDate(new Date());
		 student.setAuthority(authority);
		 student.setSchoolCode(schoolCode);
		 student.setAddress(address);
		 student.setDetailAddress(detailAddress);
		 student.setCaptureView(this.captureView);
		 
		 
		 return student;
	 }
}
