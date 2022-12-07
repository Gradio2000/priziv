<%--
  Created by IntelliJ IDEA.
  User: aleksejlaskin
  Date: 15.11.2022
  Time: 12:25
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

  <title>Призыв</title>
</head>
<body>
<div class="main">
  <table>
    <tr>
      <th style="width: 40px">№ п/п</th>
      <th>Команда</th>
      <th>Дата прибытия</th>
      <th>Количество человек</th>
      <th>Паспорта получены</th>
      <th>Информация введена в САБС</th>
      <th>Выдано, количество</th>
      <th>Оформлено, но не выдано, количество</th>
      <th>Дата убытия</th>
    </tr>
    <c:forEach var="priziv" items="${prizivList}" varStatus="count">
      <form id="prizivForm${priziv.prizivId}">
        <input type="hidden" name="prizivId" value="${priziv.prizivId}">
        <input type="hidden" name="commandName" value="${priziv.commandName}">
        <input type="hidden" name="peopleAmmount" value="${priziv.peopleAmmount}">
        <c:if test="${priziv.issued > 0}">
          <tr style="background: #ccfcff">
            <td>${count.count}</td>
            <td>${priziv.commandName}</td>
            <td>
              <input type="date" class="myinput" name="dateArrival" value="${priziv.dateArrival}"
                     onchange="editPriziv(${priziv.prizivId})" style="margin: 0; padding: 0; background: border-box"/>
            </td>
            <td>${priziv.peopleAmmount}</td>
            <td>
              <c:if test="${priziv.getPassports}">
                <input type="checkbox" name="getPassports" checked onchange="editPriziv(${priziv.prizivId})">
              </c:if>
              <c:if test="${!priziv.getPassports}">
                <input type="checkbox" name="getPassports" onchange="editPriziv(${priziv.prizivId})">
              </c:if>
            </td>
            <td>
              <c:if test="${priziv.processed}">
                <input type="checkbox" name="processed" checked onchange="editPriziv(${priziv.prizivId})">
              </c:if>
              <c:if test="${!priziv.processed}">
                <input type="checkbox" name="processed" onchange="editPriziv(${priziv.prizivId})">
              </c:if>
            </td>
            <td>
              <input type="number" min="0" class="myinput" name="issued" value="${priziv.issued}"
                     onchange="editPriziv(${priziv.prizivId})" style="margin: 0; padding: 0; background: border-box">
            </td>
            <td>
              <button id="${priziv.prizivId}" type="button" class="btn" style="margin: 0"
                      onclick="openModalIlled(this.id)">${priziv.illList.size()}</button>
            </td>
            <td>
              <input type="date" class="myinput" name="dateDeparture" value="${priziv.dateDeparture}"
                     onchange="editPriziv(${priziv.prizivId})" style="margin: 0; padding: 0; background: border-box"/>
            </td>
          </tr>
        </c:if>
        <c:if test="${priziv.issued == 0}">
          <tr>
            <td>${count.count}</td>
            <td>${priziv.commandName}</td>
            <td>
              <input type="date" class="myinput" name="dateArrival" value="${priziv.dateArrival}"
                     onchange="editPriziv(${priziv.prizivId})" style="margin: 0; padding: 0"/>
            </td>
            <td>${priziv.peopleAmmount}</td>
            <td>
              <c:if test="${priziv.getPassports}">
                <input type="checkbox" name="getPassports" checked onchange="editPriziv(${priziv.prizivId})">
              </c:if>
              <c:if test="${!priziv.getPassports}">
                <input type="checkbox" name="getPassports" onchange="editPriziv(${priziv.prizivId})">
              </c:if>
            </td>
            <td>
              <c:if test="${priziv.processed}">
                <input type="checkbox" name="processed" checked onchange="editPriziv(${priziv.prizivId})">
              </c:if>
              <c:if test="${!priziv.processed}">
                <input type="checkbox" name="processed" onchange="editPriziv(${priziv.prizivId})">
              </c:if>
            </td>
            <td>
              <input type="number" min="0" class="myinput" name="issued" value="${priziv.issued}"
                     onchange="editPriziv(${priziv.prizivId})" style="margin: 0; padding: 0">
            </td>
            <td>
              <button id="${priziv.prizivId}" type="button" class="btn" style="margin: 0"
                      onclick="openModalIlled(this.id)">${priziv.illList.size()}</button>
            </td>
            <td>
              <input type="date" class="myinput" name="dateDeparture" value="${priziv.dateDeparture}"
                     onchange="editPriziv(${priziv.prizivId})" style="margin: 0; padding: 0"/>
            </td>
          </tr>
        </c:if>
      </form>
    </c:forEach>
    <tr>
      <td colspan="3">ИТОГО</td>
      <td>${totalPeopleAmount}</td>
      <td>X</td>
      <td>X</td>
      <td id="totalIssued">${totalIssued}</td>
      <td id="totalNotIssued">${totalNotIssued}</td>
      <td>X</td>
    </tr>
  </table>
  <button type="button" class="btn" onclick="document.location='#openModal'">Добавить</button>
  <button type="button" class="btn" onclick="document.location='/priziv/ill'">Список больных</button>

    <div id="openModal" class="modal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">Добавить команду</h3>
            <a href="#close" title="Close" class="close">×</a>
          </div>
          <div class="modal-body my-modal">
            <form method="post" action="/addPriziv">
              <input name="prizivId" type="hidden"/>
              <input name="commandName" placeholder="Название команды"/>
              <input type="number" name="peopleAmmount" placeholder="Количество человек"/>
              <label class="mylabel-forkanban"> Дата прибытия
                <input type="date" name="dateArrival" style="margin: 0"/>
              </label>
              <label class="mylabel-forkanban"> Дата убытия
                <input type="date" name="dateDeparture" style="margin: 0;"/>
              </label>
              <br/>
              <button type="submit" class="btn">Отправить</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div id="openModal1" class="modal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Добавить/удалить больного</h3>
          <a title="Close" class="close" onclick="closeModal()">×</a>
        </div>
        <div class="modal-header">
          <h5 class="modal-title" id="commandName"></h5>
        </div>
        <div class="modal-body my-modal">
          <label id="labelMembers" class="mylabel-forkanban">Больные:
            <ul id="membersBlock" class="membersBlock"></ul>
          </label>
          <form id="illForm">
            <input id="prizivIdNumber" name="prizivId" type="hidden"/>
            <input id="nameInput" name="fio" placeholder="Введите фамилию"/>
            <br/>
            <button type="button" class="btn" onclick="addIlled()">Записать</button>
          </form>
        </div>
      </div>
    </div>
  </div>

