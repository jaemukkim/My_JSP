package membership;

import common.DBConnPool;

public class MemberDAO extends DBConnPool{
	
	public MemberDAO() {   //DB Connection 설정 완료 
		super();              //부모의 기본 생성자 호출시 con 객체 생성 
	}
	
	//클라이언트의 ID와 Password값을 받아와서 회원 테이블의 정보와 일치하는 회원 정보를 DTO에 담아서 반환
	
	public MemberDTO getMemberDTO (String uid, String upass ) {
		MemberDTO dto = new MemberDTO();
		String query = "SELECT * FROM member where id = ? AND pass = ?" ; 
			//1개의 레코드가 출력되면 : id 와 pass가 존재하는 경우 
			//0개의 레코드가 출력 되면 : id 와 pass가 하나라도 DB에 존재하지 않는 경우 
		
		try {
			psmt = con.prepareStatement(query); 
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();  
			
			//rs의 값을 DTO에 저장 
			
			if (rs.next()) {   //레코드의 값이 존재하면, rs.next() 
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));	
				
				System.out.println("인증 성공 ");
				
			}else {
				
				System.out.println("인증 실패 ");
			}
						
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("ID , Pass 확인시 예외 발생 ");
		}
		
		return dto;  //Client 에서 uid, upass 값을 받아와서 DB 에서 검색후 검색된 값을 DTO애 
					//담아서 값을 받환 해준다. 	
	}
	
	
	

}
