"use strict";
let cont   = {doc:'', sig:''},
    flag   = {doc:false, sig:false},
    pubkey = '',
    mess   = '';

// Чтение файлов документа (как бинарного),
// ключа и подписи (как текстовых)
const readDoc = contKey => {
    let reader = new FileReader();
    reader.onload  = async e => {
        cont[contKey] = contKey == "sig" ?
                        e.target.result :
                        new Uint8Array(e.target.result);
        flag[contKey] = true;
        pubkey = await (await fetch("public.key")).text();   
        if (flag["doc"] && flag["sig"])
            document.querySelector("button").disabled = false;
    }
    reader.onerror = err => alert("Ошибка чтения файла");

    let fileObj = document.querySelector(`#${contKey}`).files[0];
    if (contKey == "sig") reader.readAsText(fileObj);
    else                  reader.readAsArrayBuffer(fileObj);
}

// Верификация подписи
const check = async () => {
    try {   
       const verified = await openpgp.verify({
           message:    openpgp.message.fromBinary(cont["doc"]),
           signature:  await openpgp.signature.readArmored(cont["sig"]),
           publicKeys: (await openpgp.key.readArmored(pubkey)).keys
       });
       const {valid} = verified.signatures[0];
       mess = "Электронная подпись НЕ является подлинной!";
       if (valid) mess = "Электронная подпись является подлинной.";
    } catch(e) {mess = "Файл подписи имеет недопустимый формат.";}
    document.querySelector("output").innerHTML = mess;
}