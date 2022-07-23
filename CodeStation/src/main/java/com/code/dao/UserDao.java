package com.code.dao;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.code.beans.*;

public class UserDao {

	public int registerUser(User user)throws IOException{
		int result=0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
					
					PreparedStatement st=con.prepareStatement("insert into user values(?,?,?,?,?)");  
					st.setString(1,user.getUid());
					st.setString(2,user.getUname());
					st.setString(3,user.getUmail());
					st.setString(4,user.getInstitute());
					st.setString(5,user.getPassword());
			result = st.executeUpdate();
					
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return result;
	}
}