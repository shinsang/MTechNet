/**
 *
 */
package com.mocomsys.mtech.database;

/**
 * @author shinsang
 *
 */
public class UserInfoVO
{

    private String user_id;
    private String user_name;
	private String user_password;
    private String user_phone_num;
    private String user_email;
    private String user_property;
    private String user_status;

    public String getUser_id() {
    	return user_id;
    }

	public void setUser_id(String user_id) {
    	this.user_id = user_id;
    }

	public String getUser_name() {
    	return user_name;
    }

	public void setUser_name(String user_name) {
    	this.user_name = user_name;
    }

	public String getUser_password() {
    	return user_password;
    }

	public void setUser_password(String user_password) {
    	this.user_password = user_password;
    }

	public String getUser_phone_num() {
    	return user_phone_num;
    }

	public void setUser_phone_num(String user_phone_num) {
    	this.user_phone_num = user_phone_num;
    }

	public String getUser_email() {
    	return user_email;
    }

	public void setUser_email(String user_email) {
    	this.user_email = user_email;
    }

	public String getUser_property() {
    	return user_property;
    }

	public void setUser_property(String user_property) {
    	this.user_property = user_property;
    }

	public String getUser_status() {
    	return user_status;
    }

	public void setUser_status(String user_status) {
    	this.user_status = user_status;
    }

    public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append("[ MTechNet String  ]");

    	return sb.toString();
    }
}