</div>
</body>
</html>
<script>
  function openModalIlled(prizivId) {
    $.ajax({
      type: 'GET',
      url: '/priziv/' + prizivId,
      data: {"prizivId": prizivId},
      success: function (data) {
        getMemberBlock(data);
        document.getElementById("prizivIdNumber").setAttribute("value", prizivId);
        document.getElementById("commandName").innerText = data.commandName;
        document.location='#openModal1';
      },
      error: function () {
        alert('Ошибка! function openModalIlled(prizivId)');
      }
    });
}

  function addIlled() {
    if ($('#nameInput').val() === ''){
      alert("Введите фамилию!")
      return;
    }
    const msg = $('#illForm').serialize();
    $.ajax({
      type: 'POST',
      url: '/priziv/addIlled',
      data: msg,
      success: function (data) {
        $("#nameInput").val('');
        getMemberBlock(data);
      },
      error: function () {
        alert('Ошибка!');
      }
    });

  }

  function editPriziv(id){
    const msg = document.getElementById("prizivForm" + id);
    console.log(msg);
    let d = $(msg).serializeArray();
    $.ajax({
      type: 'POST',
      url: '/priziv/change',
      data: d,
      success: function (data) {
        let totalIssued = document.getElementById("totalIssued");
        totalIssued.innerText = data;
      },
      error: function () {
        alert('Ошибка изменения записи! Обратитесь к администратору! function editPriziv(id)');
      }
    });
  }

  function getMemberBlock(data){
    // <ul id="membersBlock" class="membersBlock"><li class="member">Петрова И.Н.</li></ul>
    $('.contain').remove();
    let membersBlock = document.getElementById("membersBlock");
    for (let i = 0; i < data.illList.length; i++){
      let contain = document.createElement("div");
      contain.className = "contain";
      contain.id = "cont" + data.illList[i].id;
      let member = document.createElement("li");
      member.innerText = data.illList[i].fio;
      member.className = "member";

      let del = document.createElement("a");
      del.className = "del";
      del.innerText = "X";
      del.id = data.illList[i].id;
      del.setAttribute("onclick", "delMember(this.id, " + data.prizivId + ")");

      contain.append(del);
      contain.append(member);
      membersBlock.append(contain);
    }
    document.getElementById("labelMembers").append(membersBlock);
  }

  function closeModal(){
    let prizivId = document.getElementById("prizivIdNumber").getAttribute("value");
    $.ajax({
      type: 'GET',
      url: '/prizivWithTotalIssued/' + prizivId,
      success: function (data) {
        document.location = '#close';
        document.getElementById(prizivId).innerText = data.priziv.illList.length;
        document.getElementById("totalNotIssued").innerText = data.totalNotIssued;
      },
      error: function () {
        alert('Ошибка изменения записи! Обратитесь к администратору! \n function closeModal()');
      }
    });
  }

  function delMember(illedId, prizivId){
    $.ajax({
      type: 'POST',
      url: '/priziv/deleteIlled',
      data: {"illedId": illedId, "prizivId": prizivId},
      success: function (data){
        getMemberBlock(data);
      },
      error: function (){
        alert("Ошибка удаления данных. Обратитесь к администратору. \n function delMember(illId, prizivId)");
      }
    });
  }
</script>

