package com.code.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.code.beans.User;
import com.code.dao.UserDao;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String mail = request.getParameter("email");
		String userid = request.getParameter("userid");
		String password =request.getParameter("pass");
		String cpassword =request.getParameter("cpass");
		String institute = request.getParameter("insti");
		
		User user = new User();
		user.setInstitute(institute);
		user.setPassword(password);
		user.setUid(userid);
		user.setUmail(mail);
		user.setUname(name);
		
		UserDao ud = new UserDao();
		int sol = ud.registerUser(user);
		
		Cookie uiColorCookie = new Cookie("umail", mail);
		response.addCookie(uiColorCookie);
		
		System.out.println("Cookiee created for register"+mail);
		
		response.sendRedirect("myaccount.jsp");
	}

}
