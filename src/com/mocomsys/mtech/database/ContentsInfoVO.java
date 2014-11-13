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

    private String contents_id;
    private String contents_title;
	private String contents_regist_user_id;
    private String contents_regist_date;
    private String contents_receive_user_id;
    private String contents_refrence_user_id;
    private String contents_tag;
    private String contents_body;
    private String contents_attach_file;
	private String contents_status;
    private String contents_click_counts;
    private String contents_recommend_counts;


    public String getContents_id() {
    	return contents_id;
    }

	public void setContents_id(String contents_id) {
    	this.contents_id = contents_id;
    }

	public String getContents_title() {
    	return contents_title;
    }

	public void setContents_title(String contents_title) {
    	this.contents_title = contents_title;
    }

	public String getContents_regist_user_id() {
    	return contents_regist_user_id;
    }

	public void setContents_regist_user_id(String contents_regist_user_id) {
    	this.contents_regist_user_id = contents_regist_user_id;
    }

	public String getContents_regist_date() {
    	return contents_regist_date;
    }

	public void setContents_regist_date(String contents_regist_date) {
    	this.contents_regist_date = contents_regist_date;
    }

	public String getContents_receive_user_id() {
    	return contents_receive_user_id;
    }

	public void setContents_receive_user_id(String contents_receive_user_id) {
    	this.contents_receive_user_id = contents_receive_user_id;
    }

	public String getContents_refrence_user_id() {
    	return contents_refrence_user_id;
    }

	public void setContents_refrence_user_id(String contents_refrence_user_id) {
    	this.contents_refrence_user_id = contents_refrence_user_id;
    }

	public String getContents_tag() {
    	return contents_tag;
    }

	public void setContents_tag(String contents_tag) {
    	this.contents_tag = contents_tag;
    }

	public String getContents_body() {
    	return contents_body;
    }

	public void setContents_body(String contents_body) {
    	this.contents_body = contents_body;
    }

	public String getContents_attach_file() {
    	return contents_attach_file;
    }

	public void setContents_attach_file(String contents_attach_file) {
    	this.contents_attach_file = contents_attach_file;
    }

	public String getContents_status() {
    	return contents_status;
    }

	public void setContents_status(String contents_status) {
    	this.contents_status = contents_status;
    }

	public String getContents_click_counts() {
    	return contents_click_counts;
    }

	public void setContents_click_counts(String contents_click_counts) {
    	this.contents_click_counts = contents_click_counts;
    }

	public String getContents_recommend_counts() {
    	return contents_recommend_counts;
    }

	public void setContents_recommend_counts(String contents_recommend_counts) {
    	this.contents_recommend_counts = contents_recommend_counts;
    }

	public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append("[ MTechNet String  ]");

    	return sb.toString();
    }
}
