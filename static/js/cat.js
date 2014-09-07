(function() {
    var $ = function(s) { return document.querySelector(s); };

    $('#select-submit').hidden = true;
    $('#select-cat').onchange = function() {
        $('#select-form').submit();
    };
}());
