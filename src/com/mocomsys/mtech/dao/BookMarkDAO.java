package com.mocomsys.mtech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import com.mocomsys.mtech.vo.BookMarkVO;
import com.mocomsys.mtech.vo.ContentsVO;
import com.mocomsys.mtech.vo.UserVO;

/**
 * @author jangPD
 *
 */
// 필요 메소드
// 1. 북마크 전체 row 반환
// 2. 유저 아이디에 대한 북마크 테이블과 컨첸츠 테이블을 조인해서 해당 리스트 반환 -> 해당 반환은 반드시 contentid, 글상태, 추천 수, 등록 시, 글제목, 본문을 리스트로 반환해야 함.
// 3. 유저 아이디와 컨텐츠 아이디를 넣어서 존재하는지 여부 체크 반환


public class BookMarkDAO
{
	Connection _conn = null;

    public BookMarkDAO(Connection conn)
    {
    	this._conn = conn;
    }
    
    //needs 1
    public ArrayList<BookMarkVO> getAllBookMarkInfoList()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BookMarkVO> arrList = new ArrayList<BookMarkVO>();

		String sql = "SELECT * FROM BOOKMARK_INFO";
		try {
			pstmt = _conn.prepareStatement(sql);
			//System.out.println("sql = " + sql);

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				BookMarkVO brvo = new BookMarkVO();
//				System.out.println("-------------------");
//				System.out.println(rs.getString("USER_ID"));
				
				brvo.setUserId(rs.getString("USER_ID"));
				brvo.setContentId(rs.getString("CONTENT_ID"));
				
				arrList.add(brvo);
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
    //needs 2
    // 2. 유저 아이디에 대한 북마크 테이블과 컨첸츠 테이블을 조인해서 해당 리스트 반환 -> 해당 반환은 반드시 contentid, 
    //글상태, 추천 수, 등록 시, 글제목, 본문을 리스트로 반환해야 함.
    public ArrayList<ContentsVO> getBookMarkAndContendInfoByUserId(String userId)
    {
    	ArrayList<ContentsVO> arrList = new ArrayList<ContentsVO>();
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = 
				"select B.content_id as CONTENT_ID ,C.CONTENTS_STATUS as CONTENT_STATUS, "
				+ "C.CONTENTS_RECOMMEND_COUNTS as CONTENT_RECOMMEND_COUNTS,C.contents_regist_date as CONTENT_REGIST_DATE, "
				+ "C.contents_title AS CONTENT_TITLE, C.CONTENTS_BODY as CONTENT_BODY "
				+ "from BOOKMARK_INFO B , Contents_info C "
				+ "where B.content_id=C.contents_id AND B.USER_ID='"+userId+"' "
				+ "ORDER BY CONTENTS_REGIST_DATE";
		
		try {
			pstmt = _conn.prepareStatement(sql);
						
			//System.out.println("sql = " + sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				ContentsVO ctvo = new ContentsVO();
				
				ctvo.setId(rs.getString("CONTENT_ID"));
				ctvo.setStatus(rs.getString("CONTENT_STATUS"));
				ctvo.setRecommend_counts(rs.getString("CONTENT_RECOMMEND_COUNTS"));
				ctvo.setRegist_date(rs.getString("CONTENT_REGIST_DATE"));
				ctvo.setTitle(rs.getString("CONTENT_TITLE"));
				ctvo.setBody(rs.getString("CONTENT_BODY"));				
				arrList.add(ctvo);
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
    
    public void BookMarkVOInsert(BookMarkVO bookMarkInfo){
		
		PreparedStatement pstmt = null;
		String sql = "";
		int count = 0;
		
		try{
			sql = "insert into BOOKMARK_INFO_TABLE values(?,?)";
			
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(++count, ((BookMarkVO) bookMarkInfo).getUserId());
			pstmt.setString(++count, ((BookMarkVO) bookMarkInfo).getContentId());
			pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}			
		}
	}
	//needs 3
	public boolean BookMarkCheck(String userId, String ContentId){

		  PreparedStatement pstmt = null;
		  ResultSet rs =null;
		  String sql="";
		  int resultCount=0;
		  boolean isChecked = false;
		 try{
			 sql = "SELECT COUNT(*) AS COUNT FROM BOOKMARK_INFO WHERE USER_ID = '"+userId+"' AND CONTENT_ID = '"+ContentId+"'";
			  //System.out.println("BookMark Check sql ="+sql);
			  pstmt = _conn.prepareStatement(sql);
			  rs = pstmt.executeQuery();	
			  while (rs.next()){
				  resultCount = rs.getInt("COUNT");		
			  }
			  
			  if(resultCount > 0) isChecked = true;
		 }catch(Exception e){		 
		  e.printStackTrace();
		 }finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}
			try {
				rs.close();
			} catch (SQLException e) {
			}
		}		 
		 return isChecked;		 
	}
}