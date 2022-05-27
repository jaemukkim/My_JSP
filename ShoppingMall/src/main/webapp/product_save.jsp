<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% request.setCharacterEncoding("euc-kr"); %>

<!-- DB 연결 설정 --> 
<%@ include file = "dbconn_mysql.jsp" %>


<%
	//이미지 파일이 업로드 되는 실제 톰켓의 물리적인 경로
String fileurl = application.getRealPath("upload");
//out.println(fileurl);
//if(true) return;

/*
out.println("이클립스의 물리적인 경로 : " + fileurl);

String upload = application.getRealPath("upload");
out.println("<p><p>이클립스 톰켓의 물리적인 경로 : " + upload);

if(true) return;	//프로그램 중지
*/


 String saveFolder="upload";
 String encType="euc-kr";
 int Maxsize = 5*1024*1024*1024;	//최대 업로드 용량 : 5GB
 
 ServletContext context = getServletContext();
 MultipartRequest multi = null;
 DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
 	//업로드 폴더에 동일한 이름의 파일이 존재할 경우 파일이름명 뒤에 번호를 할당해서 업로드
 	
 multi = new MultipartRequest(request,fileurl,Maxsize,encType,policy);
 
 String wn = multi.getParameter("wname");
 String cat= multi.getParameter("category");
 String pn = multi.getParameter("pname");
 String sn = multi.getParameter("sname");
 int price = Integer.parseInt(multi.getParameter("price"));
 int dprice = Integer.parseInt(multi.getParameter("dprice"));
 int stock = Integer.parseInt(multi.getParameter("stock"));
 String des = multi.getParameter("description");
 
 /*
 out.println(wn); out.println(cat);out.println(pn);out.println(sn);
 out.println(price);out.println(dprice);out.println(stock);out.println(des);
 
 if(true) return;	// 프로그램 멈춤
 */
 
 
 
 long id = 0;	//상품의 고유 번호 할당
 int pos=0;
 		//상품 설명이 들어간 컬럼에 ' 가 들어가면 DB에 저장시 오류 발생
 		// DB에 값을 넣을때 ' 도 처리해서 DB에 저장 되도록  설정
 		
 while ((pos=des.indexOf("\'", pos)) != -1) {
  String left=des.substring(0, pos);
  String right=des.substring(pos, des.length());
  des = left + "\'" + right;
  pos += 2;
 }
 
 java.util.Date yymmdd = new java.util.Date() ;
 SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
 
 String ymd=myformat.format(yymmdd);	//ymd : 년월일
 
 String sql=null;
 //Connection con=null;
 Statement st=null; 
 ResultSet rs=null;  
 int cnt=0; 
 

 
 try {
  
  st = conn.createStatement();
  sql = "select max(id) from  product where category= '"+cat+"'";
  		//DB의 id(상품의 고유 번호) : 기존의 category 의 최대 값을 가져와서 +1 해서 상품 고유 번호 할당.
 
  rs = st.executeQuery(sql);
  rs.next();
  id= rs.getLong(1);	// id는 카테고리의 최대값
 
  if (id==0) // 가져온 레코드가 0, category 컬럼의 상품이 존재하지 않을 경우
   id=Integer.parseInt(cat+"00001");	//1100001
  else    
   id= id + 1 ;
 
  //
  Enumeration files = multi.getFileNames();		//파일 이름 2개를 한꺼번에 가져온다.
  String fname1 = (String) files.nextElement();
  String filename1 = multi.getFilesystemName(fname1);
  String fname2 = (String) files.nextElement();
  String filename2 = multi.getFilesystemName(fname2);
 
  if (filename2 == null)
   filename2=filename1;
  sql = "insert into product(id,category,wname,pname,sname,price,downprice" ;
  sql = sql+",inputdate,stock,small,large,description) values("+id+",'";      
  sql = sql+cat+"','"+wn+"','"+pn+"','"+sn+"',"+price+","+dprice+",'"+ymd;
  sql = sql+"',"+stock+",'"+filename2+"','"+filename1+"','"+des+"')" ;
 
  cnt = st.executeUpdate(sql);
      
  if (cnt >0) 
   out.println("상품을 등록했습니다.");
  else  
   out.println("상품이 등록되지 않았습니다. ");
 
  st.close();
  conn.close();
  
 } catch (SQLException e) {
  out.println(e);
 }
%>
<P>
<A href="product_list.jsp">[상품 목록으로]</A> &nbsp;
<A href="product_write.htm">[상품 올리는 곳으로]</A>