/*
   application.js | CSD 430 | Zachary White | November 8, 2026
   Controls the four-step wizard on application.html:
   showing one step at a time, live validation as the user
   types, the progress bar, and the final review step.
 */
(function () {
    'use strict';

    var form = document.getElementById('applicationForm');
    var steps = Array.prototype.slice.call(form.querySelectorAll('.step'));
    var railItems = document.querySelectorAll('#railSteps li');
    var stepLabel = document.getElementById('stepLabel');
    var barFill = document.getElementById('barFill');
    var backBtn = document.getElementById('backBtn');
    var nextBtn = document.getElementById('nextBtn');
    var submitBtn = document.getElementById('submitBtn');
    var salaryOut = document.getElementById('salaryOut');

    var stepNames = ['Personal info', 'Position and availability', 'Experience and skills', 'Review and submit'];

    // The field names that belong to each step
    var stepFields = [
        ['fullName', 'email', 'phone', 'portfolio'],
        ['role', 'employmentType', 'startDate', 'workAuth', 'salary'],
        ['years', 'education', 'skills'],
        ['confirm']
    ];

    var current = 0;
    var touched = {}; // a field only shows errors after the user has interacted with it

    /* ---------- Reading values ---------- */

    // Returns a string for most fields and an array for the skills group
    function getValue(name) {
        var nodes = form.querySelectorAll('[name="' + name + '"]');
        if (!nodes.length) { return ''; }
        var type = nodes[0].type;
        if (type === 'radio') {
            var picked = form.querySelector('[name="' + name + '"]:checked');
            return picked ? picked.value : '';
        }
        if (type === 'checkbox') {
            var list = [];
            Array.prototype.forEach.call(nodes, function (n) { if (n.checked) { list.push(n.value); } });
            return name === 'skills' ? list : (list.length ? list[0] : '');
        }
        return nodes[0].value;
    }

    /* ---------- Validation rules: each returns '' when valid, or a message ---------- */

    var rules = {
        fullName: function (v) {
            v = v.trim();
            if (!v) { return 'Enter your full name.'; }
            if (v.length < 2 || !/^[A-Za-z\u00C0-\u024F][A-Za-z\u00C0-\u024F .'\-]+$/.test(v)) {
                return 'Use letters only, with at least two characters.';
            }
            return '';
        },
        email: function (v) {
            v = v.trim();
            if (!v) { return 'Enter your email address.'; }
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(v)) { return 'Enter an email like name@example.com.'; }
            return '';
        },
        phone: function (v) {
            var digits = v.replace(/\D/g, '');
            if (!v.trim()) { return 'Enter your phone number.'; }
            if (digits.length < 10 || digits.length > 15) { return 'Enter a phone number with at least 10 digits.'; }
            return '';
        },
        portfolio: function (v) {
            v = v.trim();
            if (!v) { return ''; } // optional
            if (!/^https?:\/\/[^\s.]+\.[^\s]{2,}$/i.test(v)) { return 'Start the link with http:// or https://.'; }
            return '';
        },
        role: function (v) { return v ? '' : 'Choose a position.'; },
        employmentType: function (v) { return v ? '' : 'Choose an employment type.'; },
        startDate: function (v) {
            if (!v) { return 'Choose a start date.'; }
            if (v < todayText()) { return 'Choose today or a later date.'; }
            return '';
        },
        workAuth: function (v) { return v ? '' : 'Answer yes or no.'; },
        salary: function () { return ''; },
        years: function (v) {
            if (v === '') { return 'Enter your years of experience.'; }
            var n = Number(v);
            if (!Number.isInteger(n) || n < 0 || n > 40) { return 'Enter a whole number from 0 to 40.'; }
            return '';
        },
        education: function (v) { return v ? '' : 'Choose your education level.'; },
        skills: function (list) { return list.length ? '' : 'Pick at least one skill.'; },
        confirm: function (v) { return v ? '' : 'Check the box to confirm your answers.'; }
    };

    function todayText() {
        var d = new Date();
        var m = ('0' + (d.getMonth() + 1)).slice(-2);
        var day = ('0' + d.getDate()).slice(-2);
        return d.getFullYear() + '-' + m + '-' + day;
    }

    /* ---------- Showing validation state ---------- */

    function wrapperFor(name) {
        return form.querySelector('.field[data-field="' + name + '"]');
    }

    // Validates one field and updates its colors and message
    function check(name, show) {
        var message = rules[name](getValue(name));
        var wrapper = wrapperFor(name);
        if (show && wrapper) {
            var msg = wrapper.querySelector('.msg');
            var empty = getValue(name) === '' || (Array.isArray(getValue(name)) && !getValue(name).length);
            if (message) {
                wrapper.setAttribute('data-state', 'invalid');
                msg.textContent = message;
            } else if (name === 'portfolio' && empty) {
                wrapper.removeAttribute('data-state'); // optional and blank: stay neutral
                msg.textContent = '';
            } else {
                wrapper.setAttribute('data-state', 'valid');
                msg.textContent = '';
            }
        }
        return message;
    }

    function stepIsValid(index) {
        return stepFields[index].every(function (name) { return rules[name](getValue(name)) === ''; });
    }

    // Changes the Continue and Submit buttons from steel to blue once the step is complete
    function updateButtons() {
        var ready = stepIsValid(current);
        nextBtn.setAttribute('data-ready', ready ? 'true' : 'false');
        submitBtn.setAttribute('data-ready', ready ? 'true' : 'false');
    }

    /* ---------- Moving between steps ---------- */

    function show(index) {
        current = index;
        steps.forEach(function (s, i) { s.hidden = (i !== current); });
        Array.prototype.forEach.call(railItems, function (li, i) {
            li.className = i < current ? 'done' : (i === current ? 'active' : '');
        });
        stepLabel.textContent = 'Step ' + (current + 1) + ' of ' + steps.length + ': ' + stepNames[current];

        // The bar fills as steps are reached and heats from steel to orange
        barFill.style.setProperty('--p', ((current + 1) / steps.length * 100) + '%');

        backBtn.hidden = (current === 0);
        nextBtn.hidden = (current === steps.length - 1);
        submitBtn.hidden = (current !== steps.length - 1);

        if (current === steps.length - 1) { buildReview(); }
        updateButtons();

        steps[current].classList.remove('enter');
        void steps[current].offsetWidth; // restarts the entrance animation
        steps[current].classList.add('enter');
        var heading = steps[current].querySelector('h1');
        heading.setAttribute('tabindex', '-1');
        heading.focus({ preventScroll: true });
        window.scrollTo({ top: 0 });
    }

    // Validates every field in a step, showing errors, and returns the first bad field name
    function validateStep(index) {
        var firstBad = '';
        stepFields[index].forEach(function (name) {
            touched[name] = true;
            if (check(name, true) && !firstBad) { firstBad = name; }
        });
        return firstBad;
    }

    function focusField(name) {
        var el = form.querySelector('[name="' + name + '"]');
        if (el) { el.focus(); }
    }

    function goNext() {
        var bad = validateStep(current);
        if (bad) { focusField(bad); updateButtons(); return; }
        show(current + 1);
    }

    /* ---------- Review step ---------- */

    function buildReview() {
        var box = document.getElementById('reviewList');
        box.textContent = '';
        var groups = [
            ['Personal info', 0, [
                ['Full name', getValue('fullName').trim()],
                ['Email', getValue('email').trim()],
                ['Phone', getValue('phone').trim()],
                ['Portfolio link', getValue('portfolio').trim() || 'Not provided']
            ]],
            ['Position and availability', 1, [
                ['Position', getValue('role')],
                ['Employment type', getValue('employmentType')],
                ['Start date', prettyDate(getValue('startDate'))],
                ['Work authorization', getValue('workAuth')],
                ['Desired salary', money(getValue('salary'))]
            ]],
            ['Experience and skills', 2, [
                ['Years of experience', getValue('years')],
                ['Education', getValue('education')],
                ['Skills', getValue('skills').join(', ')]
            ]]
        ];
        groups.forEach(function (g) {
            var card = document.createElement('div');
            card.className = 'review-group';
            var head = document.createElement('div');
            head.className = 'review-head';
            var title = document.createElement('h2');
            title.textContent = g[0];
            var edit = document.createElement('button');
            edit.type = 'button';
            edit.className = 'link';
            edit.textContent = 'Edit';
            edit.addEventListener('click', function () { show(g[1]); });
            head.appendChild(title);
            head.appendChild(edit);
            card.appendChild(head);
            var list = document.createElement('dl');
            g[2].forEach(function (pair) {
                var dt = document.createElement('dt');
                dt.textContent = pair[0];
                var dd = document.createElement('dd');
                dd.textContent = pair[1];
                list.appendChild(dt);
                list.appendChild(dd);
            });
            card.appendChild(list);
            box.appendChild(card);
        });
    }

    // Turns 2027-01-15 into January 15, 2027
    function prettyDate(v) {
        var d = new Date(v + 'T00:00:00');
        return isNaN(d) ? v : d.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
    }

    function money(v) {
        return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(Number(v));
    }

    /* ---------- Event wiring ---------- */

    // Live validation: runs while the user types or changes a field
    function onChange(e) {
        var name = e.target.name;
        if (!name || !rules[name]) { return; }
        touched[name] = true;
        check(name, true);
        updateButtons();
    }
    form.addEventListener('input', onChange);
    form.addEventListener('change', onChange);

    // Show a field's state when the user leaves it
    form.addEventListener('focusout', function (e) {
        var name = e.target.name;
        if (name && rules[name] && touched[name]) { check(name, true); }
    });

    // Salary slider shows its value as money
    form.elements.salary.addEventListener('input', function () {
        salaryOut.textContent = money(this.value);
    });

    // The earliest start date is today
    form.elements.startDate.min = todayText();

    // Enter moves to the next step instead of submitting early
    form.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' && e.target.tagName !== 'BUTTON') {
            e.preventDefault();
            if (current < steps.length - 1) { goNext(); }
        }
    });

    nextBtn.addEventListener('click', goNext);
    backBtn.addEventListener('click', function () { show(current - 1); });

    // Final check before the form is sent to the JSP
    form.addEventListener('submit', function (e) {
        for (var i = 0; i < steps.length; i++) {
            var bad = validateStep(i);
            if (bad) {
                e.preventDefault();
                show(i);
                focusField(bad);
                return;
            }
        }
    });

    show(0);
})();
