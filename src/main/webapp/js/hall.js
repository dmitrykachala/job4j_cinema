let place = 22;
let session = 1;

function init() {
    let table = document.querySelector('.table');
    let places = table.querySelectorAll('input[name=place]');
    let sessionsS = document.querySelectorAll('input[name=session]');
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
    loadHall(session);
}
function payment() {
    document.location="payment.jsp?place=" + place + "&session=" + session;
}
function loadHall(session) {
    $.ajax({
        type: 'GET',
        url: 'hall',
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

window.onload = function() {
    $(document).ready(init());
};
