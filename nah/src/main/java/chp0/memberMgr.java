package chp0;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class memberMgr {

	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "/Users/nana/eclipse-workspace/nah/src/main/webapp/chp0/board/fileupload";
	private static final String ENCTYPE = "UTF-8";
	private static int MAXSIZE = 5*1024*1024;
	
	public memberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//ID 중복확인
public boolean checkId(String id) {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	boolean flag = false;
	try {
		con = pool.getConnection();
		sql = "select usid from h_admin where usid = ? ";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		flag = pstmt.executeQuery().next();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con,pstmt,rs);
	}
	return flag;
}
//우편번호 검색
public Vector<Bean_Postcode> zipcodeRead(String area3) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	Vector<Bean_Postcode> vlist = new Vector<Bean_Postcode>();
	try {
		con = pool.getConnection();
		sql = "select * from h_post where area3 like ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,  "%"+area3 + "%");
		rs = pstmt.executeQuery();
		while(rs.next()) {
			Bean_Postcode bean = new Bean_Postcode();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
			vlist.addElement(bean);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con,pstmt,rs);
	}
	return vlist;
}
//회원가입
public boolean insertMember(Bean_Member bean) {
	Connection con = null;
	PreparedStatement pstmt = null;
	String sql = null;
	boolean flag = false;
	try {
		con = pool.getConnection();
		sql = "insert h_admin(usid,uspw,gubn,stat,sang,name,telp,gend,brth,mail,post,addr,hobb,jobb)value(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";	
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, bean.getUsid());
		pstmt.setString(2, bean.getUspw());
		pstmt.setString(3, bean.getGubn());
		pstmt.setString(4, bean.getStat());
		pstmt.setString(5, bean.getSang());
		pstmt.setString(6, bean.getName());
		pstmt.setString(7, bean.getTelp());
		pstmt.setString(8, bean.getGend());
		pstmt.setString(9, bean.getBrth());
		pstmt.setString(10, bean.getMail());
		pstmt.setString(11, bean.getPost());
		pstmt.setString(12, bean.getAddr());
		String hobb[] = bean.getHobb();
		char hb[] = {'0','0','0','0','0'};
		String lists[] = {"운동","여행","게임","영화","독서"};
		for (int i = 0; i <hobb.length;i++) {
			for(int j = 0; j < lists.length; j++) {
				if(hobb[i].equals(lists[j]))
					hb[j] = '1';
			}
		}
		pstmt.setString(13, new String(hb));
		pstmt.setString(14, bean.getJobb());
		if(pstmt.executeUpdate()==1)
			flag = true;
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con,pstmt);
	}
	return flag;
}
//로그인
	public boolean loginMember(String usid, String uspw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from h_admin where usid = ? and uspw = ? and stat = '승인'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, uspw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
		
	// 회원 조회 (usid)
		public Bean_Member getMember(String usid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Member bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from h_admin where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Member();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setUspw(rs.getString("uspw"));
					bean.setGubn(rs.getString("gubn"));
					bean.setStat(rs.getString("stat"));
					bean.setSang(rs.getString("sang"));
					bean.setName(rs.getString("name"));
					bean.setTelp(rs.getString("telp"));
					bean.setGend(rs.getString("gend"));
					bean.setBrth(rs.getString("brth"));
					bean.setMail(rs.getString("mail"));
					bean.setPost(rs.getString("post"));
					bean.setAddr(rs.getString("addr"));
					String hobbys[] = new String[5];
					String hobb = rs.getString("hobb");// 01001
					for (int i = 0; i < hobbys.length; i++) {
						hobbys[i] = hobb.substring(i, i + 1);
					}
					bean.setHobb(hobbys);
					bean.setJobb(rs.getString("jobb"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}

		// 회원 조회 (numb)
		public Bean_Member getMember2(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Member bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from h_admin where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Member();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setUspw(rs.getString("uspw"));
					bean.setGubn(rs.getString("gubn"));
					bean.setStat(rs.getString("stat"));
					bean.setSang(rs.getString("sang"));
					bean.setName(rs.getString("name"));
					bean.setTelp(rs.getString("telp"));
					bean.setGend(rs.getString("gend"));
					bean.setBrth(rs.getString("brth"));
					bean.setMail(rs.getString("mail"));
					bean.setPost(rs.getString("post"));
					bean.setAddr(rs.getString("addr"));
					String hobbys[] = new String[5];
					String hobb = rs.getString("hobb");// 01001
					for (int i = 0; i < hobbys.length; i++) {
						hobbys[i] = hobb.substring(i, i + 1);
					}
					bean.setHobb(hobbys);
					bean.setJobb(rs.getString("jobb"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
		
		// 회원 조회 (numb)
		public Bean_Member getMember3(String usid, int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Member bean = null;
			try {
				con = pool.getConnection();
				if (numb > 0) {
					String sql = "select * from h_admin where numb = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, numb);
				} else {
					String sql = "select * from h_admin where usid = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, usid);
				}
				
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Member();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setUspw(rs.getString("uspw"));
					bean.setGubn(rs.getString("gubn"));
					bean.setStat(rs.getString("stat"));
					bean.setSang(rs.getString("sang"));
					bean.setName(rs.getString("name"));
					bean.setTelp(rs.getString("telp"));
					bean.setGend(rs.getString("gend"));
					bean.setBrth(rs.getString("brth"));
					bean.setMail(rs.getString("mail"));
					bean.setPost(rs.getString("post"));
					bean.setAddr(rs.getString("addr"));
					String hobbys[] = new String[5];
					String hobb = rs.getString("hobb");// 01001
					for (int i = 0; i < hobbys.length; i++) {
						hobbys[i] = hobb.substring(i, i + 1);
					}
					bean.setHobb(hobbys);
					bean.setJobb(rs.getString("jobb"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}

		// 회원 정보 수정
		public boolean updateMember(Bean_Member bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				String sql = "update h_admin set uspw=?, gubn=?, stat=?, sang=?, name=?, telp=?, gend=?, brth=?,"
						+ "mail=?, post=?, addr=?, hobb=?, jobb=? where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getUspw());
				pstmt.setString(2, bean.getGubn());
				pstmt.setString(3, bean.getStat());
				pstmt.setString(4, bean.getSang());
				pstmt.setString(5, bean.getName());
				pstmt.setString(6, bean.getTelp());
				pstmt.setString(7, bean.getGend());
				pstmt.setString(8, bean.getBrth());
				pstmt.setString(9, bean.getMail());
				pstmt.setString(10, bean.getPost());
				pstmt.setString(11, bean.getAddr());
				char hobby[] = { '0', '0', '0', '0', '0' };
				if (bean.getHobb() != null) {
					String hobbys[] = bean.getHobb();
					String lists[] = { "운동", "여행", "게임", "영화", "독서" };
					for (int i = 0; i < hobbys.length; i++) {
						for (int j = 0; j < lists.length; j++)
							if (hobbys[i].equals(lists[j]))
								hobby[j] = '1';
					}
				}
				pstmt.setString(12, new String(hobby));
				pstmt.setString(13, bean.getJobb());
				pstmt.setString(14, bean.getUsid());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 회원 총 수
		public int getTotalCount(String gubn, String check) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			
			try {
				con = pool.getConnection();
				if ( (gubn.equals("S")) && (check.equals("N")) ) {
				       	sql = "select count(numb) from h_admin ";
					   	pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("Y")) ) {
						sql = "select count(numb) from h_admin where stat='미승인' ";
					   	pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("J")) ) {
						sql = "select count(numb) from h_admin where stat='승인' ";
					   	pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("S1")) ) {
						sql = "select count(numb) from h_admin where sang='정상' ";
					   	pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("S2")) ) {
						sql = "select count(numb) from h_admin where sang<>'정상' ";
					   	pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("H1")) ) {
						sql = "select count(numb) from h_admin where gubn='A' ";
					   	pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("H2")) ) {
						sql = "select count(numb) from h_admin where gubn='B' ";
					   	pstmt = con.prepareStatement(sql);
					}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		//회원 리스트
		public Vector<Bean_Member> getMemberList() {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Member> vlist = new Vector<Bean_Member>();
			
			try {
				con = pool.getConnection();
				sql = "select * from h_admin";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Member bean = new Bean_Member();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setName(rs.getString("name"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		} 
		

		// 해당 조건의 회원 조회
		public Vector<Bean_Member> getMemberList(String gubn, String check) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Member> vlist = new Vector<Bean_Member>();
			//System.out.println(check);
			try {
				con = pool.getConnection();
				if ( (gubn.equals("S")) && (check.equals("N")) ) {
					sql = "select * from h_admin ";
					pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("Y")) ) {
					sql = "select * from h_admin where stat='미승인' ";
				   	pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("J")) ) {
					sql = "select * from h_admin where stat='승인' ";
				   	pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("S1")) ) {
					sql = "select * from h_admin where sang='정상' ";
				   	pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("S2")) ) {
					sql = "select * from h_admin where sang<>'정상' ";
				   	pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("H1")) ) {
					sql = "select * from h_admin where gubn='A' ";
				   	pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("H2")) ) {
					sql = "select * from h_admin where gubn='B' ";
				   	pstmt = con.prepareStatement(sql);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Member bean = new Bean_Member();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setUspw(rs.getString("uspw"));
					bean.setGubn(rs.getString("gubn"));
					bean.setStat(rs.getString("stat"));
					bean.setSang(rs.getString("sang"));
					bean.setName(rs.getString("name"));
					bean.setTelp(rs.getString("telp"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		// 회원 정보 삭제
		public void deleteMember(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from h_admin where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}

		// 회원 승인 여부 
		public boolean updatePerm(int recnum, String perm) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				if (perm.equals("미승인")) {
					String sql = "update h_admin set stat='승인' where numb=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, recnum);
				} else {
					String sql = "update h_admin set stat='미승인' where numb=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, recnum);
				}
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 도서 정보 ===============================================================================
		// 도서 자료 수
		public int getBookCount(String check, String keyWord, String keyField) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if (check.equals("N")) {
					sql = "select count(numb) from book_booklist";
				    pstmt = con.prepareStatement(sql);
				} else if (check.equals("J")) {
					sql = "select count(numb) from book_booklist where b_state = '대출중' ";
				    pstmt = con.prepareStatement(sql);
				} else if (check.equals("G")) {
					sql = "select count(numb) from book_booklist where b_state = '대출가능' ";
				    pstmt = con.prepareStatement(sql);
				} else if (check.equals("S")) {
			        if (!keyWord.isEmpty()) {
			            sql = "SELECT COUNT(*) AS total FROM book_booklist WHERE " + keyField + " LIKE ?";
			            pstmt = con.prepareStatement(sql);
			            pstmt.setString(1, "%" + keyWord + "%");
			        } else {
			            sql = "SELECT COUNT(*) AS total FROM book_booklist";
			            pstmt = con.prepareStatement(sql);
			        }
			    }
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		// 도서 내역 아이디 조건으로 조회
		public Vector<Bean_Booklist> getBookList(String check, String keyWord, String keyField, int startRecord, int recordsPerPage) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Booklist> vlist = new Vector<Bean_Booklist>();
			try {
		        con = pool.getConnection();
		        if (check.equals("N")) {
		            sql = "SELECT * FROM book_booklist LIMIT ?, ?";
		            pstmt = con.prepareStatement(sql);
		            pstmt.setInt(1, startRecord);
		            pstmt.setInt(2, recordsPerPage);
		        } else if (check.equals("J")) {
		            sql = "SELECT * FROM book_booklist WHERE b_state = '대출중' LIMIT ?, ?";
		            pstmt = con.prepareStatement(sql);
		            pstmt.setInt(1, startRecord);
		            pstmt.setInt(2, recordsPerPage);
		        } else if (check.equals("G")) {
		            sql = "SELECT * FROM book_booklist WHERE b_state = '대출가능' LIMIT ?, ?";
		            pstmt = con.prepareStatement(sql);
		            pstmt.setInt(1, startRecord);
		            pstmt.setInt(2, recordsPerPage);
		        } else if (check.equals("S")) {
		            if (!keyWord.isEmpty()) {
		                sql = "SELECT * FROM book_booklist WHERE " + keyField + " LIKE ? LIMIT ?, ?";
		                pstmt = con.prepareStatement(sql);
		                pstmt.setString(1, "%" + keyWord + "%");
		                pstmt.setInt(2, startRecord);
		                pstmt.setInt(3, recordsPerPage);
		            } else { // keyWord가 비어있을 때는 모든 레코드를 가져옵니다.
		                sql = "SELECT * FROM book_booklist LIMIT ?, ?";
		                pstmt = con.prepareStatement(sql);
		                pstmt.setInt(1, startRecord);
		                pstmt.setInt(2, recordsPerPage);
		            }
		        }
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Booklist bean = new Bean_Booklist();
					bean.setNumb(rs.getInt("numb"));
					bean.setIsbn(rs.getString("isbn"));
					bean.setBookname(rs.getString("bookname"));
					bean.setAuthor(rs.getString("author"));
					bean.setChulpan(rs.getString("chulpan"));
					bean.setBookyear(rs.getString("bookyear"));
					bean.setPage(rs.getString("page"));
					bean.setPrice(rs.getString("price"));
					bean.setB_state(rs.getString("b_state"));
					bean.setBigo(rs.getString("bigo"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}

		// 도서 내역 신규 추가
		public boolean Book_Insert(Bean_Booklist bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert book_booklist(isbn,bookname,author,chulpan,bookyear"
						+ ",page,price,b_state, bigo)values(?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getIsbn());
				pstmt.setString(2, bean.getBookname());
				pstmt.setString(3, bean.getAuthor());
				pstmt.setString(4, bean.getChulpan());
				pstmt.setString(5, bean.getBookyear());
				pstmt.setString(6, bean.getPage());
				pstmt.setString(7, bean.getPrice());
				pstmt.setString(8, bean.getB_state());
				pstmt.setString(9, bean.getBigo());
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 도서 등록 내역 조회 (numb)
		public Bean_Booklist getBook1(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Booklist bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from book_booklist where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Booklist();
					bean.setNumb(rs.getInt("numb"));
					bean.setIsbn(rs.getString("isbn"));
					bean.setBookname(rs.getString("bookname"));
					bean.setAuthor(rs.getString("author"));
					bean.setChulpan(rs.getString("chulpan"));
					bean.setBookyear(rs.getString("bookyear"));
					bean.setPage(rs.getString("page"));
					bean.setPrice(rs.getString("price"));
					bean.setB_state(rs.getString("b_state"));
					bean.setBigo(rs.getString("bigo"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}

		// 도서 내역 수정
		public boolean updateBook(Bean_Booklist bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update book_booklist set isbn=?, bookname=?, author=?, "
						     + "chulpan=?, bookyear=?, page=?, price=?, b_state=?, "
		   				     + "bigo=? where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getIsbn());
				pstmt.setString(2, bean.getBookname());
				pstmt.setString(3, bean.getAuthor());
				pstmt.setString(4, bean.getChulpan());
				pstmt.setString(5, bean.getBookyear());
				pstmt.setString(6, bean.getPage());
				pstmt.setString(7, bean.getPrice());
				pstmt.setString(8, bean.getB_state());
				pstmt.setString(9, bean.getBigo());
				pstmt.setInt(10, bean.getNumb());
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 도서 정보 삭제
		public void deleteBook(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from book_booklist where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
		// 대출 정보 ===============================================================================
		// 도서 대출 자료 수
		public int getDaeCount(String gubn, String usid, String check) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if ( (gubn.equals("S")) && (check.equals("N")) ){
				       sql = "select count(numb) from book_daechul";
					   pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("Y")) ){
					   sql = "select count(numb) from book_daechul where nalsu > 0";
					   pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("M")) ){
						   sql = "select count(numb) from book_daechul where b_date is null";
						   pstmt = con.prepareStatement(sql);
					} else if ( (gubn.equals("S")) && (check.equals("B")) ){
						   sql = "select count(numb) from book_daechul where b_date is not null";
						   pstmt = con.prepareStatement(sql);
					} else if (gubn.equals("A")) {
						   sql = "select count(numb) from book_daechul where usid=?";
						   pstmt = con.prepareStatement(sql);
						   pstmt.setString(1, usid);
					} else if (gubn.equals("B")) {
						   sql = "select count(numb) from book_daechul where usid=?";
						   pstmt = con.prepareStatement(sql);
						   pstmt.setString(1, usid);
					} else {
						   sql = "select count(numb) from book_daechul where gubn=?";
						   pstmt = con.prepareStatement(sql);
						   pstmt.setString(1, "NULL");
					}
				
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}

		// 도서 대출 내역 아이디 조건으로 조회
		public Vector<Bean_Daechul> getDaeList(String gubn, String usid, String check) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Daechul> vlist = new Vector<Bean_Daechul>();
			try {
				con = pool.getConnection();
				if ( (gubn.equals("S")) && (check.equals("N")) ){
				    sql = "select * from book_daechul";
					pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("Y")) ){
					sql = "select * from book_daechul where nalsu > 0";
					pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("M")) ){
					sql = "select * from book_daechul where b_date is null";
					pstmt = con.prepareStatement(sql);
				} else if ( (gubn.equals("S")) && (check.equals("B")) ){
					sql = "select * from book_daechul where b_date is not null";
					pstmt = con.prepareStatement(sql);
				} else if (gubn.equals("A")) {
					sql = "select * from book_daechul where usid=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, usid);
				} else if (gubn.equals("B")) {
					sql = "select * from book_daechul where usid=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, usid);
				} else {
					sql = "select * from book_daechul where gubn=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "NULL");
				}

				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Daechul bean = new Bean_Daechul();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setIsbn(rs.getString("isbn"));
					bean.setD_date(rs.getString("d_date"));
					bean.setY_date(rs.getString("y_date"));
					bean.setB_date(rs.getString("b_date"));
					bean.setNalsu(rs.getInt("nalsu"));
					bean.setBigo(rs.getString("bigo"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}

		// 도서명 조회 (isbn)
		public Bean_Booklist getBook2(String isbn) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Booklist bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from book_booklist where isbn = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, isbn);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Booklist();
					bean.setNumb(rs.getInt("numb"));
					bean.setIsbn(rs.getString("isbn"));
					bean.setBookname(rs.getString("bookname"));
					bean.setAuthor(rs.getString("author"));
					bean.setChulpan(rs.getString("chulpan"));
					bean.setBookyear(rs.getString("bookyear"));
					bean.setPage(rs.getString("page"));
					bean.setPrice(rs.getString("price"));
					bean.setB_state(rs.getString("b_state"));
					bean.setBigo(rs.getString("bigo"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
		
		// 도서 대출 내역 신규 추가
		public boolean Dae_Insert(Bean_Daechul bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert book_daechul(usid,isbn,d_date,y_date,b_date,"
						+ "bigo) values (?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getUsid());
				pstmt.setString(2, bean.getIsbn());
				pstmt.setString(3, bean.getD_date());
				pstmt.setString(4, bean.getY_date());
				pstmt.setString(5, bean.getB_date());
				pstmt.setString(6, bean.getBigo());
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 도서 대출 반납 내역 조회 (numb)
		public Bean_Daechul getDae1(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Daechul bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from book_daechul where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Daechul();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setIsbn(rs.getString("isbn"));
					bean.setD_date(rs.getString("d_date"));
					bean.setY_date(rs.getString("y_date"));
					bean.setB_date(rs.getString("b_date"));
					bean.setNalsu(rs.getInt("nalsu"));
					bean.setBigo(rs.getString("bigo"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}

		// 도서 대출 반납 내역 수정
		public boolean updateDae(Bean_Daechul bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update book_daechul set usid=?, isbn=?, d_date=?, y_date=?, "
					     + "b_date=?, bigo=? where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getUsid());
				pstmt.setString(2, bean.getIsbn());
				pstmt.setString(3, bean.getD_date());
				pstmt.setString(4, bean.getY_date());
				pstmt.setString(5, bean.getB_date());
				pstmt.setString(6, bean.getBigo());
				pstmt.setInt(7, bean.getNumb());
				
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 도서 대출 정보 삭제
		public void deleteDae(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "delete from book_daechul where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}

		// 도서 찾기
		public Vector<Bean_Booklist> IsbnRead(String book_name) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Booklist> vlist = new Vector<Bean_Booklist>();
			try {
				con = pool.getConnection();
				sql = "select numb, isbn, bookname, author, chulpan, b_state "
						+ "from book_booklist where b_state = '대출가능' "
						+ "and bookname like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + book_name + "%");
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Booklist bean = new Bean_Booklist();
					bean.setNumb(rs.getInt(1));
					bean.setIsbn(rs.getString(2));
					bean.setBookname(rs.getString(3));
					bean.setAuthor(rs.getString(4));
					bean.setChulpan(rs.getString(5));
					bean.setB_state(rs.getString(6));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}

		// 아이디 찾기
		public Vector<Bean_Member> UsidRead(String name) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Member> vlist = new Vector<Bean_Member>();
			try {
				con = pool.getConnection();
				sql = "select numb, stat, usid, name, telp from h_admin where name like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + name + "%");
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Member bean = new Bean_Member();
					bean.setNumb(rs.getInt(1));
					bean.setStat(rs.getString(2));
					bean.setUsid(rs.getString(3));
					bean.setName(rs.getString(4));
					bean.setTelp(rs.getString(5));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}

		// 반납 예정일자 계산
		public boolean updateYdate(int numb, String y_date) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				String sql = "update book_daechul set y_date=? where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, y_date);
				pstmt.setInt(2, numb);
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}

		// 연체 일수 계산
		public boolean updateNalsu(int numb, long nal) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				if (nal > 0) {
					   String sql = "update book_daechul set nalsu=? where numb=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setLong(1, nal);
						pstmt.setInt(2, numb);
				} else {
					   String sql = "update book_daechul set nalsu=0 where numb=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, numb);
				}
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}

		// 미반납 도서에 대출중으로 표시 
		public boolean updateMibannab(String isbn, String b_date) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
		   	//System.out.print(isbn);
		   	//System.out.println(b_date);
			
			try {
				con = pool.getConnection();
				if (b_date == null) {
					   String sql = "update book_booklist set b_state='대출중' where isbn=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, isbn);
				} else {
					   String sql = "update book_booklist set b_state='대출가능' where isbn=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, isbn);
				}
				
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 연체자 표시 
		public boolean updateYun(String usid, int nalsu) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
		   	//System.out.print(usid);
		   	//System.out.println(nalsu);
			
			try {
				con = pool.getConnection();
				if (nalsu > 0) {
					   String sql = "update h_admin set sang=? where usid=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "연체_" + nalsu);
						pstmt.setString(2, usid);
				} else {
					   String sql = "update h_admin set sang='정상' where usid=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, usid);
				}
				
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}

		// 게시판 리스트
		public Vector<Bean_Board> getBoardList(String keyField, String keyWord, 
									int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Board> vlist = new Vector<Bean_Board>();
			try {
					con = pool.getConnection();
					if (keyWord.equals("null") || keyWord.equals("")) {
							sql = "select * from book_board order by ref desc, pos limit ?, ?";
							pstmt = con.prepareStatement(sql);
							pstmt.setInt(1,  start);
							pstmt.setInt(2, end);
					} else {
							sql = "select * from book_board where " + keyField + " like ? ";
							sql += "order by ref desc, pos limit ? , ?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1,  "%" + keyWord + "%");
							pstmt.setInt(2,  start);
							pstmt.setInt(3, end);
					}
					rs = pstmt.executeQuery();
					while (rs.next()) {
							Bean_Board bean = new Bean_Board();
							bean.setNum(rs.getInt("num"));
							bean.setName(rs.getString("name"));
							bean.setSubject(rs.getString("subject"));
							bean.setPos(rs.getInt("pos"));
							bean.setRef(rs.getInt("ref"));
							bean.setDepth(rs.getInt("depth"));
							bean.setRegdate(rs.getString("regdate"));
							bean.setCount(rs.getInt("count"));
							vlist.add(bean);
					}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		// 총 게시물 수
		public int getBoardTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if (keyWord.equals("null") || keyWord.equals("")) {
					sql = "select count(num) from book_board";
					pstmt = con.prepareStatement(sql);
				} else {
					sql = "select count(num) from  book_board where " + keyField + " like ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					totalCount = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
		
		// 게시판 입력
		public void insertBoard(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MultipartRequest multi = null;
			int filesize = 0;
			String filename = null;
			try {
				con = pool.getConnection();
				sql = "select max(num) from book_board";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int ref = 1;
				if (rs.next())
					ref = rs.getInt(1) + 1;
				File file = new File(SAVEFOLDER);
				if (!file.exists())
					file.mkdirs();
				multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());

				if (multi.getFilesystemName("filename") != null) {
					filename = multi.getFilesystemName("filename");
					filesize = (int) multi.getFile("filename").length();
				}
				String content = multi.getParameter("content");
				if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
					content = UtilMgr.replace(content, "<", "&lt;");
				}
				sql = "insert book_board(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
				sql += "values(?, ?, ?, ?, 0, 0, curdate(), ?, 0, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, content);
				pstmt.setString(3, multi.getParameter("subject"));
				pstmt.setInt(4, ref);
				pstmt.setString(5, multi.getParameter("pass"));
				pstmt.setString(6, multi.getParameter("ip"));
				pstmt.setString(7, filename);
				pstmt.setInt(8, filesize);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		
		// 게시물 리턴
		public Bean_Board getBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Bean_Board bean = new Bean_Board();
			try {
				con = pool.getConnection();
				sql = "select * from book_board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setNum(rs.getInt("num"));
					bean.setName(rs.getString("name"));
					bean.setSubject(rs.getString("subject"));
					bean.setContent(rs.getString("content"));
					bean.setPos(rs.getInt("pos"));
					bean.setRef(rs.getInt("ref"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setPass(rs.getString("pass"));
					bean.setCount(rs.getInt("count"));
					bean.setFilename(rs.getString("filename"));
					bean.setFilesize(rs.getInt("filesize"));
					bean.setIp(rs.getString("ip"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}

		// 조회 수 증가
		public void upCount(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update book_board set count=count+1 where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 게시물 삭제
		public void deleteBoard(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;
			try {
				con = pool.getConnection();
				sql = "select filename from book_board where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next() && rs.getString(1) != null) {
					if (!rs.getString(1).equals("")) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if (file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}
				sql = "delete from book_board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}

		// 게시물 수정
		public void updateBoard(Bean_Board bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update book_board set name = ?, subject=?, content = ? where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getName());
				pstmt.setString(2, bean.getSubject());
				pstmt.setString(3, bean.getContent());
				pstmt.setInt(4, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 게시물 답변
		public void replyBoard(Bean_Board bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert book_board (name,subject,content,pos,ref,depth,regdate,pass,ip,count)";
				sql += "values(?,?,?,?,?,?,curdate(),?,?,0)";
				int depth = bean.getDepth() + 1;
				int pos = bean.getPos() + 1;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getName());
				pstmt.setString(2, bean.getSubject());
				pstmt.setString(3, bean.getContent());
				pstmt.setInt(4, pos);
				pstmt.setInt(5, bean.getRef());
				pstmt.setInt(6, depth);
				pstmt.setString(7, bean.getPass());
				pstmt.setString(8, bean.getIp());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 답변에 위치값 증가
		public void replyUpBoard(int ref, int pos) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update book_board set pos = pos + 1 where ref = ? and pos > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, pos);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}

		// 파일 다운로드
			public void downLoad(HttpServletRequest req, HttpServletResponse res,
					JspWriter out, PageContext pageContext) {
				try {
					String filename = req.getParameter("filename");
					File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ filename));
					byte b[] = new byte[(int) file.length()];
					res.setHeader("Accept-Ranges", "bytes");
					String strClient = req.getHeader("User-Agent");
					if (strClient.indexOf("MSIE6.0") != -1) {
						res.setContentType("application/smnet;charset=euc-kr");
						res.setHeader("Content-Disposition", "filename=" + filename + ";");
					} else {
						res.setContentType("application/smnet;charset=euc-kr");
						res.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
					}
					out.clear();
					out = pageContext.pushBody();
					if (file.isFile()) {
						BufferedInputStream fin = new BufferedInputStream(
								new FileInputStream(file));
						BufferedOutputStream outs = new BufferedOutputStream(
								res.getOutputStream());
						int read = 0;
						while ((read = fin.read(b)) != -1) {
							outs.write(b, 0, read);
						}
						outs.close();
						fin.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		// 페이징 및 블럭 테스트를 위한 게시물 저장  
		public void post1000(){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert book_board(name,subject,content,pos,ref,depth,regdate,pass,ip,count,filename,filesize)";
				sql+="values('차은우', '책책책', '책책책 책을 읽읍시다', 0, 0, 0, curdate(), '1234', '127.0.0.1', 0, null, 0);";
				pstmt = con.prepareStatement(sql);
				for (int i = 0; i < 1000; i++) {
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		// main
		public static void main(String[] args) {
			new memberMgr().post1000();
			System.out.println("SUCCESS");
		}
}
