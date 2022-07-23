package com.code.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.code.beans.Userlogin;

public class UserLoginDao {
	public static boolean loginUser(Userlogin user) {
        boolean status=false;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
					
			PreparedStatement ps=con.prepareStatement("select * from user where umail=? and password=?");  
			ps.setString(1,user.getUmail());  
			ps.setString(2,user.getPassword());  
					      
			ResultSet rs=ps.executeQuery();  
			status=rs.next(); 
					
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 

		return status;
	}

}
