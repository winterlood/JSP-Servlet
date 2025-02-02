<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.MatchDAO"%>
<%@ page import="vo.MatchVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%--
viewmatch.jsp
매치 리스트를 보여주는 페이지
 --%>
<!DOCTYPE html>
<%
	System.out.println("--------------------viewmatch.jsp--------------------");

	String id = (String) session.getAttribute("id");
	System.out.printf("now id : %s\n", id);
	if (id == null) {
		System.out.println("로그인 미완료 : login.jsp로 이동합니다....\n");
	} else
		System.out.printf("Now User ID : %s\n", id);

	MemberVO vo = new MemberVO();
	MemberDAO dao = new MemberDAO();
	vo = dao.getInfo(id);
	int succ = vo.getSuccessMatch();
	int all = vo.getAllMatch();
	double avg = 0;
	if (succ == 0)
		avg = 0;
	else
		avg = (double) (succ / all) * 100;

	//BBS View
	int seqNo = 1;
	if (request.getParameter("seqNo") != null) {
		seqNo = Integer.parseInt(request.getParameter("seqNo"));
	}
	if (seqNo == 0) {
		out.println("<script>");
		out.println("alert('존재하지 않는 글입니다.')");
		out.println("location.href = 'jointhematch.jsp'");
		out.println("</script>");
	}
	MatchVO match = new MatchDAO().getMatches(seqNo);
%>
<html>
<head>
<title>매치 게시글</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<style>
.circle {
	background: aliceblue;
	width: 400px;
	padding: 20px;
	border-radius: 50px;
	text-align: center;
	border-style: solid;
	margin: auto;
}

.hidden {
	display: none;
}

a:hover {
	color: red;
}
</style>

</head>
<body>

	<header>
		<div id="HL">
			&nbsp;<a href="main.jsp">CUKBM</a>
		</div>

		<div id="HR">
			<%
				if (id == null) {
			%>
			<a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
			<%
				} else {
			%>
			<a href="mypage.jsp"><%=id%></a> | <a href="LogoutProc">로그아웃</a>
			<%
				}
			%>
			| <a href="alarm.jsp">ALARM</a>
		</div>
		<br />
	</header>
	<div class="header">
		<div class="title">&nbsp;JOIN THE MATCH</div>
		<div class="menu">
			<img src="image/menubar.png" />
		</div>
	</div>
	<br />
	<%
		if (id != null) {
	%>
	<div class="container1">
		<div class="row">
			<form action="JoinTheMatchProc" method="post">
				<div class="hidden">
					<input type="number" id="seqNo" name="seqNo" readonly
						value="<%=match.getSeqNo()%>">
				</div>
				<table id="viewertable">
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: darkgray; text-align: center;">게시판
								글</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2">글 제목</td>
							<td colspan="2" id="title"><%=match.getTitle()%></td>
						</tr>
						<tr>
							<td colspan="2">작성자</td>
							<td colspan="2" id="writer"><%=match.getWriter()%></td>
						</tr>
						<tr>
							<td colspan="2">flag1</td>
							<td colspan="2" id="flag1"><%=match.getFlag1()%></td>
						</tr>
						<tr>
							<td colspan="2">flag2</td>
							<td colspan="2" id="flag2"><%=match.getFlag2()%></td>
						</tr>

						<tr>
							<td colspan="2">stime</td>
							<td colspan="2" id="stime"><%=match.getStime()%></td>
						</tr>
						<tr>
							<td colspan="2">etime</td>
							<td colspan="2" id="etime"><%=match.getEtime()%></td>
						</tr>
						<tr>
							<td colspan="2">contents</td>
							<td colspan="2" id="contents"><%=match.getContents()%></td>
						</tr>
						<tr>
							<td colspan="2">addr</td>
							<td colspan="2" id="addr"><%=match.getAddr()%></td>
						</tr>
						<tr>
							<td colspan="2">teamflag</td>
							<td colspan="2" id="teamflag"><%=match.getTeamflag()%></td>
						</tr>
						<tr>
							<td colspan="2">needman</td>
							<td colspan="2" id="needman"><%=match.getNeedman()%></td>
						</tr>
						<tr>
							<td colspan="2">nowman</td>
							<td colspan="2" id="nowman"><%=match.getNowman()%></td>
						</tr>
					</tbody>
				</table>
				<br /> <a href="jointhematch.jsp"><p id="tablelist">목록</p></a> 
						<input type="submit" value="참가하기">
						<a href="viewpeople.jsp?seqNo=<%=seqNo%>">참가자</a>
			</form>
		</div>
	</div>
	<%
		} else {
	%>
	<script language="javascript">
		location.href = "login.jsp";
	</script>
	<%
		}
	%>
	<br />
	<br />
	<br />
	<div class="foot">
		number : 010 - 1234 - 5678<br /> Facebook : object-oriented paradime
		<br /> address : catholic university<br /> name : hong gil dong
	</div>


</body>
</html>