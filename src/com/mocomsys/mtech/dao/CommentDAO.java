/**
 *
 */
package com.mocomsys.mtech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import com.mocomsys.mtech.vo.CommentVO;

/**
 * @author shinsang
 *
 */
public class CommentDAO
{
	Connection _conn = null;

    public CommentDAO(Connection conn)
    {
    	this._conn = conn;
    }

    public ArrayList<CommentVO> getCommentList(String parents_contents_id){
//    	System.out.println("[CommentDAO] getCommentList ["+parents_contents_id+"]");
    	PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<CommentVO> arrList = new ArrayList<CommentVO>();
    	String sql = "SELECT * FROM COMMENT_INFO WHERE COMMENT_PARENTS_CONTENTS_ID=? ORDER BY COMMENT_REGIST_DATE ASC";

    	try {
 //   		System.out.println("- sql ["+sql+"]");
	    	pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, parents_contents_id);

			rs = pstmt.executeQuery();
			while (rs.next())
			{
				CommentVO cvo = new CommentVO();
				
				cvo.setParents_contents_id(rs.getString("COMMENT_PARENTS_CONTENTS_ID"));
				cvo.setId(rs.getString("COMMENT_ID"));
				cvo.setTitle(rs.getString("COMMENT_TITLE"));
				cvo.setRegist_user_id(rs.getString("COMMENT_REGIST_USER_ID"));
				cvo.setRegist_date(rs.getString("COMMENT_REGIST_DATE"));
				cvo.setReceive_user_id(rs.getString("COMMENT_RECEIVE_USER_ID"));
				cvo.setRefrence_user_id(rs.getString("COMMENT_REFRENCE_USER_ID"));
				cvo.setBody(rs.getString("COMMENT_BODY"));
				cvo.setAttach_file(rs.getString("COMMENT_ATTACH_FILE"));
				cvo.setSequence_num(rs.getString("COMMENT_SEQUENCE_NUM"));

				arrList.add(cvo);
			}
/*			for(int i = 0; i < arrList.size() ; i++){
				System.out.println("List["+i+"]"+arrList.get(i).getTitle());;
			}
*/		} catch (SQLException e) {
			System.out.println("getCommentList="+e.toString());
			StackTraceElement[] ste = e.getStackTrace();
			for (int i=0;i < ste.length; i++) {
				System.out.println(ste[i].toString());
			}
		} finally {
			try {if(pstmt!=null){pstmt.close();	}} catch (SQLException e) {	}
			try {if(rs!=null){rs.close();}} catch (SQLException e) { }
		}

	return arrList;
    }  

}
