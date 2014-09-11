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
            inputs[i].onchange = submitTypes;
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

    var collapsedLegends = $$('legend.collapsible.collapsed');
    for (var i = 0; i < collapsedLegends.length; i++) {
        collapse(collapsedLegends[i], true);
    }

    var legends = $$('legend.collapsible');
    for (var i = 0; i < legends.length; i++) {
        handleCollapsibleLegend(legends[i]);
    }

    function handleCollapsibleLegend(legend) {
        legend.onclick = function() {
            collapse(legend, legend.classList.contains('opened'));
        };
    }

    function collapse(legend, opened) {
        var el = legend.nextSibling;
        while (el = el.nextSibling) {
            if (el.nodeType !== 1) continue;
            
            el.style.display = opened ? 'none' : '';
            el = el.nextSibling;
        }

        legend.classList[opened ? 'remove' : 'add']('opened');
    }

    function isEllipsisActive(e) {
        return (e.offsetWidth < e.scrollWidth);
    }

    // It's a div because: http://stackoverflow.com/a/14643089/851498
    var divs = $$('.history-table td.comment div');
    for (var i = 0; i < divs.length; i++) {
        handleTableCell(divs[i]);
    }

    function handleTableCell(el) {
        if (!isEllipsisActive(el)) return;

        var open = false;
        el.onclick = function() {
            if (!open) {
                el.style.overflow = 'visible';
                el.style.wordBreak = 'break-word';
                el.style.whiteSpace = 'normal';
            }
            else {
                // Quick & dirty hack to reset the style properties
                el.setAttribute('style', '');
            }
            open = !open;
        };
    }
}());
