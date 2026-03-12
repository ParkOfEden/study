package vo;

import java.io.Serializable;
import java.util.*; // toString용

@SuppressWarnings("unused")
public class MemberVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private int num;
    private String id;
    private String nickname;
    private String pass;
    private String name;
    private String addr;    
    private String phone;
    private String email;
    private String gender;
    private int age;
    
    // 추가: BLOB 데이터를 담을 바이트 배열
    private byte[] profileBlob; 

    public MemberVO() {}

    // 생성자 수정 (profileBlob 추가)
    public MemberVO(int num, String id, String nickname, String pass, String name, String addr, 
                    String phone, String email, String gender, int age, byte[] profileBlob) {
        this.num = num;
        this.id = id;
        this.nickname = nickname;
        this.pass = pass;
        this.name = name;
        this.addr = addr;
        this.phone = phone;
        this.email = email;
        this.gender = gender;
        this.age = age;
        this.profileBlob = profileBlob;
    }

    // 추가: profileBlob Getter/Setter
    public byte[] getProfileBlob() {
        return profileBlob;
    }

    public void setProfileBlob(byte[] profileBlob) {
        this.profileBlob = profileBlob;
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
                + ", phone=" + phone + ", email=" + email + ", gender=" + gender + ", age=" + age 
                + ", hasProfile=" + (profileBlob != null) + "]";
    }
}