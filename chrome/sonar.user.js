// ==UserScript==
// @name           Sonar
// @description    Enhancements for Sonar.
// @version        0.1
// @downloadURL    https://raw.github.com/Godin/dotfiles/master/chrome/sonar.user.js
// @match          http://dory.internal.sonarsource.com/drilldown/violations/*
// @run-at         document-end
// ==/UserScript==

function addJQuery(callback) {
  var script = document.createElement("script");
  script.setAttribute("src", "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js");
  script.addEventListener('load', function() {
    var script = document.createElement("script");
    script.textContent = "(" + callback.toString() + ")();";
    document.body.appendChild(script);
  }, false);
  document.body.appendChild(script);
}

// the guts of this userscript
function main() {
    J = jQuery.noConflict(true);

    // add custom CSS
    J("head").append("<style>.violation-selected {border: 1px solid #000000; }</style>");

    function show(element) {
        var elem_top = J(element).offset()['top'];
        var viewport_height = J(window).height();
        var my_scroll = elem_top - (viewport_height / 2);
        J(window).scrollTop(my_scroll);
    }

    document.addEventListener('keydown', function(evt) {
        if (event.altKey ||  event.ctrlKey || event.metaKey || event.shiftKey) {
            return;
        }
        switch (evt.keyCode) {
            case 74: // j = next
                var violations = document.getElementsByClassName("violation");
                if (J(".violation-selected").length == 0) {
                    window.selection = -1;
                }
                if (window.selection + 1 < violations.length) {
                    // go to the next violation
                    J(".violation-selected").removeClass("violation-selected");
                    window.selection++;
                    J(violations[window.selection]).parent().addClass("violation-selected");
                    show(violations[window.selection]);
                } else {
                    // go to the next file
                    J("#col_2 .selected").next().find("a").eq(1).trigger("click");
                }
                break;
            case 75: // k == previous
                var violations = document.getElementsByClassName("violation");
                if (J(".violation-selected").length == 0) {
                    window.selection = 1;
                }
                if (window.selection - 1 >= 0) {
                    // go to the previous violation
                    J(".violation-selected").removeClass("violation-selected");
                    window.selection--;
                    J(violations[window.selection]).parent().addClass("violation-selected");
                    show(violations[window.selection]);
                } else {
                    // go to the previous file
                    J("#col_2 .selected").prev().find("a").eq(1).trigger("click");
                }
                break;
            case 82: // r = resolve/reopen
                var selection = J(".violation-selected");
                if (selection.find("a[name='bResolved']").length) {
                    selection.find("a[name='bResolved']").trigger("click")
                    .delay(200).queue(function(nxt) {
                        selection.find("input[value='Resolved']").trigger("click");
                        nxt(); // continue the queue
                    });
                } else {
                    selection.find("a[name='bReopen']").trigger("click")
                    .delay(200).queue(function(nxt) {
                        selection.find("input[value='Reopen']").trigger("click");
                        nxt(); // continue the queue
                    });
                }
                break;
            case 80: // p = plan
                if (J("select[name='action_plan_id']").length) {
                    // commit
                    J(".violation-selected").find("input[value='Link']").trigger("click");
                } else {
                    J(".violation-selected").find("a[name='bLinkActionPlan']").trigger("click")
                    .delay(200).queue(function(nxt) {
                        J("select[name='action_plan_id']").focus();
                        nxt(); // continue the queue
                    });
                }
                break;
            default:
                //alert('Key: ' + evt.keyCode);
                break;
        }
    }, false);
}

// load jQuery and execute the main function
addJQuery(main);
