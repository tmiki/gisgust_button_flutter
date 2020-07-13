# Gisgust Button Flutter App

This app is merely a sample app with using Google Maps, Firebase Auth, Firebase Firestore and so on. 

# Getting Started

Open up this source code as a Flutter project.  
Please notice that the following files are encrypted. Therefore you have to prepare your own ones.  
The next section explains how you get setting up your environment and obtain them.     

- android/app/secret.properties
- android/app/google-services.json

# How to Run
## Abstract

You need to follow steps below.  

- Setting up Google Maps
    -  1.Get a Google Maps API key.
    -  2.Put your Google Maps API key into the "android/app/secret.properties" file
- Setting up Firebase
    -  3.Create a new Firebase Project.
    -  4.Add an Android app and get a "google-services.js" file. 
    -  5.Put the "google-services.js" file into this app.
    -  6.Enable Firebase Authentication with the "Email/Password" sign-in method.
    -  7.Create a Firestore database named "user_disgusts"

## Setting up Google Maps
### 1. Get a Google Maps API key.
 
Get your own API key by following the official document below.  
https://developers.google.com/maps/documentation/android-sdk/get-api-key

### 2. Put your Google Maps API key into the "android/app/secret.properties" file.

Then, put your Google Maps API key obtained at the previous step into the "secret.properties" file.  
This app has 2 buildTypes, "debug" and "release". Therefore you need to specify variables for both them.  

```
GOOGLE_MAPS_API_KEY_DEBUG=YOUR-API-KEY
GOOGLE_MAPS_API_KEY_RELEASE=YOUR-API-KEY
```

Please also refer the "android/app/build.gradle" to know how the app retrieves the variables above.  

## Setting up Firebase
### 3. Create a new Firebase Project.

Create a new Firebase project by following the document below. In the Step 1 of the document corresponds this step.     

https://firebase.google.com/docs/android/setup#add_the_sdk

### 4. Add an Android app and get a "google-services.js" file. 

Follow the document, you finally can obtain your own "google-services.js" file at the end of steps.  

https://firebase.google.com/docs/android/setup#add_the_sdk

### 5. Put the "google-services.js" file into this app.

Put the "google-services.js" file into the "android/app/" directory.  
You would overwrite the "android/app/google-services.js" file with your own one.    

### 6. Enable Firebase Authentication with the "Email/Password" sign-in method.

Follow the document below and enable the "Email/Password" sign-in support.  
https://firebase.google.com/docs/auth/web/password-auth

### 7. Create a Firestore database named "user_disgusts".

Create a Firestore database by following the document below.  
https://firebase.google.com/docs/firestore/quickstart

