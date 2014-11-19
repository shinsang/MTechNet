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
 * @author shinsang
 *
 */
public class ContentsResult
{
	Connection _conn = null;

    public ContentsResult(Connection conn)
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
				cvo.setId(rs.getString("CONTENTS_ID"));
				cvo.setTitle(rs.getString("CONTENTS_TITLE"));
				cvo.setRefrence_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
				cvo.setRegist_date(rs.getString("CONTENTS_REGIST_DATE"));
				cvo.setReceive_user_id(rs.getString("CONTENTS_RECEIVE_USER_ID"));
				cvo.setRefrence_user_id(rs.getString("CONTENTS_REFRENCE_USER_ID"));
				cvo.setTag(rs.getString("CONTENTS_TAG"));
				cvo.setBody(rs.getString("CONTENTS_BODY"));
				cvo.setAttach_file(rs.getString("CONTENTS_ATTACH_FILE"));
				cvo.setStatus(rs.getString("CONTENTS_STATUS"));
				cvo.setClick_counts(rs.getString("CONTENTS_CLICK_COUNTS"));
				cvo.setRecommend_counts(rs.getString("CONTENTS_RECOMMEND_COUNTS"));

				arrList.add(cvo);
			}
			for(int i = 0; i < arrList.size() ; i++){
				System.out.println("List["+i+"]"+arrList.get(i).getTitle());;
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

    /**
     * ?��?�� ID?�� ?��?�� ?��?��?���? �?�?�? ?��?��.
     * @param id
     * @return
     */
    public ContentsInfoVO getSearchInfoByID(String id)
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
				cvo.setId(rs.getString("CONTENTS_ID"));
				cvo.setTitle(rs.getString("CONTENTS_TITLE"));
				cvo.setRefrence_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
				cvo.setRegist_date(rs.getString("CONTENTS_REGIST_DATE"));
				cvo.setReceive_user_id(rs.getString("CONTENTS_RECEIVE_USER_ID"));
				cvo.setRefrence_user_id(rs.getString("CONTENTS_REFRENCE_USER_ID"));
				cvo.setTag(rs.getString("CONTENTS_TAG"));
				cvo.setBody(rs.getString("CONTENTS_BODY"));
				cvo.setAttach_file(rs.getString("CONTENTS_ATTACH_FILE"));
				cvo.setStatus(rs.getString("CONTENTS_STATUS"));
				cvo.setClick_counts(rs.getString("CONTENTS_CLICK_COUNTS"));
				cvo.setRecommend_counts(rs.getString("CONTENTS_RECOMMEND_COUNTS"));

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
	 * ?��?��?��간에 ?��?��?��?�� timestamp ?��간을 �?�?�? ?��?��.
	 * @return
	 */
	private long getTime() {

		Calendar rightNow = Calendar.getInstance();
		return rightNow.getTimeInMillis();
	}

}
