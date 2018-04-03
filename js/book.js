// Fix back button cache problem
window.onunload = function () { };

// (function themes() {
//     var html = document.querySelector('html');
//     var themeToggleButton = document.getElementById('theme-toggle');
//     var themePopup = document.getElementById('theme-list');
//     var themeColorMetaTag = document.querySelector('meta[name="theme-color"]');
//     var stylesheets = {
//         ayuHighlight: document.querySelector("[href='ayu-highlight.css']"),
//         tomorrowNight: document.querySelector("[href='tomorrow-night.css']"),
//         highlight: document.querySelector("[href='highlight.css']"),
//     };

//     function showThemes() {
//         themePopup.style.display = 'block';
//         themeToggleButton.setAttribute('aria-expanded', true);
//         themePopup.querySelector("button#" + document.body.className).focus();
//     }

//     function hideThemes() {
//         themePopup.style.display = 'none';
//         themeToggleButton.setAttribute('aria-expanded', false);
//         themeToggleButton.focus();
//     }

//     function set_theme(theme) {
//         let ace_theme;

//         if (theme == 'coal' || theme == 'navy') {
//             stylesheets.ayuHighlight.disabled = true;
//             stylesheets.tomorrowNight.disabled = false;
//             stylesheets.highlight.disabled = true;

//             ace_theme = "ace/theme/tomorrow_night";
//         } else if (theme == 'ayu') {
//             stylesheets.ayuHighlight.disabled = false;
//             stylesheets.tomorrowNight.disabled = true;
//             stylesheets.highlight.disabled = true;

//             ace_theme = "ace/theme/tomorrow_night";
//         } else {
//             stylesheets.ayuHighlight.disabled = true;
//             stylesheets.tomorrowNight.disabled = true;
//             stylesheets.highlight.disabled = false;

//             ace_theme = "ace/theme/dawn";
//         }

//         setTimeout(function () {
//             themeColorMetaTag.content = getComputedStyle(document.body).backgroundColor;
//         }, 1);

//         if (window.ace && window.editors) {
//             window.editors.forEach(function (editor) {
//                 editor.setTheme(ace_theme);
//             });
//         }

//         var previousTheme;
//         try { previousTheme = localStorage.getItem('mdbook-theme'); } catch (e) { }
//         if (previousTheme === null || previousTheme === undefined) { previousTheme = 'light'; }

//         try { localStorage.setItem('mdbook-theme', theme); } catch (e) { }

//         document.body.className = theme;
//         html.classList.remove(previousTheme);
//         html.classList.add(theme);
//     }

//     // Set theme
//     var theme;
//     try { theme = localStorage.getItem('mdbook-theme'); } catch(e) { }
//     if (theme === null || theme === undefined) { theme = 'light'; }

//     set_theme(theme);

//     themeToggleButton.addEventListener('click', function () {
//         if (themePopup.style.display === 'block') {
//             hideThemes();
//         } else {
//             showThemes();
//         }
//     });

//     themePopup.addEventListener('click', function (e) {
//         var theme = e.target.id || e.target.parentElement.id;
//         set_theme(theme);
//     });

//     themePopup.addEventListener('focusout', function(e) {
//         // e.relatedTarget is null in Safari and Firefox on macOS (see workaround below)
//         if (!!e.relatedTarget && !themePopup.contains(e.relatedTarget)) {
//             hideThemes();
//         }
//     });

//     // Should not be needed, but it works around an issue on macOS & iOS: https://github.com/rust-lang-nursery/mdBook/issues/628
//     document.addEventListener('click', function(e) {
//         if (themePopup.style.display === 'block' && !themeToggleButton.contains(e.target) && !themePopup.contains(e.target)) {
//             hideThemes();
//         }
//     });

//     document.addEventListener('keydown', function (e) {
//         if (e.altKey || e.ctrlKey || e.metaKey || e.shiftKey) { return; }
//         if (!themePopup.contains(e.target)) { return; }

//         switch (e.key) {
//             case 'Escape':
//                 e.preventDefault();
//                 hideThemes();
//                 break;
//             case 'ArrowUp':
//                 e.preventDefault();
//                 var li = document.activeElement.parentElement;
//                 if (li && li.previousElementSibling) {
//                     li.previousElementSibling.querySelector('button').focus();
//                 }
//                 break;
//             case 'ArrowDown':
//                 e.preventDefault();
//                 var li = document.activeElement.parentElement;
//                 if (li && li.nextElementSibling) {
//                     li.nextElementSibling.querySelector('button').focus();
//                 }
//                 break;
//             case 'Home':
//                 e.preventDefault();
//                 themePopup.querySelector('li:first-child button').focus();
//                 break;
//             case 'End':
//                 e.preventDefault();
//                 themePopup.querySelector('li:last-child button').focus();
//                 break;
//         }
//     });
// })();

