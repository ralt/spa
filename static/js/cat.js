(function() {
    var $ = function(s) { return document.querySelector(s); };

    $('#select-submit').style.display = 'none';
    $('#select-cat').onchange = function() {
        $('#select-form').submit();
    };

    var typesForm = $('#types');
    handleTypesForm(typesForm);

    function handleTypesForm(typesForm) {
        if (!typesForm) return;

        var inputs = typesForm.querySelectorAll('input');

        for (var i = 0; i < inputs.length; i++) {
            (function(i) {
                inputs[i].onchange = function() {
                    submitTypes();
                };
            }(i));
        }
    }

    function submitTypes() {
        var inputs = typesForm.querySelectorAll('input');
        var finals = [];

        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].checked) {
                finals.push(inputs[i].value);
            }
        }

        window.location.href = window.location.origin + window.location.pathname + '?types=' + finals.join(',');
    }
}());
