package it.unibo.tw.web.servlets;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StillAServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	//variabili
	String homeURL="";
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	//risposte alle richieste GET
	@Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
    }

	//risposte alle richieste POST
	@Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	
	}
	
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
	throws ServletException, IOException {
		// tempo di attesa, qui inserito artificiosamente
		try {
			Thread.sleep(5000);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		// un altro forward eseguito lato servlet
		req.getRequestDispatcher(homeURL).forward(req, resp);
	}
	
	
	
}
