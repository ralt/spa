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

    // Legends can be accordions
    var $$ = function(s) { return document.querySelectorAll(s); };
    var legends = $$('legend.collapsible');
    for (var i = 0; i < legends.length; i++) {
        handleCollapsibleLegend(legends[i]);
    }

    function handleCollapsibleLegend(legend) {
        var hidden = false;
        legend.onclick = function() {
            var el = legend.nextSibling;
            while (el = el.nextSibling) {
                if (el.nodeType !== 1) continue;
                
                el.style.display = !hidden ? 'none' : 'block';
                el = el.nextSibling;
            }
            hidden = !hidden;
        };
    }

    var collapsedLegends = $$('legend.collapsible.collapsed');
    for (var i = 0; i < collapsedLegends.length; i++) {
        collapsedLegends[i].click();
    }
}());
