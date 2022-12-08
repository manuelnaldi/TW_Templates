package it;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.Utente;


public class Login extends HttpServlet{

    private static final long serialVersionUID = 1L;
    //private static List<String> gruppi;


    @Override
    public void init(ServletConfig conf) throws ServletException {
        super.init(conf);
        List<Utente> utenti=new ArrayList<>();

        //gruppi=Arrays.asList(new String[]{"group1", "group2", "group3"});

        Utente a=new Utente();
        a.setUsername("admin");
        a.setPassword("admin");
        utenti.add(a);

        Utente b=new Utente();
        b.setUsername("utente1");
        b.setPassword("utente1");
        utenti.add(b);

        Utente c=new Utente();
        c.setUsername("utente2");
        c.setPassword("utente2");
        utenti.add(c);

        Utente d=new Utente();
        d.setUsername("utente3");
        d.setPassword("utente3");
        utenti.add(d);

        //inserisco gli utente nel context application
        ServletContext application = getServletContext();
        application.setAttribute("utenti", utenti);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, NumberFormatException {

        String u=req.getParameter("username");
        String p=req.getParameter("password");
        String g=req.getParameter("group");
        System.out.println("Ricevuto login da: "+u+" "+p);


        //admin
        if (u.equals("admin") && p.equals("admin")) {
            req.getSession().setAttribute("admin", true);
            resp.sendRedirect(req.getContextPath()+"/admin.jsp?username=admin&password=admin");
        }else {


            ServletContext application = getServletContext();
            if (application.getAttribute("utenti") == null) {
                System.out.println("Errore utenti non presenti");
            }

            List<Utente> utenti = (List<Utente>) application.getAttribute("utenti");


            for (int i = 0; i < utenti.size(); i++) {
                System.out.println("Utente: " + utenti.get(i).getUsername() + " " + utenti.get(i).getPassword());
                if (utenti.get(i).getUsername().equals(u) && utenti.get(i).getPassword().equals(p) /* && gruppi.contains(g)*/) {
                    if(utenti.get(i).getGroup().equals("")){
                        //Setto il gruppo se non lo ha
                        utenti.get(i).setGroup(g);
                    }
                    utenti.get(i).setSession(req.getSession());
                    req.getSession().setAttribute("username", utenti.get(i).getUsername());
                    req.getSession().setAttribute("logged", true);

                    application.setAttribute("utenti", utenti);
                    getServletContext().getRequestDispatcher("/index.jsp").forward(req,resp);
                }
            }
            resp.sendRedirect(req.getContextPath() + "/loginFailure.jsp?err=login");
        }
    }


}
