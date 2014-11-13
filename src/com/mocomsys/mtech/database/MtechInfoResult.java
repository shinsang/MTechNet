/**
 *
 */
package com.mocomsys.mtech.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * @author sgtae
 *
 */
public class MtechInfoResult
{
	Connection _conn = null;

    public MtechInfoResult(Connection conn)
    {
    	this._conn = conn;
    }

    public ArrayList<ContentsInfoVO> getSeachList(String seaches){
    	System.out.println("-----getSeachList ["+seaches+"]");
    	PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<ContentsInfoVO> arrList = new ArrayList<ContentsInfoVO>();
    	String sql = "SELECT * FROM CONTENTS_INFO WHERE LOWER(CONTENTS_BODY) LIKE '%'||LOWER(?)||'%'";

    	try {
    		System.out.println("- sql ["+sql+"]");
	    	pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, seaches);
//			pstmt.setString(1, "%||LOWER("+seaches+")%");

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				ContentsInfoVO cvo = new ContentsInfoVO();
				System.out.println(rs.getString("CONTENTS_ID"));
				cvo.setContents_id(rs.getString("CONTENTS_ID"));
				cvo.setContents_title(rs.getString("CONTENTS_TITLE"));
				cvo.setContents_refrence_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
				cvo.setContents_regist_date(rs.getString("CONTENTS_REGIST_DATE"));
				cvo.setContents_receive_user_id(rs.getString("CONTENTS_RECEIVE_USER_ID"));
				cvo.setContents_refrence_user_id(rs.getString("CONTENTS_REFRENCE_USER_ID"));
				cvo.setContents_tag(rs.getString("CONTENTS_TAG"));
				cvo.setContents_body(rs.getString("CONTENTS_BODY"));
				cvo.setContents_attach_file(rs.getString("CONTENTS_ATTACH_FILE"));
				cvo.setContents_status(rs.getString("CONTENTS_STATUS"));
				cvo.setContents_click_counts(rs.getString("CONTENTS_CLICK_COUNTS"));
				cvo.setContents_recommend_counts(rs.getString("CONTENTS_RECOMMEND_COUNTS"));

				arrList.add(cvo);
			}
			for(int i = 0; i < arrList.size() ; i++){
				System.out.println("List["+i+"]"+arrList.get(i).getContents_title());;
			}
		} catch (SQLException e) {
			StackTraceElement[] ste = e.getStackTrace();
			for (int i=0;i < ste.length; i++) {
				System.out.println(ste[i].toString());
			}
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				}

			} catch (SQLException e) {
			}
			try {
				if(rs!=null){
					rs.close();
				}

			} catch (SQLException e) {
			}
		}

	return arrList;
    }
    
    public ContentsInfoVO getSearchResultByID(String id)
    {
    	PreparedStatement pstmt = null;
    	
		ResultSet rs = null;
		
		ContentsInfoVO cvo = new ContentsInfoVO();
//		String sql = "SELECT A.CLNT_NO, B.CLNT_NM, A.LIM_A, A.APRV_DT, A.MSG_CD, B.CELLPHONE, B.EMAIL FROM ACTIONS A, CLNT_INFO B WHERE A.CLNT_NO = B.CLNT_NO and B.CLNT_NO = ?";
		String sql = "SELECT * FROM CONTENTS_INFO WHERE CONTENTS_ID = ?";

		try {
			pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next())
			{
				cvo.setContents_id(rs.getString("CONTENTS_ID"));
				cvo.setContents_title(rs.getString("CONTENTS_TITLE"));
				cvo.setContents_refrence_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
				cvo.setContents_regist_date(rs.getString("CONTENTS_REGIST_DATE"));
				cvo.setContents_receive_user_id(rs.getString("CONTENTS_RECEIVE_USER_ID"));
				cvo.setContents_refrence_user_id(rs.getString("CONTENTS_REFRENCE_USER_ID"));
				cvo.setContents_tag(rs.getString("CONTENTS_TAG"));
				cvo.setContents_body(rs.getString("CONTENTS_BODY"));
				cvo.setContents_attach_file(rs.getString("CONTENTS_ATTACH_FILE"));
				cvo.setContents_status(rs.getString("CONTENTS_STATUS"));
				cvo.setContents_click_counts(rs.getString("CONTENTS_CLICK_COUNTS"));
				cvo.setContents_recommend_counts(rs.getString("CONTENTS_RECOMMEND_COUNTS"));
			}
		} catch (SQLException e) {
			StackTraceElement[] ste = e.getStackTrace();
			for (int i=0;i < ste.length; i++) {
				System.out.println(ste[i].toString());
			}
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				}
				
			} catch (SQLException e) {
			}
			try {
				if(rs!=null){
					rs.close();
				}
				
			} catch (SQLException e) {
			}
		}
		return cvo;
    }
    
    /**
     * UserInfo?˜ ? „ì²? Dataë¥? ê°?ì§?ê³? ?˜¨?‹¤.
     * @return
     */
    public ArrayList<UserInfoVO> getAllUserInfoList()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserInfoVO> arrList = new ArrayList<UserInfoVO>();
