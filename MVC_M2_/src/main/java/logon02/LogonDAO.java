package logon02;

import common.DBConnPool;
import logon.LogonDBBean;
import logon.LogonDataBean;

public class LogonDAO extends DBConnPool{

		private static LogonDAO instance = new LogonDAO();
	
		public static LogonDAO getInstance() {
			return instance; 
		}

//		private LogonDBBean ( ) { super(); }; 

		private LogonDAO ( ) { super(); }; 
		
		
		public void insertMember (LogonDTO Member) {
			
//		 SHA256 sha = SHA256.getInsatnce(); 
			
			try {
				
				//Form에서 넘겨받은 Password를 DB에 저장할때 암호화 
					//orgPass : Form 넘겨 받은 password
				String orgPass = Member.getU_pass();
//				String shaPass = sha.Sha256Encrypt(orgPass.getBytes());  //
//				String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt()); 
					//bcPass : 암호화된 암호 
				
				System.out.println ("암호화 되지 않은 패스워드 : " + orgPass); 
//				System.out.println ("암호화된 패스워드 : " + bcPass); 
				
						
				String sql = "insert into member02 values (?, ?, ?, ?, ?, ?, ?) "; 
				
				psmt = con.prepareStatement(sql) ; 
				psmt.setString(1, Member.getU_id());
//				psmt.setString(2, bcPass);				//암호화된 password 저장 
				psmt.setString(2, Member.getU_pass());	//암호화 되지 않는 패스워드 저장 
				psmt.setString(3, Member.getU_name());
				psmt.setTimestamp(4, Member.getR_date()); 
				psmt.setString(5, Member.getU_address());
				psmt.setString(6, Member.getU_tel());
				psmt.setTimestamp(7, Member.getU_birthday());
				
				psmt.executeUpdate(); 
				
				
				
				System.out.println("회원정보 DB 입력 성공 ");		
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("회원 정보 DB 입력시 예외 발생"); 
				
			}finally {
//				instance.close(); 
			}
				
		}
		
		//로그인 처리 (loginPro.jsp) :  폼에서 넘겨 받은 ID와 Pass를 DB를 확인. 
			// 사용자 인증처리, DB의 정보를 수정할때 , DB의 정보를 삭제 할때. 
			//사용자 인증 (MemberCheck.jsp) 에서 사용하는 메소드
		
		public int userCheck(String u_id, String u_pass) {
			int x = -1;   //x = -1  : 아이디가 존재하지 않음 , 
						  //x = 0   : 아이디는 존재하지만 패스워드가 일치 하지 않을때 
						  //x = 1   : 인증 성공, 
			
			//복호화 : 암호화된 Password를 암호흘 해독된 Password로 변환 
//			SHA256 sha = SHA256.getInsatnce(); 
			
			try {
				
				String orgPass = u_pass;    //폼에서 넘어오는 패스워드 
				
				String sql = "select u_pass from member02 where u_id = ? "; 
				psmt = con.prepareStatement(sql);
				psmt.setString(1, u_id);   
				rs = psmt.executeQuery(); 
				
				if (rs.next()) {    //아이디가 존재하면 
					String dbu_pass = rs.getString("u_pass");     //DB에서 가져온 패스워드 . 
					
					if (orgPass.equals(dbu_pass)) {
						x=1;  // 폼에서 넘겨온 패스워드와 DB에서 가져온 패스워드가 일치 할때 x: 1 
					}else {
						x= 0;   // 패스워드가 일치하지 않을때 
					}
					
					
				}			
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("아이디와 패스워드 인증 실패 했습니다.");
			}finally {
//				instance.close(); 	//객체 사용 종료. rs, smmt, psmt, con
			}
				
			return x; 		
		}
		
		//아이디 중복 체크 (confirmId.jsp) : 아이디 중복을 확인하는 메소드 
		public int confirmId (String u_id) {
			int x = -1 ;    //x = -1 일때 : 같은 ID가 DB에 존재하지 않음
							//x = 1 일때 : 같은 ID 가 DB에 존재 한다. (중복)
			
			try {
				String sql = "select u_id from member02 where u_id = ?" ; 
				psmt = con.prepareStatement(sql);
				
				System.out.println(sql);
				
				psmt.setString(1, u_id);
				rs = psmt.executeQuery();
				
				if ( rs.next()) {  // 아이디가 DB 에 존재하는 경우
					
					System.out.println(u_id + " 는 존재 하는 ID 입니다. ");
					
					 x= 1; 
				} else {  //아이디가 DB에 존재하지 않는 경우
					System.out.println(u_id + " 는 DB에 존재하지 않는 ID 입니다. ");
					 x= -1 ; 
				}
						
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println(" ID 중복 체크중 예외 발생");
			}finally {
			//	instance.close(); 
			}	
			return x ; 
		}
		
		//회원정보 수정 (modifyForm.jsp) : DB에서 회원 정보의값을 가져오는 메소드 
		
		public LogonDTO getMember (String u_id, String u_pass) {
			LogonDTO member = null ; 
//			SHA256 sha = SHA256.getInsatnce(); 
				
			try {
				
				String orgPass = u_pass; 
//				String shaPass = sha.getSha256(orgPass.getBytes()); 
				
				
				String sql = "select * from member02 where u_id = ?"; 
				psmt = con.prepareStatement(sql); 
				psmt.setString(1, u_id);
				rs = psmt.executeQuery(); 
				
				if (rs.next() ) {   //해당 아이디가  DB 에 존재한다. 
					String dbu_pass = rs.getString("u_pass");   // DB의 패스워드를 변수에 할당
//					if ( BCrypt.checkpw(shaPass, dbpasswd)) {
					
					if ( orgPass.equals(dbu_pass)) {
						//DB의 passwd 와 폼에서 넘겨온 Pass가 같을때  처리할 부분
							//DB에서 select 레코드를 DTO (LogonDataBean) 에 Setter주입 해서 값을 반환 
						
						//member 객체 생성 후 DB의 rs 에 저장된 값을 setter 주입후 리턴 
						member = new LogonDTO();    //
						
						member.setU_id(rs.getString("u_id"));
						member.setU_name(rs.getString("u_name"));
						member.setR_date(rs.getTimestamp("r_date"));
						member.setU_address(rs.getString("u_address"));
						member.setU_tel(rs.getString("u_tel"));
						member.setU_birthday(rs.getTimestamp("u_birthday"));
					} else { 
						//DB의 passwd 와 폼에서 넘겨온 Pass가 다를때 처리할 부분 
					}
					
				}
				
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("회원 정보 읽어 오는 중 예외 발생");
			}finally {
				
//				instance.close(); 
			}
		
			return member; 		  	
		}
		


}
