Got you bro 👌
VS Code is actually a **much better fit** for this than Colab. I’ll walk you through this **slow, clean, and step-by-step**, assuming you want to **verify that the code works and see the UI in a browser**.

This guide uses **VS Code + Maven + Payara Server** (simple & reliable).

---

# 🧠 What We’re Setting Up

You’ll end up with:

* VS Code as the editor
* Maven to build the project
* Payara Server to run Java EE
* Browser UI at
  👉 `http://localhost:8080/WebsocketHome/`
* WebSocket endpoint at
  👉 `ws://localhost:8080/WebsocketHome/actions`

---

# ✅ Prerequisites (Do This First)

### 1️⃣ Install Java (JDK 11 or 17)

Check:

```bash
java -version
```

If not installed → install **JDK 11+**

---

### 2️⃣ Install Maven

Check:

```bash
mvn -version
```

If not installed → install Maven

---

### 3️⃣ Install VS Code Extensions

Open VS Code → Extensions tab → install:

* **Extension Pack for Java**
* **Maven for Java**

Restart VS Code after this.

---

# 🏗️ STEP-BY-STEP IN VS CODE

---

## 🔹 Step 1: Create the Project Folder

Create a folder anywhere:

```text
WebsocketHome
```

Open it in VS Code:

```
File → Open Folder → WebsocketHome
```

---

## 🔹 Step 2: Create Maven Web Project

Open VS Code Terminal (`Ctrl + ~`):

```bash
mvn archetype:generate \
  -DgroupId=org.example \
  -DartifactId=WebsocketHome \
  -DarchetypeArtifactId=maven-archetype-webapp \
  -DinteractiveMode=false
```

You’ll now have:

```
WebsocketHome/
 ├── pom.xml
 └── src/
     └── main/
         ├── java/
         └── webapp/
```

---

## 🔹 Step 3: Create Package Structure

In VS Code Explorer:

```
src/main/java/org/example/model
src/main/java/org/example/websocket
```

(Create folders manually or via terminal)

---

## 🔹 Step 4: Add Java Files

### 📄 Device.java

`src/main/java/org/example/model/Device.java`

➡️ Paste your **Device.java** code

---

### 📄 DeviceSessionHandler.java

`src/main/java/org/example/websocket/DeviceSessionHandler.java`

➡️ Paste your code

---

### 📄 DeviceWebSocketServer.java

`src/main/java/org/example/websocket/DeviceWebSocketServer.java`

➡️ Paste your code

---

## 🔹 Step 5: Add Frontend Files

Put these in:

```
src/main/webapp/
```

* `index.html`
* `style.css`
* `websocket.js`

⚠️ **IMPORTANT**
Your JS already has:

```js
ws://localhost:8080/WebsocketHome/actions
```

✅ This matches your project name — good.

---

## 🔹 Step 6: Update `pom.xml`

Open `pom.xml` and **replace dependencies** with this:

```xml
<dependencies>
    <dependency>
        <groupId>javax.websocket</groupId>
        <artifactId>javax.websocket-api</artifactId>
        <version>1.1</version>
        <scope>provided</scope>
    </dependency>

    <dependency>
        <groupId>javax.json</groupId>
        <artifactId>javax.json-api</artifactId>
        <version>1.1.4</version>
    </dependency>

    <dependency>
        <groupId>javax.enterprise</groupId>
        <artifactId>cdi-api</artifactId>
        <version>2.0</version>
        <scope>provided</scope>
    </dependency>
</dependencies>

<packaging>war</packaging>
```

Save the file.

---

## 🔹 Step 7: Build the Project

In VS Code terminal:

```bash
mvn clean package
```

✅ You should see:

```
BUILD SUCCESS
```

WAR file created:

```
target/WebsocketHome.war
```

---

# 🚀 RUN THE SERVER

---

## 🔹 Step 8: Download Payara Server

```bash
wget https://repo1.maven.org/maven2/fish/payara/extras/payara-micro/5.2022.5/payara-micro-5.2022.5.jar
```

(Windows users: download via browser and put it in project root)

---

## 🔹 Step 9: Start Payara

```bash
java -jar payara-micro-5.2022.5.jar --deploy target/WebsocketHome.war --port 8080
```

Watch for:

```
Payara Micro is ready
Deployed WebsocketHome
```

---

## 🔹 Step 10: Open in Browser 🌐

Open:

```
http://localhost:8080/WebsocketHome/
```

### Open DevTools → Console

You should see **NO WebSocket errors**.

---

# 🧪 Test It

1. Click **Add a device**
2. Enter name/type/description
3. Add device
4. Toggle ON / OFF
5. Remove device

If it works → **your code is 100% functional**

---

# ❗ Common Issues & Fixes

### ❌ WebSocket connection failed

✔ Server not running
✔ Wrong project name
✔ Port mismatch

---

### ❌ CDI `@Inject` not working

✔ Make sure Payara / TomEE is used
❌ Won’t work on plain Tomcat

---

# 🧠 Pro Tips

* Want **hot reload**? → Use Payara `--autoBindHttp`
* Want **Spring Boot version**? → I can convert it
* Want **Docker setup**? → I can give you Dockerfile
* Want **deploy online**? → Railway / Render guide

---

If you want, next I can:
🔥 Debug errors you hit
🔥 Generate a ready-to-run GitHub repo
🔥 Convert this to Spring Boot WebSocket

Just say the word 👊
