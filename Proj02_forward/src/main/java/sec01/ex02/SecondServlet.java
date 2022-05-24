package sec01.ex02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/second02")    //response.addHead 를 통한 페이지 이동 
public class SecondServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter(); 
		
		out.print("<html><body>");
		out.print("http 헤더를 를 이용한 redirect 실습입니다.(response.addHead)");
		out.print("</body></html>"); 
		
		
	}
	
	
	

}
