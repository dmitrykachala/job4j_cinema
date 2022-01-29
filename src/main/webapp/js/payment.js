function initPay() {
    let form = document.querySelector('.formForSend');
    let validateBtn = form.querySelector('.validateBtn');
    let username = form.querySelector(".username");
    let phone = form.querySelector(".phone");
    let email = form.querySelector('.email')
    let fields = form.querySelectorAll(".field");

    form.addEventListener('submit', function (event) {
        event.preventDefault();

        let errors = form.querySelectorAll(".error");
        let err = false;

        for (let i = 0; i < errors.length; i++) {
            errors[i].remove();
        }

        for (let i = 0; i < fields.length; i++) {
            if (!fields[i].value) {
                err = true;
                let error = document.createElement("div");
                error.className = "error";
                error.style.color = "red";
                error.innerHTML = "Поле не может быть пустым";
                form[i].parentElement.insertBefore(error, fields[i]);
            }
        }
        if (!err) {
            form.submit();
        }
    })
}

window.onload = function() {
    $(document).ready(initPay());
};