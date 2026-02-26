<<<<<<< HEAD

=======
<!-- javax.naming.NameNotFoundException: Name [jdbc/OracleDB]은(는) 이 컨텍스트에 바인딩되지 않았습니다. [jdbc]을(를) 찾을 수 없습니다.
지정한 이름의 Resource 를 찾을 수 없습니다.
	at org.apache.naming.NamingContext.lookup(NamingContext.java:485)
	at org.apache.naming.NamingContext.lookup(NamingContext.java:145)
	at org.apache.naming.NamingContext.lookup(NamingContext.java:494)
	at org.apache.naming.NamingContext.lookup(NamingContext.java:145)
	at org.apache.naming.NamingContext.lookup(NamingContext.java:494)
	at org.apache.naming.NamingContext.lookup(NamingContext.java:151)
	at org.apache.naming.SelectorContext.lookup(SelectorContext.java:138)
	at java.naming/javax.naming.InitialContext.lookup(InitialContext.java:409)
	at utils.DBCPUtil.getConnection(DBCPUtil.java:24)
	at org.apache.jsp.joinCheck_jsp._jspService(joinCheck_jsp.java:146)
	at org.apache.jasper.runtime.HttpJspBase.service(HttpJspBase.java:64)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:710)
	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:428)
	at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:330)
	at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:281)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:710)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:128)
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:107)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:165)
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:77)
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:492)
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:113)
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:83)
	at org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:654)
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:72)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:341)
	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:397)
	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:63)
	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:903)
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1779)
	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:52)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:946)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:480)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:57)
	at java.base/java.lang.Thread.run(Thread.java:1583)
java.lang.NullPointerException: Cannot invoke "java.sql.Connection.prepareStatement(String)" because "conn" is null
	at org.apache.jsp.joinCheck_jsp._jspService(joinCheck_jsp.java:153)
	at org.apache.jasper.runtime.HttpJspBase.service(HttpJspBase.java:64)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:710)
	at org.apache.jasper.servlet.JspServletWrapper.service(JspServletWrapper.java:428)
	at org.apache.jasper.servlet.JspServlet.serviceJspFile(JspServlet.java:330)
	at org.apache.jasper.servlet.JspServlet.service(JspServlet.java:281)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:710)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:128)
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:107)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:165)
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:77)
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:492)
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:113)
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:83)
	at org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:654)
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:72)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:341)
	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:397)
	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:63)
	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:903)
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1779)
	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:52)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:946)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:480)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:57)
	at java.base/java.lang.Thread.run(Thread.java:1583)
 -->
>>>>>>> branch 'master' of https://github.com/ParkOfEden/study.git
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
	<section class="main">
		<h1>MAIN PAGE</h1>
	</section>
<%@ include file="common/footer.jsp"%>










