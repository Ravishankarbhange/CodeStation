package com.code.dao;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import javax.servlet.http.Cookie;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.code.beans.Platform;

public class PlatformDao {
	public void actStatus(String umail) {
		LocalDate today = LocalDate.now();
		LocalDate back = today.plusDays(-9);
		String dd = back.toString();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int csrs = st.executeUpdate("INSERT INTO ACTIVITY VALUES('"+umail+"','"+dd+"','"+dd+"') ");
			if(csrs>0){
				System.out.println("CODESTATION details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}

	}
	public void updateCc(Platform pf, String umail) throws IOException {
		String ccid=pf.getCc();
		System.out.println(ccid);
		String s = "https://www.codechef.com/users/"+ccid+"";
  		Document doc = Jsoup.connect(s).get();

  		int ccrating,ccfsp=0,ccpsp=0,ccgr=0,cccr=0;

  		Elements e = doc.select("div.rating-number");
		ccrating = Integer.valueOf(e.html());
		
		
		Elements ee = doc.select("section.rating-data-section.problems-solved div.content h5");
		int j=0;
		for(Element a: ee) {
			if(j++==0) {
				String str = String.valueOf(a.html());
				ccfsp = Integer.valueOf(str.substring(14,str.length()-1));
			}
			else {
				String str = String.valueOf(a.html());
				ccpsp = Integer.valueOf(str.substring(18,str.length()-1));
			}
		}
		
		Elements eee = doc.select("div.rating-ranks ul li a strong");
		int i=0;
		for(Element a: eee) {
			if(i++==0) {
				String str = String.valueOf(a.html());
				if(!str.equals("Inactive"))
					ccgr = Integer.valueOf(a.html());
			}
			else {
				String str = String.valueOf(a.html());
				if(!str.equals("Inactive"))
					cccr = Integer.valueOf(a.html());
			}
		}
  		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int rs = st.executeUpdate("INSERT INTO CODECHEF VALUES('"+ccid+"','"+umail+"','"+ccrating+"','"+ccfsp+"','"+ccpsp+"','"+ccgr+"','"+cccr+"')");
			
			if(rs>0){
				System.out.println("Codechef details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}

	}
	public void updateCf(Platform pf, String umail) throws IOException {
		String cfid = pf.getCf();
		String cfurl ="https://codeforces.com/profile/"+cfid;
	  	System.out.println(cfid);
	  	Document cfdoc = Jsoup.connect(cfurl).get();
		//Elements a = cfdoc.select("h1.long_handle a");
		Elements b = cfdoc.select("div._UserActivityFrame_counterValue");
		Elements c = cfdoc.select("span.user-gray");
		
		//System.out.println("A------------"+a);

		System.out.println("B------------"+b);

		System.out.println("C------------"+c);
		int sovprob=0,cur_rat=0,hig_rat=0;
		
		int i=0;
		for(Element cfe: b) {
			if(i==0) {
			    String str = String.valueOf(cfe.html());
			    System.out.println(str);
				sovprob = Integer.valueOf(str.substring(0,str.length()-9));
				System.out.println("Sov prob");
			}
			else if(i==7) {
				cur_rat = Integer.valueOf(cfe.html());
			}else if(i==9) {
				hig_rat = Integer.valueOf(cfe.html());
			}
			i++;
		}
		System.out.println("Ratings");
		i=0;
		for(Element cfe: c) {
			if(i==1) {
				cur_rat = Integer.valueOf(cfe.html());
			}else if(i==3) {
				hig_rat = Integer.valueOf(cfe.html());
			}
			i++;
		}
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int rs = st.executeUpdate("INSERT INTO CODEFORCES VALUES('"+cfid+"','"+umail+"','"+cur_rat+"','"+hig_rat+"','"+sovprob+"')");
			
			if(rs>0){
				System.out.println("Codeforces details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}

	}
	public void updateGfg(Platform pf, String umail) throws IOException {
		
		String gfgid=pf.getGfg();
		String gfgs = "https://auth.geeksforgeeks.org/user/"+gfgid+"/practice/";

		System.out.println(gfgid);
	  	Document contest = Jsoup.connect(gfgs).get();
		Elements gfga = contest.select("div.mdl-grid div.mdl-cell.mdl-cell--6-col.mdl-cell--12-col-phone.textBold");
		Elements gfgb = contest.select("div.mdl-cell.mdl-cell--6-col.mdl-cell--12-col-phone a");
		Elements gfgc = contest.select("div.mdl-cell.mdl-cell--4-col.mdl-cell--12-col-phone.textBold span");
		int j=0;
		int gfgcs=15,gfgps=0,gfgms=0;
		//System.out.println(a.html());
		for(Element gfge: gfga) {
			if(j==0) {
				String str = String.valueOf(gfge.html());
				gfgcs = Integer.valueOf(str.substring(34,str.length()));
				System.out.println("Coding score : "+gfgcs);
			}
			j++;
		}
		if(gfgcs!=0) {
			String gfgss = String.valueOf(gfgb.html());
			System.out.println(gfgb.html());
			gfgps = Integer.valueOf(gfgss.substring(22,gfgss.length()));
			System.out.println("Problems solved: "+gfgps);
		}
		j=0;
		for(Element gfge: gfgc) {
			if(j++==0) {
				String str = String.valueOf(gfge.html());
				gfgms = Integer.valueOf(str);
				System.out.println("Montly Streak: "+gfgms);
			}
		}
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int rs = st.executeUpdate("INSERT INTO GFG VALUES('"+gfgid+"','"+umail+"','"+gfgps+"','"+gfgcs+"','"+gfgms+"')");
			
			if(rs>0){
				System.out.println("GFG details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}
	}
	public void updateIb(Platform pf, String umail) throws IOException {
		String ibid = pf.getIb();
		String iburl = "https://www.interviewbit.com/profile/"+ibid;
	  	Document ibcontest = Jsoup.connect(iburl).get();
		Elements iba = ibcontest.select("div.stat.pull-left div.txt");
		
		int ibrank=0,ibscore=0,ibstreak=0;
		int i=0;
		for(Element ibe: iba) {
			if(i==0) {
				ibrank = Integer.valueOf(ibe.html());
			}
			else if(i==1) {
				ibscore = Integer.valueOf(ibe.html());
			}else if(i==2) {
				String str = String.valueOf(ibe.html());
				ibstreak = Integer.valueOf(str.substring(0,1));
			}
			System.out.println("Interviewbit "+ibe.html());
			i++;
		}
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int rs = st.executeUpdate("INSERT INTO INTERVIEWBIT VALUES('"+ibid+"','"+umail+"','"+ibstreak+"','"+ibscore+"','"+ibrank+"')");
			
			if(rs>0){
				System.out.println("INTEVIEWBIT details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}
	}
	public void updateAct(String umail) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int acc = st.executeUpdate("INSERT INTO ACC VALUES('"+umail+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"') ");
			if(acc>0){
				System.out.println("CODECHEF ACTIVITY details updated successfully");
			}
			int acf = st.executeUpdate("INSERT INTO ACF VALUES('"+umail+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"') ");
			if(acf>0){
				System.out.println("CODEFORCES ACTIVITY details updated successfully");
			}
			int agfg = st.executeUpdate("INSERT INTO AGFG VALUES('"+umail+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"') ");
			if(agfg>0){
				System.out.println("GFG ACTIVITY details updated successfully");
			}
			int aib = st.executeUpdate("INSERT INTO AIB VALUES('"+umail+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"','"+0+"') ");
			if(aib>0){
				System.out.println("IB ACTIVITY details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}

	}
	public void updateCs(Platform pf, String umail) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			int csrs = st.executeUpdate("INSERT INTO CODESTATION VALUES('"+umail+"','"+0+"','"+0+"') ");
			if(csrs>0){
				System.out.println("CODESTATION details updated successfully");
			}
	
		}catch (ClassNotFoundException exp) {
			exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}
	}

}