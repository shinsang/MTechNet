/**
 *
 */
package com.mocomsys.mtech.vo;

/**
 * @author shinsang&YungKi(used JoinProcess)
 *
 */
public class UserVO
{

    private String id;
    private String name;
	private String password;
    private String phone_num;
    private String email;
    private String property;
    private String status;
    
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


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getPhone_num() {
		return phone_num;
	}


	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getProperty() {
		return property;
	}


	public void setProperty(String property) {
		this.property = property;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append("[ MTechNet String  ]");

    	return sb.toString();
    }
}
