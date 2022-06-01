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
				
				//Form���� �Ѱܹ��� Password�� DB�� �����Ҷ� ��ȣȭ 
					//orgPass : Form �Ѱ� ���� password
				String orgPass = Member.getU_pass();
//				String shaPass = sha.Sha256Encrypt(orgPass.getBytes());  //
//				String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt()); 
					//bcPass : ��ȣȭ�� ��ȣ 
				
				System.out.println ("��ȣȭ ���� ���� �н����� : " + orgPass); 
//				System.out.println ("��ȣȭ�� �н����� : " + bcPass); 
				
						
				String sql = "insert into member02 values (?, ?, ?, ?, ?, ?, ?) "; 
				
				psmt = con.prepareStatement(sql) ; 
				psmt.setString(1, Member.getU_id());
//				psmt.setString(2, bcPass);				//��ȣȭ�� password ���� 
				psmt.setString(2, Member.getU_pass());	//��ȣȭ ���� �ʴ� �н����� ���� 
				psmt.setString(3, Member.getU_name());
				psmt.setTimestamp(4, Member.getR_date()); 
				psmt.setString(5, Member.getU_address());
				psmt.setString(6, Member.getU_tel());
				psmt.setTimestamp(7, Member.getU_birthday());
				
				psmt.executeUpdate(); 
				
				
				
				System.out.println("ȸ������ DB �Է� ���� ");		
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("ȸ�� ���� DB �Է½� ���� �߻�"); 
				
			}finally {
//				instance.close(); 
			}
				
		}
		
		//�α��� ó�� (loginPro.jsp) :  ������ �Ѱ� ���� ID�� Pass�� DB�� Ȯ��. 
			// ����� ����ó��, DB�� ������ �����Ҷ� , DB�� ������ ���� �Ҷ�. 
			//����� ���� (MemberCheck.jsp) ���� ����ϴ� �޼ҵ�
		
		public int userCheck(String u_id, String u_pass) {
			int x = -1;   //x = -1  : ���̵� �������� ���� , 
						  //x = 0   : ���̵�� ���������� �н����尡 ��ġ ���� ������ 
						  //x = 1   : ���� ����, 
			
			//��ȣȭ : ��ȣȭ�� Password�� ��ȣ�� �ص��� Password�� ��ȯ 
//			SHA256 sha = SHA256.getInsatnce(); 
			
			try {
				
				String orgPass = u_pass;    //������ �Ѿ���� �н����� 
				
				String sql = "select u_pass from member02 where u_id = ? "; 
				psmt = con.prepareStatement(sql);
				psmt.setString(1, u_id);   
				rs = psmt.executeQuery(); 
				
				if (rs.next()) {    //���̵� �����ϸ� 
					String dbu_pass = rs.getString("u_pass");     //DB���� ������ �н����� . 
					
					if (orgPass.equals(dbu_pass)) {
						x=1;  // ������ �Ѱܿ� �н������ DB���� ������ �н����尡 ��ġ �Ҷ� x: 1 
					}else {
						x= 0;   // �н����尡 ��ġ���� ������ 
					}
					
					
				}			
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("���̵�� �н����� ���� ���� �߽��ϴ�.");
			}finally {
//				instance.close(); 	//��ü ��� ����. rs, smmt, psmt, con
			}
				
			return x; 		
		}
		
		//���̵� �ߺ� üũ (confirmId.jsp) : ���̵� �ߺ��� Ȯ���ϴ� �޼ҵ� 
		public int confirmId (String u_id) {
			int x = -1 ;    //x = -1 �϶� : ���� ID�� DB�� �������� ����
							//x = 1 �϶� : ���� ID �� DB�� ���� �Ѵ�. (�ߺ�)
			
			try {
				String sql = "select u_id from member02 where u_id = ?" ; 
				psmt = con.prepareStatement(sql);
				
				System.out.println(sql);
				
				psmt.setString(1, u_id);
				rs = psmt.executeQuery();
				
				if ( rs.next()) {  // ���̵� DB �� �����ϴ� ���
					
					System.out.println(u_id + " �� ���� �ϴ� ID �Դϴ�. ");
					
					 x= 1; 
				} else {  //���̵� DB�� �������� �ʴ� ���
					System.out.println(u_id + " �� DB�� �������� �ʴ� ID �Դϴ�. ");
					 x= -1 ; 
				}
						
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println(" ID �ߺ� üũ�� ���� �߻�");
			}finally {
			//	instance.close(); 
			}	
			return x ; 
		}
		
		//ȸ������ ���� (modifyForm.jsp) : DB���� ȸ�� �����ǰ��� �������� �޼ҵ� 
		
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
				
				if (rs.next() ) {   //�ش� ���̵�  DB �� �����Ѵ�. 
					String dbu_pass = rs.getString("u_pass");   // DB�� �н����带 ������ �Ҵ�
//					if ( BCrypt.checkpw(shaPass, dbpasswd)) {
					
					if ( orgPass.equals(dbu_pass)) {
						//DB�� passwd �� ������ �Ѱܿ� Pass�� ������  ó���� �κ�
							//DB���� select ���ڵ带 DTO (LogonDataBean) �� Setter���� �ؼ� ���� ��ȯ 
						
						//member ��ü ���� �� DB�� rs �� ����� ���� setter ������ ���� 
						member = new LogonDTO();    //
						
						member.setU_id(rs.getString("u_id"));
						member.setU_name(rs.getString("u_name"));
						member.setR_date(rs.getTimestamp("r_date"));
						member.setU_address(rs.getString("u_address"));
						member.setU_tel(rs.getString("u_tel"));
						member.setU_birthday(rs.getTimestamp("u_birthday"));
					} else { 
						//DB�� passwd �� ������ �Ѱܿ� Pass�� �ٸ��� ó���� �κ� 
					}
					
				}
				
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("ȸ�� ���� �о� ���� �� ���� �߻�");
			}finally {
				
//				instance.close(); 
			}
		
			return member; 		  	
		}
		


}
