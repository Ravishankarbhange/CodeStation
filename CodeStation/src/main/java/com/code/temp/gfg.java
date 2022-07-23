package com.code.temp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class gfg {

	public static void main(String[] args) throws IOException {
		String umail="meghana@gmail.com";
		String cfid = "maggi12meghana";
		String cfurl ="https://codeforces.com/profile/"+cfid;
	  	System.out.println(cfid);
	  	Document cfdoc = Jsoup.connect(cfurl).get();
		//Elements a = cfdoc.select("h1.long_handle a");
		Elements b = cfdoc.select("div._UserActivityFrame_counterValue");
		Elements c = cfdoc.select("span.user-gray");
		
		//System.out.println("A------------"+a);

		//System.out.println("B------------"+b);

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

}
