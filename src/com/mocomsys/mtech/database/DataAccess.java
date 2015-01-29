/**
 *
 */
package com.mocomsys.mtech.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author shinsang
 *
 */
public class DataAccess {
	private static String DERBY = "org.apache.derby.jdbc.ClientDriver";
	private static String ORACLE = "oracle.jdbc.driver.OracleDriver";
	private static String MYSQL = "org.gjt.mm.mysql.Driver";
	private static String CUBRID = "cubrid.jdbc.driver.CUBRIDDriver";
	private static String MSSQL = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String DB2 = "COM.ibm.db2.jdbc.app.DB2Driver";
	private static String SYBASE = "com.sybase.jdbc.SybDriver";

	private static Connection _connection;
	private String _connectionString;
	private String _driverName;
	private String _ip;
	private String _port;
	private String _dbName;
	private String _user;
	private String _password;

	protected String TABLENAME = null;

	public DataAccess() {

	}

	/**
	 * parameter�뿉�꽌 諛쏆�� (driverName, dbName, IP, PORT, User, Password) 媛믪쓣 initDBMS�뿉 set �븳�떎.
	 * @param driverName
	 * @param dbName
	 * @param ip
	 * @param port
	 * @param user
	 * @param password
	 */
	public void setDBProperty(String driverName, String dbName, String ip, String port, String user, String password) {
		this.initDBMS(driverName, dbName, ip, port, user, password);
		// this.initDBMS("ORACLE", "dtt", "10.10.10.4", "1521", "dtt", "dtt");
	}
	public void setDBProperty(){
//		this.initDBMS("ORACLE", "orcl", "127.0.0.1", "1521", "mi", "mi");
		this.initDBMS("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
	}

	/**
	 * parameter�뿉�꽌 諛쏆�� (driverName, dbName, IP, PORT, User, Password) 媛믪쓣 setting �븳�떎.
	 * @param driverName
	 * @param dbName
	 * @param ip
	 * @param port
	 * @param user
	 * @param password
	 */
	private void initDBMS(String driverName, String dbName, String ip, String port, String user, String password) {
		_driverName = driverName;
		_dbName = dbName;
		_ip = ip;
		_port = port;
		_user = user;
		_password = password;
	}

	/**
	 * connection string 媛믪쓣 諛섑솚�븳�떎.
	 * @return
	 */
	public String getConnectionString() {
		return _connectionString;
	}

	/**
	 * connectionString 媛믪쓣 set �븳�떎.
	 * @param connectionString
	 */
	public void setConnectionString(String connectionString) {
		_connectionString = connectionString;
	}

	/**
	 * Connection Handle 媛믪쓣 諛섑솚�븳�떎.
	 * @return
	 */
	public Connection getConnection() {
		return _connection;
	}

	/**
	 * Connection Handler 媛믪쓣 set �븳�떎.
	 * @param connection
	 */
	public void setConnection(Connection connection) {
		_connection = connection;
	}

	/**
	 * IP 媛믪쓣 諛섑솚�븳�떎.
	 * @return
	 */
	public String getIp() {
		return _ip;
	}

	/**
	 * IP 媛믪쓣 set �븳�떎.
	 * @param ip
	 */
	public void setIp(String ip) {
		_ip = ip;
	}

	/**
	 * Port 媛믪쓣 諛섑솚�븳�떎.
	 * @return
	 */
	public String getPort() {
		return _port;
	}

	/**
	 * Port 媛믪쓣 set �븳�떎.
	 * @param port
	 */
	public void setPort(String port) {
		_port = port;
	}

	/**
	 * DB �씠由꾩쓣 諛섑솚�븳�떎.
	 * @return
	 */
	public String getDBName() {
		return _dbName;
	}

	/**
	 * DB Name�쓣 set �븳�떎.
	 * @param dbName
	 */
	public void setDBName(String dbName) {
		_dbName = dbName;
	}

	/**
	 * User 瑜� 諛섑솚�븳�떎.
	 * @return
	 */
	public String getUser() {
		return _user;
	}

	/**
	 * User 瑜� set �븳�떎.
	 * @param user
	 */
	public void setUser(String user) {
		_user = user;
	}

	/**
	 * Password瑜� 諛섑솚�븳�떎.
	 * @return
	 */
	public String getPassword() {
		return _password;
	}

	/**
	 * Password瑜� set �븳�떎.
	 * @param password
	 */
	public void setPassword(String password) {
		_password = password;
	}

	/**
	 * JDBC connection�쓣 �깮�꽦�븳�떎.
	 */
	public void connectionJDBC() {
		String classDriver = "";
		String url = "";
		try {
			//System.out.println("connection JDBC");
			classDriver = setJDBCDriverName(_driverName);
			//System.out.println("classDriver = "+ classDriver);
			url = setUrlJDBC(_driverName, _dbName);
			//System.out.println("url = " +url);
			Class.forName(classDriver);
			//System.out.println("Connection start");
			_connection = DriverManager.getConnection(url, _user, _password);
			//System.out.println("DB Connection start success");
		} catch (SQLException e) {

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 * JDBC connection�쓣 close �븳�떎.
	 */
	public void closeConnection() {
		try {
			_connection.close();
		} catch (SQLException e) {

		}
	}

	/**
	 * connection�쓣 commit�븳�떎.
	 */
	public void commitConnection() {
		try {
			_connection.commit();
		} catch (SQLException e) {

		}
	}

	/**
	 * Driver Name�뿉 �뵲�씪 JDBC drivername�쓣 �깮�꽦�븳�떎.
	 * @param driverName
	 * @return
	 */
	private String setJDBCDriverName(String driverName) {
		String classDriver = "";
		if (driverName.equals("ORACLE"))
			classDriver = ORACLE;
		else if (driverName.equals("MYSQL"))
			classDriver = MYSQL;
		else if (driverName.equals("DB2"))
			classDriver = DB2;
		else if (driverName.equals("MSSQL"))
			classDriver = MSSQL;
		else if (driverName.equals("SYBASE"))
			classDriver = SYBASE;
		else if (driverName.equals("CUBRID"))
			classDriver = CUBRID;
		else if (driverName.equals("DERBY"))
			classDriver = DERBY;
		return classDriver;
	}

	/**
	 * driver Name, dbName, IP, Port瑜� 媛�吏�怨� connection String�쓣 �깮�꽦�빐 �궦�떎.
	 * @param driverName
	 * @param dbName
	 * @return
	 */
	private String setUrlJDBC(String driverName, String dbName) {
		StringBuilder sb = new StringBuilder();

		if (driverName.equals("ORACLE")) {
			sb.append("jdbc:oracle:thin:@");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append(":");
			sb.append(dbName);
		} else if (driverName.equals("MYSQL")) {
			sb.append("jdbc:mysql://");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append("/");
			sb.append(dbName);

		} else if (driverName.equals("MSSQL")) {
			sb.append("jdbc:sqlserver://");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append(";DatabaseName=");
			sb.append(dbName);
		} else if (driverName.equals("DB2")) {
			sb.append("jdbc:db2//");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append("/");
			sb.append(dbName);
		} else if (driverName.equals("CUBRID")) {
			sb.append("jdbc:CUBRID:");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append(":");
			sb.append(dbName);
			sb.append(":::");
		} else if (driverName.equals("SYBASE")) {
			sb.append("jdbc:jtds:sybase://");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append("/");
			sb.append(dbName);
		} else if (driverName.equals("DERBY")) {
			sb.append("jdbc:derby://");
			sb.append(_ip);
			sb.append(":");
			sb.append(_port);
			sb.append("/");
			//sb.append(DERBY_REPOSITORY);
			sb.append(dbName);
			sb.append(";create=false;");
			//sb.append("user=" + _user + ";");
			//sb.append("password=" + _password + ";");
			//sb.append(_dbU)
		}

		//System.out.println(sb.toString());
		return sb.toString();
	}

}
