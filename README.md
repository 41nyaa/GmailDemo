# GmailDemo

## Setup
The following setup is required to run this application.  
1.Access Google Cloud Platform Console.   
https://console.cloud.google.com  
2.__Create an OAuth client ID__ by following the steps below.  
2-1.Go to “APIs & Services” - “Credentials”.  
2-2.Press the button “CREATE CREDENTIALS” and select the men OAuth-client ID.  
2-3.Input the following and press the button “CREATE”.  
Application Type : iOS  
Name : “Your app name”  
Bundle ID : Xcode Project - General - Bundle Identifier  
2-4.The popup ”OAuth client created” appear, press the button “download plist”.  
Rename the download plist file to “client_id.plist” and register the file to this project.  
2-5.Input the value of REVERSED_CLIENT_ID in the file to the value of “URL types - Item 0 - URL Schemes - Item 0” in Info.pilst.  
3.__Create a test user__ by following the steps below.  
3-1.Go to “OAuth consent”.  
3-2.Press the button “+Add users”, under test users.  
3-3.Input your Google account.  
*I referred to the following.  
https://stackoverflow.com/questions/65756266/error-403-access-denied-the-developer-hasn-t-given-you-access-to-this-app-despi  

## Demo
The Gmail api is called in the following order.  
1.https://gmail.googleapis.com/gmail/v1/users/\(userID)/labels  
2.https://gmail.googleapis.com/gmail/v1/users/\(userID)/threads?labelids=\(labelID)  
3.https://gmail.googleapis.com/gmail/v1/users/\(userID)/messages/\(messageID)  
