function sendJsonRequest(url, callback) {
    let request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            let response = {
                status: request.status,
                headers: request.getAllResponseHeaders(),
                contentType: request.responseType,
                content: JSON.parse(request.response)
            };

            callback(response);
        }
    }

    request.open("GET", url);
    request.send();
}

function padTo2Digits(num) {
    return String(num).padStart(2, '0');
}

function isConfigDefault() {
    return nightscoutURL == "https://appname.herokuapp.com" && nightscoutToken == "plasmoid-0000000"
}
