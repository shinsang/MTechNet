/**
 *
 */
package com.mocomsys.mtech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import com.mocomsys.mtech.vo.ContentsVO;
import com.mocomsys.mtech.vo.UserVO;

/**
 * @author shinsang
 *
 */
public class UserDAO
{
	Connection _conn = null;

    public UserDAO(Connection conn)
    {
    	this._conn = conn;
    }

    public ArrayList<UserVO> getAllUserInfoList()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserVO> arrList = new ArrayList<UserVO>();

		String sql = "SELECT * FROM USER_INFO";
		try {
			pstmt = _conn.prepareStatement(sql);
			System.out.println("UserDAO.java getAllUserInfoList() sql = " + sql);

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
//				System.out.println("UserDAO.java List["+i+"]"+arrList.get(i).getId());;
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

    public UserVO getUserInfoByID(String id)
    {
    	PreparedStatement pstmt = null;
    	PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		UserVO brvo = new UserVO();
		String sql = "SELECT * FROM USER_INFO WHERE USER_ID = ?";

		try {
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
public void userInsert(UserVO user){
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int count = 0;
		String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
		
		try{
			
			conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			sql = "insert into USER_INFO_TABLE values(?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(++count, ((UserVO) user).getId());
			pstmt.setString(++count, ((UserVO) user).getName());
			pstmt.setString(++count, ((UserVO) user).getPassword());
			pstmt.setString(++count, ((UserVO) user).getPhone_num());
			pstmt.setString(++count, ((UserVO) user).getEmail());
			pstmt.setString(++count, ((UserVO) user).getProperty());
			pstmt.setString(++count, ((UserVO) user).getStatus());
			pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}			
		}
	}

	public String userCheck(String id, String password){

		  PreparedStatement pstmt = null;
		  ResultSet rs =null;
		  String sql="";
		  String dbpasswd="";
		  String userName="";
		  
		  String R = "";	  
		  		 
		 try{
			 sql = "SELECT USER_PASSWORD, USER_NAME FROM USER_INFO WHERE USER_ID = ?";
			  pstmt = _conn.prepareStatement(sql);
			  pstmt.setString(1, id);
			  rs = pstmt.executeQuery();	 
			  
			  if(rs.next()){
				  dbpasswd =rs.getString("USER_PASSWORD");
			      userName = rs.getString("USER_Name");
//			      System.out.println("UserDAO userName : "+userName);

			      if(dbpasswd.equals(password)){
			        R += "1"; //인증성공
			      	R += "%";
			      	R += userName;
			      }
			      else {
			        R = "0"; //비밀번호 틀림
			      }
			    }
			    else {
			      R = "-1"; //해당 아이디 없음
			    }
		 }catch(Exception e){		 
		  e.printStackTrace();
		 }finally{
			 try {
				pstmt.close();
				} catch (SQLException e) {
				}
				try {
					rs.close();
				} catch (SQLException e) {
				}		  
		 }		 
		 return R;		 
		}
}
