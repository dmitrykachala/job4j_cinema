<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

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

    <title>Билеты в кино</title>
</head>
<body>

<div class="container">

    <div>
        <tr><input type="radio" name="session" value="1" checked> Сеанс 1</tr>
    </div>
    <div>
        <tr><input type="radio" name="session" value="2"> Сеанс 2</tr>
    </div>

    <div class="row pt-3">
        <h4>
            Бронирование места на сеанс
        </h4>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th style="width: 120px;">Ряд / Место</th>
                <th>1</th>
                <th>2</th>
                <th>3</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th>1</th>
                <td><input type="radio" name="place" value="11"> Ряд 1, Место 1</td>
                <td><input type="radio" name="place" value="12"> Ряд 1, Место 2</td>
                <td><input type="radio" name="place" value="13"> Ряд 1, Место 3</td>
            </tr>
            <tr>
                <th>2</th>
                <td><input type="radio" name="place" value="21"> Ряд 2, Место 1</td>
                <td><input type="radio" name="place" value="22"> Ряд 2, Место 2</td>
                <td><input type="radio" name="place" value="23"> Ряд 2, Место 3</td>
            </tr>
            <tr>
                <th>3</th>
                <td><input type="radio" name="place" value="31"> Ряд 3, Место 1</td>
                <td><input type="radio" name="place" value="32"> Ряд 3, Место 2</td>
                <td><input type="radio" name="place" value="33"> Ряд 3, Место 3</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row float-right">
        <button type="button" class="btn btn-success" onclick="payment();">Оплатить</button>
    </div>
</div>

<script>

    let table = document.querySelector('.table');
    let places = table.querySelectorAll('input[name=place]');
    let place = 22;

    let sessionsS = document.querySelectorAll('input[name=session]');
    let session = 1;

    places.forEach((i,l)=>{
        i.addEventListener('change', function (event) {
            event.preventDefault();

            for (let i = 0; i < places.length; i++) {
                if (places[i].checked) {
                    console.log(places[i].value);
                    place = places[i].value;
                }
            }
        })
    });

    sessionsS.forEach((i,l)=>{
        i.addEventListener('change', function (event) {
            event.preventDefault();

            for (let i = 0; i < sessionsS.length; i++) {
                if (sessionsS[i].checked) {
                    console.log(sessionsS[i].value);
                    session = sessionsS[i].value;
                }
            }

            loadHall(session);
        })
    });

    function payment() {
        document.location="payment.jsp?place=" + place + "&session=" + session;
    }

    function loadHall(session) {
        $.ajax({
            type: 'GET',
            url: '<c:url value="/hall"/>',
            dataType: 'json'
        }).done(function (data) {
            let radios = document.getElementsByName('place');

            for (radio of radios) {
                if (radio.disabled) {
                    radio.disabled = false;
                }
            }

            for (var ticket of data) {
                for (radio of radios) {
                    if (radio.value == (ticket.row.toString() + ticket.cell.toString())
                        && session == ticket.sessionId) {
                        radio.disabled = true;
                    }
                }
            }
        }).fail(function (err) {
            $('#hello').text("Smth wrong");
        });
    }

    $(document).ready(loadHall(session));

</script>

</body>
</html>