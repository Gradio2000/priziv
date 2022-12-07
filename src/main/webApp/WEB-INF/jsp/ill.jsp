<%--
  Created by IntelliJ IDEA.
  User: aleksejlaskin
  Date: 25.11.2022
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"       prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml"       prefix="x"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"  %>
<script type="text/javascript" src="../../../js/jquery-3.6.0.js"></script>
<html>
<style>
    <%@include file="../../includes/myStyle.css"%>

</style>
<head>
    <jsp:include page="../../includes/header.jsp"/>
    <jsp:include page="../../includes/menu.jsp"/>

    <title>Список больных</title>
</head>
<body>
<div class="main">
    <div id="printableArea">
        <p>Общий список больных, которым оформлены и не выданы карты</p>
        <c:forEach var="priziv" items="${prizivList}">
            <c:if test="${priziv.illList.size() != 0}">
                <p style="font-weight: bold; margin: 0;">${priziv.commandName}</p>
            </c:if>
                <c:forEach var="fio" items="${priziv.illList}" varStatus="count">
                    <a style="margin-left: 30px">${count.count}. ${fio.fio}</a>
                    <br>
                </c:forEach>
        </c:forEach>
    </div>
    <input type="button" onclick="printDiv('printableArea')" value="Печать" class="btn"/>
</div>
</body>
<script>
    function printDiv(divName) {
        const printContents = document.getElementById(divName).innerHTML;
        const originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }
</script>

</html>