(function sidebar() {
    var html = document.querySelector("html");
    var sidebar = document.getElementById("sidebar");
    var sidebarLinks = document.querySelectorAll('#sidebar a');
    var sidebarToggleButton = document.getElementById("sidebar-toggle");
    var firstContact = null;

    function showSidebar() {
        html.classList.remove('sidebar-hidden')
        html.classList.add('sidebar-visible');
        Array.from(sidebarLinks).forEach(function (link) {
            link.setAttribute('tabIndex', 0);
        });
        sidebarToggleButton.setAttribute('aria-expanded', true);
        sidebar.setAttribute('aria-hidden', false);
        try { localStorage.setItem('mdbook-sidebar', 'visible'); } catch (e) { }
    }

    function hideSidebar() {
        html.classList.remove('sidebar-visible')
        html.classList.add('sidebar-hidden');
        Array.from(sidebarLinks).forEach(function (link) {
            link.setAttribute('tabIndex', -1);
        });
        sidebarToggleButton.setAttribute('aria-expanded', false);
        sidebar.setAttribute('aria-hidden', true);
        try { localStorage.setItem('mdbook-sidebar', 'hidden'); } catch (e) { }
    }

    // Toggle sidebar
    sidebarToggleButton.addEventListener('click', function sidebarToggle() {
        if (html.classList.contains("sidebar-hidden")) {
            showSidebar();
        } else if (html.classList.contains("sidebar-visible")) {
            hideSidebar();
        } else {
            if (getComputedStyle(sidebar)['transform'] === 'none') {
                hideSidebar();
            } else {
                showSidebar();
            }
        }
    });

    document.addEventListener('touchstart', function (e) {
        firstContact = {
            x: e.touches[0].clientX,
            time: Date.now()
        };
    }, { passive: true });

    document.addEventListener('touchmove', function (e) {
        if (!firstContact)
            return;

        var curX = e.touches[0].clientX;
        var xDiff = curX - firstContact.x,
            tDiff = Date.now() - firstContact.time;

        if (tDiff < 250 && Math.abs(xDiff) >= 150) {
            if (xDiff >= 0 && firstContact.x < Math.min(document.body.clientWidth * 0.25, 300))
                showSidebar();
            else if (xDiff < 0 && curX < 300)
                hideSidebar();

            firstContact = null;
        }
    }, { passive: true });

    // Scroll sidebar to current active section
    var activeSection = sidebar.querySelector(".active");
    if (activeSection) {
        sidebar.scrollTop = activeSection.offsetTop;
    }
})();

(function chapterNavigation() {
    document.addEventListener('keydown', function (e) {
        if (e.altKey || e.ctrlKey || e.metaKey || e.shiftKey) { return; }
        if (window.search && window.search.hasFocus()) { return; }

        switch (e.key) {
            case 'ArrowRight':
                e.preventDefault();
                var nextButton = document.querySelector('.nav-chapters.next');
                if (nextButton) {
                    window.location.href = nextButton.href;
                }
                break;
            case 'ArrowLeft':
                e.preventDefault();
                var previousButton = document.querySelector('.nav-chapters.previous');
                if (previousButton) {
                    window.location.href = previousButton.href;
                }
                break;
        }
    });
})();

(function scrollToTop () {
    var menuTitle = document.querySelector('.menu-title');

    menuTitle.addEventListener('click', function () {
        document.scrollingElement.scrollTo({ top: 0, behavior: 'smooth' });
    });
})();

(function autoHideMenu() {
    var menu = document.getElementById('menu-bar');

    var previousScrollTop = document.scrollingElement.scrollTop;

    document.addEventListener('scroll', function () {
        if (menu.classList.contains('folded') && document.scrollingElement.scrollTop < previousScrollTop) {
            menu.classList.remove('folded');
        } else if (!menu.classList.contains('folded') && document.scrollingElement.scrollTop > previousScrollTop) {
            menu.classList.add('folded');
        }

        if (!menu.classList.contains('bordered') && document.scrollingElement.scrollTop > 0) {
            menu.classList.add('bordered');
        }

        if (menu.classList.contains('bordered') && document.scrollingElement.scrollTop === 0) {
            menu.classList.remove('bordered');
        }

        previousScrollTop = document.scrollingElement.scrollTop;
    }, { passive: true });
})();
