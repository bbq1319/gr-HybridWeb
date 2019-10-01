package com.gguri.gr.web.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserVO implements UserDetails {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * UserDetail
	 * 
	 * getUserName() : 계정의 이름 리턴
	 * getPassword() : 계정의 패스워드 리턴
	 * isAccountNonExpired() : 계정이 만료되지 않았는지를 리턴 (true 리턴 시, 만료되지 않음)
	 * isAccountNonLocked() : 계정이 잠겨있지 않았는지를 리턴 (true 리턴 시, 잠겨있지 않음)
	 * isCredentialsNonExpired() : 계정의 패스워드가 만료되지 않았는지를 리턴(true 리턴 시, 패스워드가 만료되지 않음)
	 * isEnabled() : 계정이 사용가능한 계정인지 리턴 (true 리턴 시, 사용가능한 계정)
	 * getAuthorities: 계정이 갖고 있는 권한 목록 리턴 
	 */
	private String id;
	private String pw;
	private String nm;
	private String stu_no;
	private String sex;
	private String type;
	private String major;
	private String sub_major;
	private String birth;
	private String regdate;
	private List<GrantedAuthority> authorities;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
		return authorities;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return id;
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return pw;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	
	
	
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public String getStu_no() {
		return stu_no;
	}

	public void setStu_no(String stu_no) {
		this.stu_no = stu_no;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getSub_major() {
		return sub_major;
	}

	public void setSub_major(String sub_major) {
		this.sub_major = sub_major;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

}
