/**
 *
 */
package com.mocomsys.mtech.database;

/**
 * @author shinsang
 *
 */
public class ContentsInfoVO
{

    private String id;
    private String title;
	private String regist_user_id;
    private String regist_date;
    private String receive_user_id;
    private String refrence_user_id;
    private String tag;
    private String body;
    private String attach_file;
	private String status;
    private String click_counts;
    private String recommend_counts;


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getRegist_user_id() {
		return regist_user_id;
	}


	public void setRegist_user_id(String regist_user_id) {
		this.regist_user_id = regist_user_id;
	}


	public String getRegist_date() {
		return regist_date;
	}


	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}


	public String getReceive_user_id() {
		return receive_user_id;
	}


	public void setReceive_user_id(String receive_user_id) {
		this.receive_user_id = receive_user_id;
	}


	public String getRefrence_user_id() {
		return refrence_user_id;
	}


	public void setRefrence_user_id(String refrence_user_id) {
		this.refrence_user_id = refrence_user_id;
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public String getBody() {
		return body;
	}


	public void setBody(String body) {
		this.body = body;
	}


	public String getAttach_file() {
		return attach_file;
	}


	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getClick_counts() {
		return click_counts;
	}


	public void setClick_counts(String click_counts) {
		this.click_counts = click_counts;
	}


	public String getRecommend_counts() {
		return recommend_counts;
	}


	public void setRecommend_counts(String recommend_counts) {
		this.recommend_counts = recommend_counts;
	}


	public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append("[ MTechNet String  ]");

    	return sb.toString();
    }
}
