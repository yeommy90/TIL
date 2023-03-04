package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBCConnect {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	public JDBCConnect() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "musthave";
			String pwd = "1234";
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(기본 생성자)");
		} catch (Exception e) {
			e.toString();
		}
	}
	
	public JDBCConnect(String driver, String url, String id, String pw) {
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, id, pw);
			
			System.out.println("DB 연결 성공(기본 생성자2)");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public JDBCConnect(ServletContext application) {
		try {
			Class.forName(application.getInitParameter("OracleDriver"));
			
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pw = application.getInitParameter("OraclePwd");
			con = DriverManager.getConnection(url, id, pw);
			
			System.out.println("DB 연결 성공(기본 생성자3)");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public void close() {
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (psmt != null) psmt.close();
			if (con != null) con.close();
			
			System.out.println("JDBC 자원 해제!");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	
}
