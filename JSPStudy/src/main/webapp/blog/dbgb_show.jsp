<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<HTML>
<HEAD><TITLE>�Խ���</TITLE>
<link href="freeboard.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript">
 
</SCRIPT>
</HEAD>
<BODY>
<%@ include file = "dbconn_oracle.jsp" %>

 <%   //vector : ��Ƽ������ ȯ�濡�� ���, ��� �޼ҵ尡 ����ȭ ó���Ǿ� ����.
 
  Vector name=new Vector();			//DB�� Name ���� �����ϴ� ����
  Vector inputdate=new Vector();	//DB�� inputdate ���� �����ϴ� ����
  Vector email=new Vector();
  Vector subject=new Vector();
  Vector rcount=new Vector();
  

  
  
  //����¡ ó�� ���� �κ�
  
  
  int where=1;

  int totalgroup=0;					//����� ����¡�� �׷����� �ִ� ����,
  int maxpages=3;					//�ִ� ������ ���� (ȭ�鿡 ��µ� ������)
  int startpage=1;					//ó�� ������
  int endpage=startpage+maxpages-1;	//������ ������ 
  int wheregroup=1;					//���� ��ġ�ϴ� �׷�
  
  if (request.getParameter("go") != null) {		//go ������ ���� ������ ������
   where = Integer.parseInt(request.getParameter("go"));	//���� ������ ��ȣ�� ���� ����
   wheregroup = (where-1)/maxpages + 1;		//���� ��ġ�� �������� �׷�
   startpage=(wheregroup-1) * maxpages+1;  
   endpage=startpage+maxpages-1; 
   
   //gogroup ������ �Ѱ� �޾Ƽ� startpage,endpage,where (������ �׷��� ù��° ������)
  } else if (request.getParameter("gogroup") != null) {	 //gogroup ������ ���� ������ �ö�
   wheregroup = Integer.parseInt(request.getParameter("gogroup")); 
   startpage=(wheregroup-1) * maxpages+1;    
   where = startpage ; 
   endpage=startpage+maxpages-1; 
  }
  
  
  
  int nextgroup=wheregroup+1;		//���� �׷� : ���� �׷� + 1
  int priorgroup= wheregroup-1;		//���� �׷� : ���� �׷� - 1  

  int nextpage=where+1;			//���������� : ���������� + 1
  int priorpage = where-1;		//���������� : ���������� - 1
  int startrow=0;		//DataBase���� Select �� ���ڵ� ���� ��ȣ
  int endrow=0;			//DataBase���� Select �� ���ڵ� ������ ��ȣ
  int maxrows=3;		//����� ���ڵ� ��
  int totalrows=0;		//�� ���ڵ� ����
  int totalpages=0;		//�� ������ ����
  
  /*
  out.println("==== maxpage : 3 �϶� =====" + "<p>");
  out.println("���� ������ : " + where + "<p>");
  out.println("���� ������ �׷� : " + wheregroup + "<p>");
  out.println("���� ������ : " + startpage + "<p>");
  out.println("�� ������  : " + endpage + "<p>");
  //if (true) return;
  */
  
  
  
	
  // ����¡ ó�� ������ �κ�
  
  
  int id=0;

  String em=null;
  //Connection con= null;
  Statement st =null;
  ResultSet rs =null;


 try {
  st = conn.createStatement();
  String sql = "select * from guestboard order by name" ;
  rs = st.executeQuery(sql);
  
  // out.println(sql);
   //if(true) return;	//���α׷� ����

  if (!(rs.next()))  {
   out.println("�Խ��ǿ� �ø� ���� �����ϴ�");
  } else {
   do {
	   //DataBase�� ���� �����ͼ� ������ vector�� ����	   

    					// rs�� id�÷��� ���� ���� �ͼ� vector�� ����
    name.addElement(rs.getString("name"));
    email.addElement(rs.getString("email"));
    String idate = rs.getString("inputdate");
    idate = idate.substring(0,8);
    inputdate.addElement(idate);
    subject.addElement(rs.getString("subject"));

   }while(!rs.next());
   em = rs.getString("name");
   
   out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
   out.println("<tr>");
   out.println("<td height='22'>&nbsp;</td></tr>");
   out.println("<tr align='center'>");
   out.println("<td height='1' bgcolor='#1F4F8F'></td>");
   out.println("</tr>");
   out.println("<tr align='center' bgcolor='#DFEDFF'>");
   out.println("<td class='button' bgcolor='#DFEDFF'>"); 
   out.println("<div align='left'><font size='2'>"+rs.getString("subject") + "</div> </td>");
   out.println("</tr>");
   out.println("<tr align='center' bgcolor='#FFFFFF'>");
   out.println("<td align='center' bgcolor='#F4F4F4'>"); 
   out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
   out.println("<tr bgcolor='#F4F4F4'>");
   out.println("<td width='13%' height='7'></td>");
   out.println("<td width='51%' height='7'>�۾��� : "+ em +"</td>");
   out.println("<td width='25%' height='7'></td>");
   out.println("<td width='11%' height='7'></td>");
   out.println("</tr>");
   out.println("<tr bgcolor='#F4F4F4'>");
   out.println("<td width='13%'></td>");
   out.println("<td width='51%'>�ۼ��� : " + rs.getString("inputdate") + "</td>");
   out.println("<td width='11%'></td>");
   out.println("</tr>");
   out.println("</table>");
   out.println("</td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td style='padding:10 0 0 0'>");
   out.println("<div align='left'><br>");
   out.println("<font size='3' color='#333333'><PRE>"+rs.getString("content") + "</PRE></div>");
   out.println("<br>");
   out.println("</td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td class='button' height='1'></td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
   out.println("</tr>");
   out.println("</table>");
   
   
   
   totalrows = name.size();					//name vector�� ����� ���� ����, �� ���ڵ��
   totalpages = (totalrows-1)/maxrows +1;	
   startrow = (where-1) * maxrows;			// ���� ���������� ���� ���ڵ� ��ȣ
   endrow = startrow+maxrows-1  ;			// ���� �������� ������ ���ڵ� ��ȣ

   
   if (endrow >= totalrows)		
    endrow=totalrows-1;
  
   totalgroup = (totalpages-1)/maxpages +1; 	//�������� �׷���
   
   
   if (endpage > totalpages) 
    endpage=totalpages;
   
   
   do {
	   //DataBase�� ���� �����ͼ� ������ vector�� ����	   

    					// rs�� id�÷��� ���� ���� �ͼ� vector�� ����
    name.addElement(rs.getString("name"));
    email.addElement(rs.getString("email"));
    String idate = rs.getString("inputdate");
    idate = idate.substring(0,8);
    inputdate.addElement(idate);
    subject.addElement(rs.getString("subject"));
    
    

   }while(!rs.next());
   em = rs.getString("name");
   
   out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
   out.println("<tr>");
   out.println("<td height='22'>&nbsp;</td></tr>");
   out.println("<tr align='center'>");
   out.println("<td height='1' bgcolor='#1F4F8F'></td>");
   out.println("</tr>");
   out.println("<tr align='center' bgcolor='#DFEDFF'>");
   out.println("<td class='button' bgcolor='#DFEDFF'>"); 
   out.println("<div align='left'><font size='2'>"+rs.getString("subject") + "</div> </td>");
   out.println("</tr>");
   out.println("<tr align='center' bgcolor='#FFFFFF'>");
   out.println("<td align='center' bgcolor='#F4F4F4'>"); 
   out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
   out.println("<tr bgcolor='#F4F4F4'>");
   out.println("<td width='13%' height='7'></td>");
   out.println("<td width='51%' height='7'>�۾��� : "+ em +"</td>");
   out.println("<td width='25%' height='7'></td>");
   out.println("<td width='11%' height='7'></td>");
   out.println("</tr>");
   out.println("<tr bgcolor='#F4F4F4'>");
   out.println("<td width='13%'></td>");
   out.println("<td width='51%'>�ۼ��� : " + rs.getString("inputdate") + "</td>");
   out.println("<td width='11%'></td>");
   out.println("</tr>");
   out.println("</table>");
   out.println("</td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td style='padding:10 0 0 0'>");
   out.println("<div align='left'><br>");
   out.println("<font size='3' color='#333333'><PRE>"+rs.getString("content") + "</PRE></div>");
   out.println("<br>");
   out.println("</td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td class='button' height='1'></td>");
   out.println("</tr>");
   out.println("<tr align='center'>");
   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
   out.println("</tr>");
   out.println("</table>");
   
   

  
 
	// ���� ���������� ���۷��ڵ�, ������ ���ڵ���� ��ȯ�ϸ鼭 ���
    for(int j=startrow; j<=endrow; j++) {
    String temp=(String)email.elementAt(j);		//email vector���� email �ּҸ� �����´�.
    
    
    if ((temp == null) || (temp.equals("")) ) 	//���� �ּҰ� ��������� 
     em= (String)name.elementAt(j); 			//em ������ �̸��� �����ͼ� ��´�.
    else	//�����ּҸ� ������ ������
     em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";
     


   }
 
   rs.close();
  }
  out.println("</TABLE>");
  st.close();
  conn.close();
 } catch (java.sql.SQLException e) {
  out.println(e);
 } 
 
 

 if (wheregroup > 1) {	 //���� ���� �׷��� 1 �̻��϶��� 
  out.println("[<A href=dbgb_show.jsp?gogroup=1>ó��</A>]"); 
  out.println("[<A href=dbgb_show.jsp?gogroup="+priorgroup +">����</A>]");
  
 } else { //���� ���� �׷��� 1�̻��� �ƴҶ�
	 
  out.println("[ó��]") ;
  out.println("[����]") ;
 }
 if (name.size() !=0) { 
  for(int jj=startpage; jj<=endpage; jj++) {
   if (jj==where) 
    out.println("["+jj+"]") ;
   else
    out.println("[<A href=dbgb_show.jsp?go="+jj+">" + jj + "</A>]") ;
   } 
  }
  if (wheregroup < totalgroup) {
   out.println("[<A href=dbgb_show.jsp?gogroup="+ nextgroup+ ">����</A>]");
   out.println("[<A href=dbgb_show.jsp?gogroup="+ totalgroup + ">������</A>]");
  } else {
   out.println("[����]");
   out.println("[������]");
  }
  out.println ("��ü �ۼ� :"+totalrows); 
 %>



<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=center valign=bottom width="117"><A href="dbgb_write.htm"><img src="image/write.gif" border="0"></TD>
 </TR>
</TABLE>
</BODY>
</HTML>