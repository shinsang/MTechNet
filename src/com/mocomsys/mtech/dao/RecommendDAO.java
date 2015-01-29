package com.mocomsys.mtech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import com.mocomsys.mtech.vo.RecommendVO;
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


public class RecommendDAO
{
	Connection _conn = null;

    public RecommendDAO(Connection conn)
    {
    	this._conn = conn;
    }
    
    //needs 1
    public ArrayList<RecommendVO> getAllRecommendInfoList()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RecommendVO> arrList = new ArrayList<RecommendVO>();

		String sql = "SELECT * FROM Recommend_INFO";
		try {
			pstmt = _conn.prepareStatement(sql);
			//System.out.println("sql = " + sql);

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				RecommendVO brvo = new RecommendVO();
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
        
    public void RecommendVOInsert(RecommendVO RecommendInfo){
		
		PreparedStatement pstmt = null;
		String sql = "";
		int count = 0;
		
		try{
			sql = "insert into Recommend_INFO_TABLE values(?,?)";
			
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(++count, ((RecommendVO) RecommendInfo).getUserId());
			pstmt.setString(++count, ((RecommendVO) RecommendInfo).getContentId());
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
	public boolean RecommendCheck(String userId, String ContentId){

		  PreparedStatement pstmt = null;
		  ResultSet rs =null;
		  String sql="";
		  int resultCount=0;
		  boolean isChecked = false;
		  		 
		 try{
			 sql = "SELECT COUNT(*) AS COUNT FROM Recommend_INFO WHERE USER_ID = '"+userId+"' AND CONTENT_ID = '"+ContentId+"'";
			 //System.out.println("Recommend Check sql ="+sql);
			  pstmt = _conn.prepareStatement(sql);
			  rs = pstmt.executeQuery();	
			  while (rs.next()){
				  resultCount = rs.getInt("COUNT");		
			  }
			  if(resultCount > 0) {
				  isChecked = true;
				  //System.out.println("Recommend Check true");
			  }
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