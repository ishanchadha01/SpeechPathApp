# SpeechPathApp

Login/logout functionality along with counting activity are built out. Other acitvities would follow a similar structure to the counting activity. 

![App Design](/Images/app-design.png)

For counting activity, user chooses how many phonemes are in word until correct answer is given. If incorrect, they are prompted to try again. Otherwise, they are taken to UI view for correct answer and user progress is updated.

The data was stored in a NoSQL format using Firebase's cloud firestore. The following is a snapshot of the database:

![Firestore](/Images/firestore-spa.png)
