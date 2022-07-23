package com.o7planning.example.servlet.listener;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.Date;

import javax.servlet.ServletContext;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


class UserThread extends Thread{
	String umail="";
	int day=0;
	UserThread(String umail,int day){
		 this.umail = umail;
		 this.day=day;
	}
	public void run() {

		//---------------------------------------------------CODECHEF------------------------------------------------------------
				
		String ccid="NA";
		int dccrating=0,dccfsp=0,dccpsp=0,dccgr=0,dcccr=0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			
			ResultSet rs = st.executeQuery("SELECT CODECHEFID, RATING, FULL_SOV, PAR_SOV, GLO_RANK, COU_RANK FROM CODECHEF WHERE UMAIL='"+umail+"' ");
			
			while(rs.next()){
				ccid = rs.getString("CODECHEFID");
				dccrating = Integer.parseInt(rs.getString("RATING"));
				dccfsp = Integer.parseInt(rs.getString("FULL_SOV"));
				dccpsp = Integer.parseInt(rs.getString("PAR_SOV"));
				dccgr = Integer.parseInt(rs.getString("GLO_RANK"));
				dcccr = Integer.parseInt(rs.getString("COU_RANK"));
			}
			
			
			
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(umail+"=->"+ccid);
	    String ccs = "https://www.codechef.com/users/"+ccid+"";
	    System.out.println(ccs);
		Document doc=null;
		try {
			doc = Jsoup.connect(ccs).get();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

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
				ccgr = Integer.valueOf(a.html());
			}
			else {
				cccr = Integer.valueOf(a.html());
			}
		}

		//---------------------------------------------------CODEFORCES------------------------------------------------------------
		
		int dcur_rat=0,dhig_rat=0,dsovprob=0;
		
		String cfid="NA";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT CODEFORCES, CUR_RATING, HIG_RATING, SOV_PROB FROM CODEFORCES WHERE UMAIL='"+ umail +"' ");
			
