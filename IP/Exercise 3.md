This lab exercise involves setting up a Java Web Application using Gradle. To make this work in VS Code, we need to organize your files into a standard Maven/Gradle directory structure so the compiler can find them.

Below is the aligned code and the setup instructions.

1. The Complete Aligned Code
Project Structure
To run this, your VS Code folder must look like this:

build.gradle (The configuration file)

src/main/java/tutorial/HomeController.java

src/main/webapp/WEB-INF/tags/page.tag (This is your first block of code)

src/main/webapp/WEB-INF/jsp/home.jsp

File 1: build.gradle
Create this in the root folder.

Gradle
plugins {
    id 'war'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'javax.servlet:javax.servlet-api:3.1.0'
    implementation 'javax.servlet:jstl:1.2'
    implementation 'org.slf4j:slf4j-api:1.7.30'
    implementation 'org.slf4j:slf4j-simple:1.7.30'
}
File 2: src/main/webapp/WEB-INF/tags/page.tag
This is the first code block you provided (the template).

Java
<%@tag description="Default Page template" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="title" required="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stormpath Webapp Sample | <c:out value="${!empty title ? title : ''}"/></title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="header">
        <ul class="nav nav-pills pull-right">
            <c:set var="uri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
            <li <c:if test="${fn:endsWith(uri,'/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/">Home</a></li>
            <c:choose>
                <c:when test="${!empty account}">
                    <li <c:if test="${fn:endsWith(uri,'dashboard')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li <c:if test="${fn:endsWith(uri,'login')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/login">Login</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
        <h3 class="text-muted">Stormpath Webapp Sample</h3>
    </div>
    <jsp:doBody/>
</div>
</body>
</html>
File 3: src/main/webapp/WEB-INF/jsp/home.jsp
This is your Home.jsp block.

Java
<%@ page session="false"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:page>
    <jsp:attribute name="title">Welcome!</jsp:attribute>
    <jsp:body>
        <div class="jumbotron" id="welcome">
            <h1>Welcome to the Stormpath Webapp Sample Application!</h1>
            <p class="lead">
                <br/><br/>
                Welcome to this <i>gloriously simple</i>
                <a href="https://docs.stormpath.com/java/servlet-plugin/">Stormpath Java Webapp</a> sample application!
                <ul>
                    <li>First, take a look through this very basic site.</li>
                    <li>Then, check out this project’s source code <a href="https://github.com/stormpath/stormpath-sdk-java/examples/servlet">on GitHub</a>.</li>
                    <li>Lastly, integrate Stormpath into your own sites!</li>
                </ul>
            </p>
            <br/><br/>
            <h2>What This Sample App Demonstrates</h2>
            <br/><br/>
            <p>This simple application demonstrates how easy it is to register, login, and securely authenticate users on your website using the Stormpath Servlet Plugin.</p>
            <p>Not a Stormpath user yet? <a href="https://stormpath.com">Go signup now!</a></p>
            <br/><br/>
            <p class="bigbutton"><a class="btn btn-lg btn-danger" href="${pageContext.request.contextPath}/register" role="button">Register</a></p>
        </div>
    </jsp:body>
</t:page>
File 4: src/main/java/tutorial/HomeController.java
The Servlet Controller.

Java
package tutorial;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HomeController extends HttpServlet {
    public static final String VIEW_TEMPLATE_PATH = "/WEB-INF/jsp/home.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(VIEW_TEMPLATE_PATH).forward(req, resp);
    }
}
2. Step-by-Step Instructions for VS Code
Step 1: Install Prerequisites
JDK: Ensure you have JDK 8 or 11 installed.

VS Code Extensions: Install the "Extension Pack for Java" and "Gradle for Java" from the VS Code Marketplace.

Server: Install the "Community Server Connectors" extension to run Tomcat inside VS Code.

Step 2: Create the Project Folder
Open VS Code and create a new folder for your project.

Create the subfolders exactly as shown in the "Project Structure" section above. This is critical for Gradle to build the project.

Step 3: Add Web Configuration
Create a file at src/main/webapp/WEB-INF/web.xml to map your Servlet:

XML
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee" version="3.1">
    <servlet>
        <servlet-name>HomeController</servlet-name>
        <servlet-class>tutorial.HomeController</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>HomeController</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
Step 4: Build the Project
Open the integrated terminal in VS Code (Ctrl + `).

Type: ./gradlew build (or gradle build if you have it installed globally).

This will create a .war file in the build/libs folder.

Step 5: Run on Server
In VS Code, go to the Servers tab (usually at the bottom left or under the Explorer).

Right-click and select Create New Server -> Apache Tomcat.

Right-click your Tomcat server and select Add Deployment.

Choose the .war file generated in the build/libs folder.

Right-click the server and select Start.

Open your browser and go to http://localhost:8080/[your-project-name].

Would you like me to help you create a simple AJAX script to include in the Home.jsp so it fulfills the "consuming RESTful APIs" part of your exercise requirements?
