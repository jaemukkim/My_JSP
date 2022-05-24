package sec02.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet ("/first001")  //변수 값 넘기기 
public class FirstServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		System.out.println("요청 확인됨.");
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter(); 
		
		 resp.sendRedirect("second001?name=lee&pwd=1234");   //서블릿을 요청시 다른 서블릿으로 이동  
		
		// resp.sendRedirect("index.jsp");	  // JSP 페이지로 이동 
		
	}
	

}
