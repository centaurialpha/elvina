
.pragma library

var URL_API = "http://127.0.0.1:8000/api/"
var USERNAME = ""

function makeRequest(url, method, params, callback) {
    var request = new XMLHttpRequest();
    request.onreadystatechange = (function(r){
        return function() {
            if(r.readyState === 4) callback(r)
        }
    })(request)
    var parameters = ""
    for(var p in params) {
        parameters += p + "=" + params[p] + "&"
    }

    parameters = parameters.slice(0, -1)
    request.open(method, URL_API + url, true)
    if(method === "POST") {
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        request.setRequestHeader("Content-length", parameters.length);
        request.send(parameters)
    } else {
        request.send()
    }
}

function makeAuth(user, pass) {
    var token = user + ":" + pass;
    var hash = Qt.btoa(token);
    return "Basic " + hash;
}


function registerNewUser(bu, db, nombre, username, contacto) {
    bu.running = true
    var req = new XMLHttpRequest();
    var error = [false, "Gracias !"]
    req.onreadystatechange = function() {
        if(req.readyState == 4) {
            console.debug(req.status)
            if(req.status == 200) {
                console.debug("OK")
                USERNAME = username;
                saveUserOnDB(db, nombre, username);
            } else {
                if( req.responseText.length == 0) {
                    error = [true, "Algo ha salido mal :("]
                } else {
                    error = [true, JSON.parse(req.responseText)["detalle"]]
                }
            }
            bu.running = false
            return error;
        } else {
            console.debug("LALALA")
        }
    }
    var params = "nombre=" + nombre + "&username=" + username + "&contacto=" + contacto;
    req.open("POST", URL_API + "register/", true);
    req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    req.setRequestHeader("Content-length", params.length);
    req.send(params);
//    return error;
}

function saveUserOnDB(db, nombre, user) {
    db.transaction(function(t){
        t.executeSql("INSERT INTO Usuarias VALUES(?, ?)", [nombre, user])
    })
}
