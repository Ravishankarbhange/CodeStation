package com.code.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.code.beans.Userlogin;
import com.code.dao.UserLoginDao;

/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginServlet() {
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
		String mail = request.getParameter("email");
		String password =request.getParameter("pass");
		
		Userlogin user = new Userlogin();
		user.setPassword(password);
		user.setUmail(mail);
		
		UserLoginDao ud = new UserLoginDao();
		boolean sol = ud.loginUser(user);
		if(sol==true) {
			Cookie uiColorCookie = new Cookie("umail", mail);
			response.addCookie(uiColorCookie);
			System.out.println("Cookie Created"+mail);
			response.sendRedirect("dashboard.jsp");
		}else {
			System.out.println("Login");
			response.sendRedirect("login.jsp");
		}
	}

}
