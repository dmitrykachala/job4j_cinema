<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<%
    String place = request.getParameter("place");
    String sess = request.getParameter("session");
    String row = place.substring(0, 1);
    String cell = place.substring(1);
%>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Билеты в кино / Покупка</title>
</head>
<body>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

<script src="js/payment.js" ></script>

<div class="container">
    <div class="row pt-3">
        <h3>
            Вы выбрали ряд <%=row%> место <%=cell%>, Сумма : 500 рублей.
        </h3>
    </div>
    <div class="row">
        <form class="formForSend" action="<%=request.getContextPath()%>/hall" method="post">

            <input type="hidden" class="row field" name="row" value="<%=row%>">
            <input type="hidden" class="cell field" name="cell" value="<%=cell%>">
            <input type="hidden" class= "session field" name="session" value="<%=sess%>">

            <div class="form-group">
                <label for="username">ФИО</label>
                <input type="text" class="username field" id="username" name="username" placeholder="ФИО">
            </div>
            <div class="form-group">
                <label for="username">Email</label>
                <input type="text" class="email field" id="email" name="email" placeholder="email">
            </div>
            <div class="form-group">
                <label for="phone">Номер телефона</label>
                <input type="text" class="phone field" id="phone" name="phone" placeholder="Номер телефона">
            </div>
            <button type="submit" class="validateBtn">Оплатить</button>
        </form>
    </div>
</div>

</body>
</html>
