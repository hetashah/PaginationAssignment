package servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DatabaseConnection {
	
	Connection con = null;
	Statement st=null;
	ResultSet rs =null;
	PreparedStatement ps=null;
	ArrayList<NewsPojo> nlist;
	
	public void connect()
	{
		//Connection con = null;
		
		String url="jdbc:mysql://localhost/login";
		String username="root";
		String password="heta";
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to a Selected Database");
			con= DriverManager.getConnection(url, username, password);
			System.out.println("Connected Database Successfully");
			System.out.println("Connection: " + con);
			
			//System.out.println("Connection: " + rs);
		}
		catch(ClassNotFoundException c)
		{
			System.out.println("Add jar file in your classpath and make it exist in web-app/lib folder too");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	public ArrayList<NewsPojo> getDataFromArticle(String statename)
	{
		nlist = new ArrayList<NewsPojo>();
		NewsPojo newsrow;
		System.out.println("bEFORE QUERY");
		String query="select s.statename,s.statecode,s.description,n.newsdescription,n.newssourcelink from states s,newsresults n where s.statecode = n.statecode and s.statecode = (select statecode from states where statename = '"+ statename +"')";
		//String query="select s.statename,s.statecode,s.description,n.newsdescription,n.newssourcelink from states s,newsresults n where s.statecode = n.statecode and s.statename = 'California'";
		System.out.println(query);

		try{
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		
		while(rs.next())
			{
			//System.out.println("Inside database next");
			newsrow = new NewsPojo();
			newsrow.setStatename(rs.getString("statename"));
			newsrow.setStatecode(rs.getString("statecode"));
			newsrow.setStatedescription(rs.getString("description"));
			newsrow.setNewsdescription(rs.getString("newsdescription"));
			newsrow.setNewssourcelink(rs.getString("newssourcelink"));
			nlist.add(newsrow);
			//String fname = rs.getString("user_fname");
			//System.out.println(article_name);
			}
		System.out.println(nlist.get(0).getNewssourcelink());
		
		
		/*String json = new Gson().toJson(alist);
		System.out.println("jsson" + json);*/
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return nlist;
	}
	
	

}