			while(rs.next()){
				cfid = rs.getString("CODEFORCES");
				dcur_rat = Integer.parseInt(rs.getString("CUR_RATING"));
				dhig_rat = Integer.parseInt(rs.getString("HIG_RATING"));
				dsovprob = Integer.parseInt(rs.getString("SOV_PROB"));
			}
			
			
			
		}catch (ClassNotFoundException cfe) {
			cfe.printStackTrace();
		}catch (SQLException cfe) {
			cfe.printStackTrace();
		}
			
	  	String cfurl ="https://codeforces.com/profile/"+cfid;
	  	System.out.println(cfid);
	  	Document cfdoc=null;
		try {
			cfdoc = Jsoup.connect(cfurl).get();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		Elements a = cfdoc.select("h1.long_handle a");
		Elements b = cfdoc.select("div._UserActivityFrame_counterValue");
		Elements c = cfdoc.select("span.user-gray");
		
		int sovprob=0,cur_rat=0,hig_rat=0;
		
		i=0;
		for(Element cfe: b) {
			if(i==0) {
			    String str = String.valueOf(cfe.html());
				sovprob = Integer.valueOf(str.substring(0,2));
			}
			else if(i==7) {
				cur_rat = Integer.valueOf(cfe.html());
			}else if(i==9) {
				hig_rat = Integer.valueOf(cfe.html());
			}
			i++;
		}
		i=0;
		for(Element cfe: c) {
			if(i==1) {
				cur_rat = Integer.valueOf(cfe.html());
			}else if(i==3) {
				hig_rat = Integer.valueOf(cfe.html());
			}
			i++;
		}
		
	//---------------------------------------------------------GFG ACTIVITY-------------------------------------------------------------------
		
		int dgfgcs=0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT CODING_SCOR FROM GFG WHERE UMAIL='"+ umail +"' ");
			rs.next();
			dgfgcs = Integer.parseInt(rs.getString("CODING_SCOR"));

		}catch (ClassNotFoundException cfe) {
			cfe.printStackTrace();
		}catch (SQLException cfe) {
			cfe.printStackTrace();
		}
		
		String gfgid="NA";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT GFGID FROM GFG WHERE UMAIL='"+umail+"' ");
			while(rs.next()){
				gfgid = rs.getString("GFGID");
			}
		}catch (ClassNotFoundException cfe) {
			cfe.printStackTrace();
		}catch (SQLException cfe) {
			cfe.printStackTrace();
		}
	  	
	  	String gfgs = "https://auth.geeksforgeeks.org/user/"+gfgid+"/practice/";

		System.out.println(gfgid);
	  	Document contest=null;
		try {
			contest = Jsoup.connect(gfgs).get();
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		Elements gfga = contest.select("div.mdl-grid div.mdl-cell.mdl-cell--6-col.mdl-cell--12-col-phone.textBold");
		Elements gfgb = contest.select("div.mdl-cell.mdl-cell--6-col.mdl-cell--12-col-phone a");
		Elements gfgc = contest.select("div.mdl-cell.mdl-cell--4-col.mdl-cell--12-col-phone.textBold span");
		j=0;
		int gfgcs=15,gfgps=0,gfgms=0;
		//System.out.println(a.html());
		for(Element gfge: gfga) {
			if(j==0) {
				String str = String.valueOf(gfge.html());
				gfgcs = Integer.valueOf(str.substring(34,str.length()));
				//System.out.println("Coding score : "+gfgcs);
			}
			j++;
		}
		String gfgss = String.valueOf(gfgb.html());
		System.out.println("Error"+gfgss);
		gfgps = Integer.valueOf(gfgss.substring(22,gfgss.length()));
		//System.out.println("Problems solved: "+gfgps);
		j=0;
		for(Element gfge: gfgc) {
			if(j++==0) {
				String str = String.valueOf(gfge.html());
				gfgms = Integer.valueOf(str);
				//System.out.println("Montly Streak: "+gfgms);
			}
		}
		
	//--------------------------------------------------INTERVIEWBIT ACTIVITY------------------------------------------
		
		int dibscore=0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT SCORE FROM INTERVIEWBIT WHERE UMAIL='"+ umail +"' ");
			rs.next();
			dibscore = Integer.parseInt(rs.getString("SCORE"));

		}catch (ClassNotFoundException cfe) {
			cfe.printStackTrace();
		}catch (SQLException cfe) {
			cfe.printStackTrace();
		}
		
		
		String ibid="NA";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT INTERVIEWBITID FROM INTERVIEWBIT WHERE UMAIL='"+umail+"' ");
			
			while(rs.next()){
				ibid = rs.getString("INTERVIEWBITID");
			}
		}catch (ClassNotFoundException cfe) {
			cfe.printStackTrace();
		}catch (SQLException cfe) {
			cfe.printStackTrace();
		}
		String iburl = "https://www.interviewbit.com/profile/"+ibid;
	  	Document ibcontest=null;
		try {
			ibcontest = Jsoup.connect(iburl).get();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		Elements iba = ibcontest.select("div.stat.pull-left div.txt");
		
		int ibrank=0,ibscore=0,ibstreak=0;
		i=0;
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
			//System.out.println("Interviewbit "+ibe.html());
			i++;
		}
		
		
		
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			
			//-----------------------------------------------ACTIVITY------------------------------------------------------------------
			int ccact =ccfsp-dccfsp;
			int cfact = sovprob-dsovprob;
			int gfgact = gfgcs-dgfgcs;
			int ibact = ibscore-dibscore;
			String days = "SAT"; 
			
			ResultSet rs = st.executeQuery("SELECT * FROM ACC WHERE UMAIL='"+umail+"' ");
			int sun=0,mon=0,tus=0,wed=0,thu=0,fri=0,sat=0;	
			rs.next();
			sun = Integer.parseInt(rs.getString("MON"));
			mon = Integer.parseInt(rs.getString("TUS"));
			tus = Integer.parseInt(rs.getString("WED"));
			wed = Integer.parseInt(rs.getString("THU"));
			thu = Integer.parseInt(rs.getString("FRI"));
			fri = Integer.parseInt(rs.getString("SAT"));
			sat = ccact;
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			int ccd = st.executeUpdate("UPDATE ACC SET SUN="+sun+", MON="+mon+",TUS="+tus+", WED="+wed+",THU="+thu+", FRI="+fri+",SAT="+sat+"  WHERE UMAIL='"+umail+"'");	
			if(ccd>0)
				System.out.println("Activity Updated Codechef");
			
			
			
			rs = st.executeQuery("SELECT * FROM ACF WHERE UMAIL='"+umail+"' ");
			rs.next();
			sun = Integer.parseInt(rs.getString("MON"));
			mon = Integer.parseInt(rs.getString("TUS"));
			tus = Integer.parseInt(rs.getString("WED"));
			wed = Integer.parseInt(rs.getString("THU"));
			thu = Integer.parseInt(rs.getString("FRI"));
			fri = Integer.parseInt(rs.getString("SAT"));
			sat = cfact;
			int cfd = st.executeUpdate("UPDATE ACF SET SUN='"+sun+"', MON='"+mon+"',TUS='"+tus+"', WED='"+wed+"',THU='"+thu+"', FRI='"+fri+"',SAT='"+sat+"'  WHERE UMAIL='"+umail+"'");	
			if(cfd>0)
				System.out.println("Activity Updated CodeForces");
			
			
			rs = st.executeQuery("SELECT * FROM AGFG WHERE UMAIL='"+umail+"' ");
			rs.next();
			sun = Integer.parseInt(rs.getString("MON"));
			mon = Integer.parseInt(rs.getString("TUS"));
			tus = Integer.parseInt(rs.getString("WED"));
			wed = Integer.parseInt(rs.getString("THU"));
			thu = Integer.parseInt(rs.getString("FRI"));
			fri = Integer.parseInt(rs.getString("SAT"));
			sat = gfgact;
			int gfgd = st.executeUpdate("UPDATE AGFG SET SUN='"+sun+"', MON='"+mon+"',TUS='"+tus+"', WED='"+wed+"',THU='"+thu+"', FRI='"+fri+"',SAT='"+sat+"'  WHERE UMAIL='"+umail+"' ");	
			if(gfgd>0)
				System.out.println("Activity Updated gfg");
			
			
			rs = st.executeQuery("SELECT * FROM AIB WHERE UMAIL='"+umail+"' ");
			rs.next();
			sun = Integer.parseInt(rs.getString("MON"));
			mon = Integer.parseInt(rs.getString("TUS"));
			tus = Integer.parseInt(rs.getString("WED"));
			wed = Integer.parseInt(rs.getString("THU"));
			thu = Integer.parseInt(rs.getString("FRI"));
			fri = Integer.parseInt(rs.getString("SAT"));
			sat = ibact;
			int ibd = st.executeUpdate("UPDATE AIB SET SUN='"+sun+"', MON='"+mon+"',TUS='"+tus+"', WED='"+wed+"',THU='"+thu+"', FRI='"+fri+"',SAT='"+sat+"' WHERE UMAIL='"+umail+"' ");	
			if(ibd>0)
				System.out.println("Activity Updated InterviewBit");
			/*if(day%7==1)
				days="MON";
			if(day%7==2)
				days="TUE";
			if(day%7==3)
				days="WED";
			if(day%7==4)
				days="THU";
			if(day%7==5)
				days="FRI";
			if(day%7==6)
				days="SAT";*/
			
			
			
		}

		catch (ClassNotFoundException exp) {
				exp.printStackTrace();
		}catch (SQLException exp) {
			exp.printStackTrace();
		}
		
		//---------------------------------------------------User Updates-------------------------------------------------------------------
		
				LocalDate today = LocalDate.now();
				String dd = today.toString();
				try {
					Class.forName("com.mysql.jdbc.Driver");
					Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
					Statement st = con.createStatement();
					
					//-----------------------------------------------CODECHEF UPDATION------------------------------------------------------------------
					
					if(dccrating!=ccrating || dccfsp!=ccfsp || dccpsp!=ccpsp || dccgr!=ccgr || dcccr!=cccr){
						int ccrs = st.executeUpdate("UPDATE CODECHEF SET RATING='"+ccrating+"', FULL_SOV='"+ccfsp+"', PAR_SOV='"+ccpsp+"', GLO_RANK='"+ccgr+"', COU_RANK='"+cccr+"' WHERE UMAIL='"+umail+"' ");	
						int ccd = st.executeUpdate("UPDATE ACTIVITY SET CC='"+dd+"' WHERE UMAIL='"+umail+"'");	
						if(ccrs>0){
							System.out.println("Codechef details updated successfully");
						}
					}
					
					//-----------------------------------------------CODEFORCES UPDATION------------------------------------------------------------------
					
					if(dcur_rat!=cur_rat || dhig_rat!=hig_rat || dsovprob!=sovprob){
						int cfrs = st.executeUpdate("UPDATE CODEFORCES SET CUR_RATING='"+cur_rat+"', HIG_RATING='"+hig_rat+"', SOV_PROB='"+sovprob+"' WHERE UMAIL='"+umail+"' ");
						int cfd = st.executeUpdate("UPDATE ACTIVITY SET CF='"+dd+"' WHERE UMAIL='"+umail+"'");	
						if(cfrs>0){
							System.out.println("Codeforces details updated successfully");
						}
					}
					
					
					//-----------------------------------------------INTERVIEWBIT UPDATION------------------------------------------------------------------
					
					
					int ibrs = st.executeUpdate("UPDATE INTERVIEWBIT SET STREAK='"+ibstreak+"', SCORE='"+ibscore+"', URANK='"+ibrank+"' WHERE UMAIL='"+umail+"' ");
					if(ibrs>0){
						System.out.println("INTEVIEWBIT details updated successfully");
					}
					
					
					//-----------------------------------------------GFG UPDATION------------------------------------------------------------------
					
					
					int rsgfg = st.executeUpdate("UPDATE GFG SET SOLVED_PROB='"+gfgps+"', CODING_SCOR='"+gfgcs+"', MON_STREAK='"+gfgms+"' WHERE UMAIL='"+umail+"' ");
					if(rsgfg>0){
						System.out.println("GFG details updated successfully");
					}
				}

				catch (ClassNotFoundException exp) {
						exp.printStackTrace();
				}catch (SQLException exp) {
					exp.printStackTrace();
				}
				
	}
}

class Call{
	
	public static void userCall(int day) {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
			Statement st = con.createStatement();
			ResultSet rss = st.executeQuery("SELECT COUNT(*) FROM USER ");
			rss.next();
			int n = rss.getInt(1);
			
			UserThread[] ut = new UserThread[n];
			
			
			ResultSet rs = st.executeQuery("SELECT UMAIL FROM USER ");
			String umail="";
			int i=0;
			System.out.println("Called");
			while(rs.next()){
				umail = rs.getString("UMAIL");
				
				ut[i] = new UserThread(umail,day);
				ut[i].start();
				System.out.println(i++);
				
			}
			
			
			
		}catch (ClassNotFoundException cfe) {
			cfe.printStackTrace();
		}catch (SQLException cfe) {
			cfe.printStackTrace();
		}
		
		
		
	}
}

public class SiteMapThread implements Runnable {

    private ServletContext context;

    public SiteMapThread(ServletContext context) {
        this.context = context;
    }

    @Override
    public void run() {
        do {
			try {
				Call c = new Call();
				int day=1;
				c.userCall(day);
				System.out.println("Nice ra");
				Thread.sleep(1000*60*60*24);
				day++;
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
    	}while(true);
    }

}