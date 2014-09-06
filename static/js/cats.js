(function() {
    var $ = function(s) { return document.querySelector(s); };
    var $$ = function(s) { return document.querySelectorAll(s); };

    $('#select-cat').addEventListener('change', goToCat);

    function goToCat() {
        window.location.href = '/cat/' + this.value;
    }
}());
