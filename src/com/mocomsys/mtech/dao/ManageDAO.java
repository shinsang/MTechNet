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

import com.mocomsys.mtech.vo.ManageVO;

/**
 * @author yungki
 *
 */
public class ManageDAO
{
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";
	
	Connection _conn = null;

    public ManageDAO()
    {
    	
    }
    public ArrayList<ManageVO> getTagAll()
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select distinct TAG_NAME,COUNT(*) as COUNT"
				+ " from TAG_INFO group by TAG_NAME order by COUNT desc";
		int count=0;
		try {
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);

			System.out.println(sql);
			rs = pstmt.executeQuery();
			ArrayList<ManageVO> alm=new ArrayList<ManageVO>();
			while (rs.next())
			{
				ManageVO mvo=new ManageVO(rs.getString("TAG_NAME"),rs.getInt("count")+"");
				alm.add(mvo);
			}
			
			pstmt.close();
			rs.close();
			return alm;
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
		return null;
    }
	public ArrayList<ManageVO> getTagByDate(String sDate,String eDate)
    {
    	PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select distinct TAG_NAME,COUNT(*) as COUNT"
				+ " from TAG_INFO "
				+ " where SUBSTR(TAGGING_INSERT_DATE,1,8) >= ?"
				+ " AND SUBSTR(TAGGING_INSERT_DATE,1,8) <= ? group by TAG_NAME order by count desc";
		int count=0;
		try {
			_conn = DriverManager.getConnection(url,"mocomsys","mocomsys");
			pstmt = _conn.prepareStatement(sql);

			pstmt.setString(1, sDate);
			pstmt.setString(2, eDate);
			System.out.println("value("+sDate+","+eDate+")//"+sql+"");
			rs = pstmt.executeQuery();
			ArrayList<ManageVO> alm=new ArrayList<ManageVO>();
			while (rs.next())
			{
				ManageVO mvo=new ManageVO(rs.getString("TAG_NAME"),rs.getInt("count")+"");
				alm.add(mvo);
			}
			
			pstmt.close();
			rs.close();
			return alm;
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
		return null;
    }
	private void ManageDAO() {
		// TODO Auto-generated method stub
		
	}
    
    
   
}
