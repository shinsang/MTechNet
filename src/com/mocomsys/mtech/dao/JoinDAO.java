/**
 *
 */
package com.mocomsys.mtech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mocomsys.mtech.vo.UserVO;

/**
 * @author yungki
 *
 */
public class JoinDAO
{
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";
	
	Connection _conn = null;

    public JoinDAO()
    {
    	
    }
    public int getUserCountByID(String id)
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) as count FROM USER_INFO WHERE USER_ID = ?";
		int count=0;
		try {
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				count=rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				}
				if(_conn!=null){
					_conn.close();
				}
			} catch (SQLException e) {
			}
		}
		return count;
    }
    
    
    public ArrayList<UserVO> getAllUserInfoList()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserVO> arrList = new ArrayList<UserVO>();

		String sql = "SELECT * FROM USER_INFO";
		try {
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);
			System.out.println("JoinDAO.java getAllUserInfoList() sql = " + sql);

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				UserVO brvo = new UserVO();
				System.out.println("-------------------");
				System.out.println(rs.getString("USER_ID"));
				brvo.setId(rs.getString("USER_ID"));
				brvo.setName(rs.getString("USER_NAME"));
				brvo.setPassword(rs.getString("USER_PASSWORD"));
				brvo.setPhone_num(rs.getString("USER_PHONE_NUM"));
				brvo.setEmail(rs.getString("USER_EMAIL"));
				brvo.setProperty(rs.getString("USER_PROPERTY"));
				brvo.setStatus(rs.getString("USER_STATUS"));

//				brvo.setCellPhone(rs.getString("CELLPHONE"));
				arrList.add(brvo);
			}
			for(int i = 0; i < arrList.size() ; i++){
//				System.out.println("JoinDAO.java List["+i+"]"+arrList.get(i).getId());;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				}
				if(_conn!=null){
					_conn.close();
				}
			} catch (SQLException e) {
			}
			try {
				rs.close();
			} catch (SQLException e) {
			}
		}
		return arrList;
    }

    public UserVO getUserInfoByID(String id)
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserVO brvo = new UserVO();
		String sql = "SELECT * FROM USER_INFO WHERE USER_ID = ?";

		try {
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if (rs.next())
			{
				brvo.setId(rs.getString("USER_ID"));
				brvo.setName(rs.getString("USER_NAME"));
				brvo.setPassword(rs.getString("USER_PASSWORD"));
				brvo.setPhone_num(rs.getString("USER_PHONE_NUM"));
				brvo.setEmail(rs.getString("USER_EMAIL"));
				brvo.setProperty(rs.getString("USER_PROPERTY"));
				brvo.setStatus(rs.getString("USER_STATUS"));

			}
		} catch (SQLException e) {
			StackTraceElement[] ste = e.getStackTrace();
			for (int i=0;i < ste.length; i++) {
//				System.out.println(ste[i].toString());
			}
		} finally {
			try {
				if(pstmt!=null){
					pstmt.close();
					
				}
				if(_conn!=null){
					_conn.close();
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
		return brvo;
    }
    public int userInsert(UserVO user){
		PreparedStatement pstmt = null;
		String sql = "";
		int count = 0;
		int returnCount=-1;
		try{			
			sql = "insert into USER_INFO(USER_ID,USER_NAME,USER_PASSWORD,USER_PHONE_NUM,USER_EMAIL,USER_PROPERTY) values(?,?,?,?,?,?)";
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(++count, ((UserVO) user).getId());
			pstmt.setString(++count, ((UserVO) user).getName());
			pstmt.setString(++count, ((UserVO) user).getPassword());
			pstmt.setString(++count, ((UserVO) user).getPhone_num());
			pstmt.setString(++count, ((UserVO) user).getEmail());
			pstmt.setString(++count, ((UserVO) user).getProperty());
			returnCount = pstmt.executeUpdate();
			System.out.println("Sql = "+sql + "\nReturn Value = "+returnCount);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				if(_conn!=null){
					_conn.close();
				}
				}
			} catch (SQLException e) {
			}
		}
		return returnCount;
	}
    public int userUpdate(UserVO user){
		PreparedStatement pstmt = null;
		String sql = "";
		int count = 0;
		int returnCount=-1;
		try{			
			sql = "UPDATE USER_INFO SET USER_NAME=?,USER_PASSWORD=?,USER_PHONE_NUM=?,USER_EMAIL=?,USER_PROPERTY=? "
					+ "where USER_ID=?";
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);
			pstmt.setString(++count, ((UserVO) user).getName());
			pstmt.setString(++count, ((UserVO) user).getPassword());
			pstmt.setString(++count, ((UserVO) user).getPhone_num());
			pstmt.setString(++count, ((UserVO) user).getEmail());
			pstmt.setString(++count, ((UserVO) user).getProperty());
			pstmt.setString(++count, ((UserVO) user).getId());
			returnCount = pstmt.executeUpdate();
			System.out.println("Sql = "+sql + "\nReturn Value = "+returnCount);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null){
					pstmt.close();
				if(_conn!=null){
					_conn.close();
				}
				}
			} catch (SQLException e) {
			}
		}
		return returnCount;
	}

}
