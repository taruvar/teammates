<%@ page import="teammates.common.Common" %>
<%@ page import="teammates.ui.controller.AdminAccountManagementHelper"%>
<%@ page import="teammates.common.datatransfer.InstructorAttributes" %>
<%@ page import="teammates.common.datatransfer.AccountAttributes" %>
<%@ page import="teammates.common.exception.EntityDoesNotExistException" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
	AdminAccountManagementHelper helper = (AdminAccountManagementHelper)request.getAttribute("helper");
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="/favicon.png">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Teammates - Administrator Account Management</title>
    <link rel="stylesheet" href="/stylesheets/adminAccountManagement.css" type="text/css">
    <link rel="stylesheet" href="/stylesheets/common.css" type="text/css">

    <script type="text/javascript" src="/js/googleAnalytics.js"></script>
    <script type="text/javascript" src="/js/jquery-minified.js"></script>
    <script type="text/javascript" src="/js/tooltip.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/administrator.js"></script>
    <jsp:include page="../enableJS.jsp"></jsp:include>
</head>

<body>
    <div id="dhtmltooltip"></div>
    <div id="frameTop">
    <jsp:include page="<%=Common.JSP_ADMIN_HEADER%>" />
    </div>
    <div id="frameBody">
        <div id="frameBodyWrapper">
            <div id="topOfPage"></div>
            <div id="headerOperation">
            <h1>Instructor Account Management</h1>
            <br>
            <jsp:include page="<%=Common.JSP_STATUS_MESSAGE%>" />
            <br>
            </div>
            <p id="instructorCount" class="rightalign bold">Total Instructors: <%=helper.instructorCoursesTable.size()%></p>
            <table class="dataTable">
            <tr>
                <th class="bold" width="40%">Account Info</th>
                <th class="bold">Instructor for</th>
                <th class="bold" width="30%">Options</th>
            </tr>
            <%
            	for (Map.Entry<String, AccountAttributes> entry : helper.instructorAccountsTable.entrySet()) {
                                                String key = entry.getKey();
                                                AccountAttributes acc = entry.getValue();
                                                ArrayList<InstructorAttributes> coursesList = helper.instructorCoursesTable.get(key);
            %>
                <tr>
                     <td><%="<span class=\"bold\">Google ID: </span>" + acc.googleId + " <br><span class=\"bold\">Name: </span>" + acc.name + "<br><span class=\"bold\">Email: </span>" + acc.email%></td>
                     <td>
                     <%
                     	if(coursesList != null){
                     	                         out.print("Total Courses: " + coursesList.size() + "<br>");
                     	                         for(InstructorAttributes i: coursesList){
                     	                             out.print(" --- " + i.courseId + "<br>");
                     	                         }
                     	                     } else {
                     	                         out.print("No Courses found");
                     	                     }
                     %>
                     </td>
                     <td>
                        <a id="<%=acc.googleId + "_details"%>" href="<%=helper.getAccountDetailsLink(acc.googleId) %>">View Details</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="<%=acc.googleId + "_delete"%>" href="<%=helper.getInstructorDeleteLink(acc.googleId) %>">Delete Instructor Status</a><br>
                        <a id="<%=acc.googleId + "_deleteAccount"%>" href="<%=helper.getAccountDeleteLink(acc.googleId) %>" onclick="return toggleDeleteAccountConfirmation()">Delete Entire Account</a>
                     </td>
                </tr>
            <%
               }
            %>
            </table>
            <br>
            <br>
            <br>
        </div>
    </div>

    <div id="frameBottom">
        <jsp:include page="<%= Common.JSP_FOOTER %>" />
    </div>
</body>
</html>