<%--
    File       : applicationresults.jsp
    Course     : CSD 430
    Author     : Zachary White
    Date       : November 8, 2026
    Professor  : Darrell Payne
    Purpose    : Receives the data posted by application.html and displays it
                 back to the applicant in an HTML table.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter, java.time.LocalDateTime" %>

<%-- SCRIPTLET 1: Read, clean, and format the submitted form data --%>
<%
    // Read the form data as UTF-8 so special characters display correctly
    request.setCharacterEncoding("UTF-8");

    // A direct visit to this page has no form data, so check for it first
    boolean submitted = request.getParameter("fullName") != null;

    // The names of the inputs in application.html, in the order they are displayed
    String[] parameterNames = {
        "fullName", "email", "phone", "portfolio",
        "role", "employmentType", "startDate", "workAuth", "salary",
        "years", "education", "skills", "confirm"
    };

    // Field names shown in the results table
    String[] fieldNames = {
        "Full Name", "Email", "Phone", "Portfolio Link",
        "Position", "Employment Type", "Start Date", "Work Authorization", "Desired Salary",
        "Years of Experience", "Education", "Skills", "Confirmation"
    };

    // A short description of each field
    String[] fieldDescriptions = {
        "The name of the person applying.",
        "The address Iron Soft will use to reply.",
        "The best number to reach the applicant.",
        "An optional link to a portfolio or LinkedIn profile.",
        "The job the applicant is applying for.",
        "Whether the job is full-time, part-time, or contract.",
        "The earliest day the applicant could begin work.",
        "Whether the applicant may legally work in the United States.",
        "The yearly pay the applicant is hoping for.",
        "How many years of IT experience the applicant has.",
        "The highest level of education completed.",
        "The skills the applicant selected.",
        "The applicant confirmed the answers are accurate."
    };

    // The group each field belongs to (used for the heading rows in the table)
    String[] sections = {
        "Personal Information", "Personal Information", "Personal Information", "Personal Information",
        "Position and Availability", "Position and Availability", "Position and Availability",
        "Position and Availability", "Position and Availability",
        "Experience and Skills", "Experience and Skills", "Experience and Skills",
        "Confirmation"
    };

    String[] values = new String[parameterNames.length];
    String[] skillList = new String[0];
    String firstName = "applicant";
    String referenceNumber = "";
    String submittedAt = "";
    int answered = 0;

    if (submitted) {

        // Clean up each answer before it is shown on the page
        for (int i = 0; i < parameterNames.length; i++) {
            String value;

            // The skills checkboxes can have several answers, so join them into one line
            if (parameterNames[i].equals("skills")) {
                String[] selected = request.getParameterValues("skills");
                value = (selected == null) ? "" : String.join(", ", selected);
            } else {
                value = request.getParameter(parameterNames[i]);
            }

            // Use a friendly message when an answer is blank
            if (value == null || value.trim().isEmpty()) {
                value = "Not provided";
            } else {
                answered++;
            }

            // Escape special characters so user input is shown as text and never runs as HTML
            value = value.trim()
                         .replace("&", "&amp;")
                         .replace("<", "&lt;")
                         .replace(">", "&gt;")
                         .replace("\"", "&quot;")
                         .replace("'", "&#39;");
            values[i] = value;
        }

        // Turn the start date into a friendlier format when it is valid (index 6)
        try {
            LocalDate start = LocalDate.parse(request.getParameter("startDate"));
            values[6] = start.format(DateTimeFormatter.ofPattern("MMMM d, yyyy"));
        } catch (Exception e) {
            // Keep the cleaned-up text if the date cannot be read
        }

        // Show the salary as money when it is a valid number (index 8)
        try {
            int salary = Integer.parseInt(request.getParameter("salary"));
            values[8] = String.format("$%,d per year", salary);
        } catch (Exception e) {
            values[8] = "Not provided";
        }

        // Add the word "year" or "years" to the experience number (index 9)
        try {
            int years = Integer.parseInt(request.getParameter("years"));
            values[9] = years + ((years == 1) ? " year" : " years");
        } catch (Exception e) {
            values[9] = "Not provided";
        }

        // Break the joined skills back into a list for the skill badges (index 11)
        if (!values[11].equals("Not provided")) {
            skillList = values[11].split(", ");
        }

        // Use the first word of the name in the greeting if there is one
        if (!values[0].equals("Not provided")) {
            firstName = values[0].split(" ")[0];
        }

        // Make a reference number and a time stamp for the confirmation
        referenceNumber = "IS-" + String.format("%06d", System.currentTimeMillis() % 1000000);
        submittedAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("MMMM d, yyyy 'at' h:mm a"));
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Iron Soft | Application Results</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">
    <%-- The same external stylesheet that styles the form --%>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<div class="results">

    <div class="brand">
        <svg class="brand-mark" viewBox="0 0 32 32" aria-hidden="true">
            <path d="M16 2l12 7v14l-12 7L4 23V9z" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linejoin="round"/>
            <path d="M10 16h12M16 10v12" stroke="currentColor" stroke-width="2.4" stroke-linecap="round"/>
        </svg>
        <span class="brand-name">Iron Soft</span>
    </div>

    <% if (!submitted) { %>

        <%-- Shown when the page is opened without submitting the form --%>
        <section class="card confirm-card">
            <h1>No application received</h1>
            <p>This page shows the answers from the application form, and none were sent yet.</p>
            <a class="again" href="application.html">Start your application</a>
        </section>

    <% } else { %>

        <%-- Title and overall description of the data --%>
        <section class="card confirm-card">
            <h1>Thanks, <%= firstName %>. Your application is in.</h1>
            <p>
                Iron Soft received your application for the position below. This page lists
                every answer you gave, what each field means, and the group it belongs to.
            </p>

            <div class="facts">
                <div class="fact"><b>Reference number</b><span><%= referenceNumber %></span></div>
                <div class="fact"><b>Position</b><span><%= values[4] %></span></div>
                <div class="fact"><b>Start date</b><span><%= values[6] %></span></div>
                <div class="fact"><b>Fields completed</b><span><%= answered %> of <%= parameterNames.length %></span></div>
            </div>

            <% if (skillList.length > 0) { %>
                <div class="skill-row">
                    <% for (int s = 0; s < skillList.length; s++) { %>
                        <span><%= skillList[s] %></span>
                    <% } %>
                </div>
            <% } %>

            <p style="margin-top:1rem;font-size:.85rem">Submitted <%= submittedAt %></p>
        </section>

        <%-- Field and record descriptions with the results table --%>
        <section class="card table-card">
            <h2>Your application details</h2>
            <p>
                Each row is one field from the form. Together, the <%= parameterNames.length %> rows
                make up one record: your complete application.
            </p>

            <div class="table-wrap">
                <table>
                    <caption>Application record <%= referenceNumber %></caption>
                    <thead>
                        <tr>
                            <th>Field</th>
                            <th>Description</th>
                            <th>Your Response</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int r = 0; r < fieldNames.length; r++) { %>

                            <%-- Print a heading row whenever the group changes --%>
                            <% if (r == 0 || !sections[r].equals(sections[r - 1])) { %>
                                <tr class="group"><th colspan="3"><%= sections[r] %></th></tr>
                            <% } %>

                            <tr>
                                <td><%= fieldNames[r] %></td>
                                <td><%= fieldDescriptions[r] %></td>
                                <td><%= values[r] %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <a class="again" href="application.html">Submit another application</a>
        </section>

    <% } %>

    <p class="footer">CSD 430 | Zachary White | Iron Soft is a fictional company made for a class project.</p>
</div>
</body>
</html>