//		String sql = "SELECT ACTIONS.CLNT_NO, CLNT_INFO.CLNT_NM, ACTIONS.LIM_A, ACTIONS.MSG_CD, CLNT_INFO.CELLPHONE FROM ACTIONS, CLNT_INFO WHERE ACTIONS.CLNT_NO=CLNT_INFO.CLNT_NO";
//		String sql = "SELECT * FROM ACTIONS";
//		String sql = "SELECT A.CLNT_NO, B.CLNT_NM, A.LIM_A, A.APRV_DT, A.MSG_CD FROM ACTIONS A, CLNT_INFO B WHERE A.CLNT_NO=B.CLNT_NO";
//		String sql = "SELECT USER_ID, USER_NAME, USER_PASSWORD, USER_PHONE_NUM, USER_EMAIL, USER_PROPERTY, USER_STATUS FROM USER_INFO";
		String sql = "SELECT * FROM USER_INFO";
		try {
			pstmt = _conn.prepareStatement(sql);
			System.out.println("sql = " + sql);


			rs = pstmt.executeQuery();
			while (rs.next())
			{
				UserInfoVO brvo = new UserInfoVO();
				System.out.println("-------------------");
				System.out.println(rs.getString("USER_ID"));
				brvo.setUser_id(rs.getString("USER_ID"));
				brvo.setUser_name(rs.getString("USER_NAME"));
				brvo.setUser_password(rs.getString("USER_PASSWORD"));
				brvo.setUser_phone_num(rs.getString("USER_PHONE_NUM"));
				brvo.setUser_email(rs.getString("USER_EMAIL"));
				brvo.setUser_property(rs.getString("USER_PROPERTY"));
				brvo.setUser_status(rs.getString("USER_STATUS"));

//				brvo.setCellPhone(rs.getString("CELLPHONE"));
				arrList.add(brvo);
			}
			for(int i = 0; i < arrList.size() ; i++){
				System.out.println("List["+i+"]"+arrList.get(i).getUser_id());;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}
			try {
				rs.close();
			} catch (SQLException e) {
			}
		}
		return arrList;
    }

    /**
     * ?•´?‹¹ ID?— ?žˆ?Š” ?°?´?„°ë¥? ê°?ì§?ê³? ?˜¨?‹¤.
     * @param id
     * @return
     */
    public UserInfoVO getUserInfoByID(String id)
    {
    	PreparedStatement pstmt = null;
    	PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		UserInfoVO brvo = new UserInfoVO();
//		String sql = "SELECT A.CLNT_NO, B.CLNT_NM, A.LIM_A, A.APRV_DT, A.MSG_CD, B.CELLPHONE, B.EMAIL FROM ACTIONS A, CLNT_INFO B WHERE A.CLNT_NO = B.CLNT_NO and B.CLNT_NO = ?";
		String sql = "SELECT * FROM USER_INFO WHERE USER_ID = ?";

		try {
			pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next())
			{
				brvo.setUser_id(rs.getString("USER_ID"));
				brvo.setUser_name(rs.getString("USER_NAME"));
				brvo.setUser_password(rs.getString("USER_PASSWORD"));
				brvo.setUser_phone_num(rs.getString("USER_PHONE_NUM"));
				brvo.setUser_email(rs.getString("USER_EMAIL"));
				brvo.setUser_property(rs.getString("USER_PROPERTY"));
				brvo.setUser_status(rs.getString("USER_STATUS"));


//				String sql2 = "SELECT MSG_CD, MSG_TXT FROM MSG_INFO WHERE MSG_CD = ?";
//				pstmt2 = _conn.prepareStatement(sql2);
//				pstmt2.setString(1, rs.getString("MSG_CD"));
//				rs2 = pstmt2.executeQuery();
//				rs2.next();
//
//				brvo.setUser_id(rs2.getString("USER_ID"));
//				System.out.println("USER_ID = ["+rs.getString("USER_ID")+"]");
//				System.out.println("USER_ID = ["+rs2.getString("USER_ID")+"]");
			}
		} catch (SQLException e) {
			StackTraceElement[] ste = e.getStackTrace();
			for (int i=0;i < ste.length; i++) {
				System.out.println(ste[i].toString());
			}
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				}
				if(pstmt2!=null){
					pstmt2.close();
				}
			} catch (SQLException e) {
			}
			try {
				if(rs!=null){
					rs.close();
				}
				if(rs2!=null){
					rs2.close();
				}
			} catch (SQLException e) {
			}
		}
		return brvo;
    }

	/**
	 * ?˜„?ž¬?‹œê°„ì— ?•´?‹¹?˜?Š” timestamp ?‹œê°„ì„ ê°?ì§?ê³? ?˜¨?‹¤.
	 * @return
	 */
	private long getTime() {

		Calendar rightNow = Calendar.getInstance();
		return rightNow.getTimeInMillis();
	}

}
