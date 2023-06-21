var kullanicilar = [
    {email:"oya@x.com",sifre:"12345"},
    {email:"ata@x.com",sifre:"12345"}
]

var tivitler = [
    {email:"oya@x.com",tivit:"Ankara'da yaz gelmedi!"},
    {email:"ata@x.com",tivit:"Holly diver!"},
    {email:"oya@x.com",tivit:"Sad But TRUE!"}
]

var email = prompt("email?")
var sifre = prompt("sifre?")

function giris(){
    if((email == kullanicilar[0].email && sifre == kullanicilar[0].sifre)||
    (email == kullanicilar[0].email && sifre == kullanicilar[0].sifre)){
        console.log(tivitler)
    }else{
        console.log("Kullanıcı adı veya şifresi hatalı!")
    }
}

giris(email,sifre)