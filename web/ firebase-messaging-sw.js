importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDU2ONrSHdG6huXBHnAj_y0BZyXNWh73XQ",
  authDomain: "fcc-mobile-app.firebaseapp.com",
  projectId: "fcc-mobile-app",
  storageBucket: "fcc-mobile-app.appspot.com",
  messagingSenderId: "367644519695",
  appId: "1:367644519695:web:a048cc4d451c116316e27a",
  measurementId: "G-HWRH4WVGS0"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});