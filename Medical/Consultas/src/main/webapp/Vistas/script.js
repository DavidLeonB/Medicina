const btnSingIn = document.getElementById("sign-in"),
      btnSingUp= document.getElementById("sign-up"),
      formRegister= document.querySelector(".register"),
      formLogin = document.querySelector(".login");

      btnSingIn.addEventListener("click", () => {
        formRegister.classList.add('hide');
        formLogin.classList.remove('hide');
});

btnSingUp.addEventListener("click", () => {
    formLogin.classList.add('hide');
    formRegister.classList.remove('hide');
});



