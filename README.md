### Emil Academy  

## En databas av Emil Jonsson DevOps18 

### Använding: 

För att skapa all databasens innehåll kan man antingen köra hela scriptet “Allt” på en gång, eller köra varje numrerat script för sig i nummerordning. För att prova databasen kan man antingen använda olika testkommandon från “Testkod” eller skriva dem själv om något saknas. 

### Design & Struktur: 

Dabasen innehåller fyra tabeller. De tre tabellerna “Teacher”, “Course” och “Student” har alla ett ID som gör dem unika i form av en PRIMARY KEY. Dessa tre kopplas samman i tabellen “StudentIndex” där varje kolumn innehåller ett ID som refererar till respektives tabell ID som en FOREIGN KEY. På så vis kan en elev ha flera kurser och lärare. 

För att en lärare endast ska kunna ha en kurs har kolumnen “CourseTeacher” lagts till i tabellen “Course”, denna hänvisar till ID i “Teacher” tabellen som en FOREIGN KEY. En kurs kan dock fortfarande ha flera lärare med denna metod. 

### Normaliseringsregel 1: 

ID skapas med en automatisk räknare som startar på 1, 101, och 1001, samt ökar med 1.  

Kolumner innehåller bara ett värde,  om exempelvis en elev har flera ämnen visas denna i flera kolumner i tabellen “StudentIndex”. 

### Normaliseringsregel 2: 

Namn är inte med i tabellen “StudentIndex”. 

### Normaliseringsregel 3: 

En elevs kurser är i “StudentIndex” tabellen, för att se kursens namn körs en INNER JOIN. Skulle man istället ha “StudentID”, “CourseID” och “CourseName” skulle man ha “CourseName” till “CourseID” och “CourseID” till “StudentID”. Då skulle regel tre ej följas. 

### Prestanda: 

 Index på lärarens efternamn då man sorterar efter detta i en VIEW som därefter används i en PRODECURE. 

 Index på elevs förnamn då man söker efter detta i en PROCEDURE. 

### Säkerhet 

En användare och login “Username” skapas med lösenord “Password”, denna användare läggs till i rollen “Student” som endast har rättigheter till EXECUTE. Detta är alltså ett exempel på en elevanvändare. PROCEDURES kör SELECT på tabeller så en elev fortfarande kan se dem. För att en lärarens lön inte ska synas för en elev så skapas en VIEW som visar allt från “Teacher” tabellen förutom lönen. Sedan skapas en PROCEDURE som visar allt från denna VIEW. 

 
### Problem/Nackdelar: 

Får ibland felmeddelande när man kör Proceduren “Student_Search”, den fungerar dock ändå oavsett om felmeddelandet kommer upp eller ej. 

Email på lärare och elever sätts med ett UPDATE kommando, lägger man till en ny lärare elev behöver man alltså köra om denna för att denna ska få en email.  
