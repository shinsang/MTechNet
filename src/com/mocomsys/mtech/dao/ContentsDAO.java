/**
 *
 */
package com.mocomsys.mtech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import com.mocomsys.mtech.vo.ContentsVO;

/**
 * @author shinsang
 *
 */
public class ContentsDAO
{
	Connection _conn = null;

    public ContentsDAO(Connection conn)
    {
    	this._conn = conn;
    }

    public ArrayList<ContentsVO> getContentsList(String seaches){
    	//System.out.println("ContentsDAO.java SearchString=("+seaches+")");
    	PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<ContentsVO> arrList = new ArrayList<ContentsVO>();
    	String sql = "SELECT * FROM CONTENTS_INFO WHERE LOWER(CONTENTS_TITLE) LIKE '%'||LOWER(?)||'%'";

    	try {
    		//System.out.println("- sql ["+sql+"]");
	    	pstmt = _conn.prepareStatement(sql);
	    	pstmt.setString(1, seaches);
	    	rs = pstmt.executeQuery();
	    	if(rs != null)
	    	{
	    		while (rs.next())
				{
					ContentsVO cvo = new ContentsVO();
					
					cvo.setId(rs.getString("CONTENTS_ID"));
					cvo.setTitle(rs.getString("CONTENTS_TITLE"));
					cvo.setRegist_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
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
					System.out.println("Select title=>"+rs.getString("CONTENTS_TITLE"));
				}				
	    	}
	    	else {
	    		System.out.println("Wow ... rs Null!! Critical Error!!!");
	    	}
		} catch (SQLException e) {
			System.out.println(e.toString());
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
       
    public ContentsVO getSearchResultByID(String id)
    {
    	PreparedStatement pstmt = null;
    	
		ResultSet rs = null;
		
		ContentsVO cvo = new ContentsVO();
		String sql = "SELECT * FROM CONTENTS_INFO WHERE CONTENTS_ID = ?";

		try {
			pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next())
			{
				cvo.setId(rs.getString("CONTENTS_ID"));
				cvo.setTitle(rs.getString("CONTENTS_TITLE"));
				cvo.setRegist_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
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
			
			//System.out.println("ID["+cvo.getId()+"] Title["+cvo.getTitle()+"] receive user id["+cvo.getReceive_user_id()+"] regist user id["+cvo.getRegist_user_id()+"]");
			
		} catch (SQLException e) {
			System.out.println("getSearchResultByID="+e.toString());
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

    
    public ArrayList<ContentsVO> getMyContentsByUserID(String userId)
    {
    	PreparedStatement pstmt = null;
    	ArrayList<ContentsVO> arrList = new ArrayList<ContentsVO>();
		ResultSet rs = null;	
		
		String sql = "SELECT * FROM CONTENTS_INFO WHERE CONTENTS_REGIST_USER_ID = ?";
		//System.out.println("ContentsDAO.java getMyContentsByUserID sql=>"+sql);
		
		try {
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				ContentsVO cvo = new ContentsVO();
				cvo.setId(rs.getString("CONTENTS_ID"));
				cvo.setTitle(rs.getString("CONTENTS_TITLE"));
				cvo.setRegist_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
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
    
    public ArrayList<ContentsVO> getReceivedContentAndQReadStatusByUserID(String userId) // 새로운 리스트 검색 방식
    {
    	PreparedStatement pstmt = null;
    	ArrayList<ContentsVO> arrList = new ArrayList<ContentsVO>();
		ResultSet rs = null;	
			
		String sql = "select A.*, B.READ_STATUS "
					 + "from contents_info A " 
					 + "LEFT JOIN new_CONTENTS_QUEUE B "
					 + "ON A.CONTENTS_ID=B.CONTENTS_ID AND A.CONTENTS_RECEIVE_USER_ID = B.USER_ID "
					 + "where A.CONTENTS_RECEIVE_USER_ID = ? and b.message_type = 2";
		
		
		
		try {
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(1, userId);

/*			if(ContentsStatus != null) {
				sql += " and A.CONTENTS_STATUS = ?";
				pstmt.setString(2, ContentsStatus);
			}*/
			
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				ContentsVO cvo = new ContentsVO();
				cvo.setId(rs.getString("CONTENTS_ID"));
				cvo.setTitle(rs.getString("CONTENTS_TITLE"));
				cvo.setRegist_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
				cvo.setRegist_date(rs.getString("CONTENTS_REGIST_DATE"));
				cvo.setReceive_user_id(rs.getString("CONTENTS_RECEIVE_USER_ID"));
				cvo.setRefrence_user_id(rs.getString("CONTENTS_REFRENCE_USER_ID"));
				cvo.setTag(rs.getString("CONTENTS_TAG"));
				cvo.setBody(rs.getString("CONTENTS_BODY"));
				cvo.setAttach_file(rs.getString("CONTENTS_ATTACH_FILE"));
				cvo.setStatus(rs.getString("CONTENTS_STATUS"));
				cvo.setClick_counts(rs.getString("CONTENTS_CLICK_COUNTS"));
				cvo.setRecommend_counts(rs.getString("CONTENTS_RECOMMEND_COUNTS"));
				cvo.setReadstatus(rs.getString("READ_STATUS"));
				arrList.add(cvo);	
				
				System.out.println("Title=>"+rs.getString("CONTENTS_TITLE") +"Read_Status=>"+rs.getString("READ_STATUS"));
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
    
    
    
    
    public ArrayList<ContentsVO> getSimpleReceivedContentByUserID(String userId) // 나중에 사용하지 않을 코드
    {
    	PreparedStatement pstmt = null;
    	ArrayList<ContentsVO> arrList = new ArrayList<ContentsVO>();
		ResultSet rs = null;	
		
		String sql = "SELECT * FROM CONTENTS_INFO WHERE CONTENTS_RECEIVE_USER_ID = ?";
		//System.out.println("ContentsDAO.java getSimpleReceivedContentByUserID sql=>"+sql);
		
		try {
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				ContentsVO cvo = new ContentsVO();
				cvo.setId(rs.getString("CONTENTS_ID"));
				cvo.setTitle(rs.getString("CONTENTS_TITLE"));
				cvo.setRegist_user_id(rs.getString("CONTENTS_REGIST_USER_ID"));
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
	 * ?��?��?��간에 ?��?��?��?�� timestamp ?��간을 �?�?�? ?��?��.
	 * @return
	 */
	private long getTime() {

		Calendar rightNow = Calendar.getInstance();
		return rightNow.getTimeInMillis();
	}

}
