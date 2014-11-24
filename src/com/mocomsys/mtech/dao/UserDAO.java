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

   
    /**
     * UserInfo?�� ?���? Data�? �?�?�? ?��?��.
     * @return
     */
    public ArrayList<UserVO> getAllUserInfoList()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserVO> arrList = new ArrayList<UserVO>();
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
				System.out.println("List["+i+"]"+arrList.get(i).getId());;
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
     * ?��?�� ID?�� ?��?�� ?��?��?���? �?�?�? ?��?��.
     * @param id
     * @return
     */
    public UserVO getUserInfoByID(String id)
    {
    	PreparedStatement pstmt = null;
    	PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		UserVO brvo = new UserVO();
//		String sql = "SELECT A.CLNT_NO, B.CLNT_NM, A.LIM_A, A.APRV_DT, A.MSG_CD, B.CELLPHONE, B.EMAIL FROM ACTIONS A, CLNT_INFO B WHERE A.CLNT_NO = B.CLNT_NO and B.CLNT_NO = ?";
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
	}

	public int userCheck(String id, String passwd){

		  Connection conn= null;
		  PreparedStatement pstmt = null;
		  ResultSet rs =null;
		  String url = "jdbc:oracle:thin:@localhost:1521:ORCL";
		  String sql="";
		  String dbpasswd="";
		  int x = -1;
		 
		 try{
		  conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
		  sql = "select passwd from MEMBER where id = ?";
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, id);
		  rs = pstmt.executeQuery();
		 
		    if(rs.next()){
		      dbpasswd =rs.getString("passwd");
		      
		      if(dbpasswd.equals(passwd))
		        x=1; //인증성공
		      else
		        x=0; //비밀번호 틀림
		      }else
		        
		      x=-1; //해당 아이디 없음

		 }catch(Exception e){
		 
		  e.printStackTrace();

		 }finally{
		  
		 }
		 
		 return x;
		 
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
