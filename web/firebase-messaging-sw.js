importScripts(
  "https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyCi4W0AJVHcskXNO1ZtVgej1_tZ8TAKoRg",
  appId: "1:1093009890688:web:e12aea0e5c4d9b0638b565",
  messagingSenderId: "1093009890688",
  projectId: "estudo-firebase-f4ad7",
  authDomain: "estudo-firebase-f4ad7.firebaseapp.com",
  storageBucket: "estudo-firebase-f4ad7.appspot.com",
  measurementId: "G-8LJBH0LNCB",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
