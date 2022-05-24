package sec01.ex03;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet ("/first03")    //location.href 를 사용한 페이지 이동 
public class FirstServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		System.out.println("요청 확인됨.");
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter(); 
		
		// resp.sendRedirect("second");   //서블릿을 요청시 다른 서블릿으로 이동  
		
		// resp.sendRedirect("index.jsp");	  // JSP 페이지로 이동 
		
		//resp.addHeader("Refresh", "5;url=second02"); 
		//resp.addHeader("Refresh", "5;url=index.jsp"); 
		
		
		/*
		out.print("<script type = 'text/javascript'>");
		out.print("location.href = 'second03';");
		out.print("</script>"); 
		*/
		
		out.print("<script type = 'text/javascript'>");
		out.print("location.href = 'index.jsp';");
		out.print("</script>"); 
		
		
		
	}
	

}
