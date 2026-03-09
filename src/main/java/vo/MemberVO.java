package vo;

import java.io.Serializable;

/**
 * 회원 정보를 저장할 class
 */
public class MemberVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int num;			// 회원번호
	private String id;			// 회원아이디
	private String nickname;    // [추가] 닉네임
	private String pass;		// 비밀번호
	private String name;		// 이름
	private String addr;		// 주소	
	private String phone;		// 전화번호
	private String email;       // 이메일
	private String gender;		// 성별(남성여성)
	private int age;			// 나이
	
	public MemberVO() {}

	// [수정] 생성자에 nickname 매개변수 추가
	public MemberVO(int num, String id, String nickname, String pass, String name, String addr, 
					String phone, String email, String gender, int age) {
		this.num = num;
		this.id = id;
		this.nickname = nickname; // [추가]
		this.pass = pass;
		this.name = name;
		this.addr = addr;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
		this.age = age;
	}

	// [추가] 닉네임 Getter/Setter
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPass() {
		return pass;
	}
	
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getAddr() {
		return addr;
	}
	
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
	    return email;
	}

	public void setEmail(String email) {
	    this.email = email;
	}	
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}
	
	// [수정] toString에도 nickname 포함
	@Override
	public String toString() {
		return "MemberVO [num=" + num + ", id=" + id + ", nickname=" + nickname + ", name=" + name + ", addr=" + addr
				+ ", phone=" + phone + ", email=" + email + ", gender=" + gender + ", age=" + age + "]";
	}
	
}