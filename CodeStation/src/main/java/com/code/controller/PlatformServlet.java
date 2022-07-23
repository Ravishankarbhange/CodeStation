package com.code.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.code.beans.Platform;
import com.code.beans.User;
import com.code.dao.PlatformDao;
import com.code.dao.UserDao;

@WebServlet("/PlatformServlet")
public class PlatformServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PlatformServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String he = request.getParameter("he");
		String cc = request.getParameter("cc");
		String cf = request.getParameter("cf");
		String gfg =request.getParameter("gfg");
		String ib =request.getParameter("ib");
		String lc = request.getParameter("lc");
		
		System.out.println(he);
		System.out.println(cc);
		System.out.println(cf);
		System.out.println(gfg);
		System.out.println(ib);
		System.out.println(lc);
		
		
		Cookie[] cookies = null;
  		cookies = request.getCookies();
  		String umail="";
  		for(Cookie c: cookies){
  	  		if(c.getName().equals("umail")){
  	  			umail = c.getValue();
  	  			System.out.println("MAIL: "+umail);
  	  		}
  		}
		
		Platform pf = new Platform();
		System.out.println(cc);
		pf.setCc(cc);
		pf.setCf(cf);
		pf.setGfg(gfg);
		pf.setHe(he);
		pf.setIb(ib);
		pf.setLc(lc);

		System.out.println("All Profiles Initiated");
		
		PlatformDao pfd = new PlatformDao();
		pfd.updateCc(pf,umail);
		System.out.println("Codechef completed");
		
		pfd.updateCf(pf,umail);
		System.out.println("Codeforces completed");
		
		pfd.updateGfg(pf,umail);
		System.out.println("GFG completed");
		
		pfd.updateIb(pf,umail);
		System.out.println("Interviewbit completed");
		
		pfd.updateCs(pf, umail);
		System.out.println("All Profiles Updated");

		pfd.updateAct(umail);
		System.out.println("Activity completed");
		
		pfd.actStatus(umail);
		System.out.println("Dates completed");
		response.sendRedirect("dashboard.jsp");
	}

}
