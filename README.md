Mqtt Broker App

Tools :
Android Studio (version 2021.3)
Flutter (Channel stable, 3.16.5, on Microsoft Windows [Version 10.0.22631.3155], locale en-ID)

Short Description
Mqtt Broker App have 3 Pages with named : MqttScreen, SettingScreen and MqttConfiguration.

Installation Guide :
1. Clone the Github from this website.
2. Flutter pub get
3. Run the App

Guide to use :
1. Go to MqttConfigurationScreen to setup the URL (host and port)
2. When you do the CONNECT it will saved/store you host and port to local with sqlflite
3. Fill the Topic
4. Type any message you want it in MessageText and sendMessage
5. The Messages will be appears on MqttScreen (AppBody)

Feature :
1. Configuration HOST and PORT with button CONNECT and DISCONNECT
2. Local Data Source for HOST and PORT when CONNECT, so when the App Closed, the Data includes HOST and PORT will be stored and then will be AUTO CONNECT
3. DISCONNECT will remove the data
4. Topic with 1 button that will change when SUBSCRIBE and you can't edit any text in Topic when already subscribe, to edit the Topic you need to UNSUBSCRIBE to able edit another Topic.
5. Message, you can send any Message but you can't send it when you did'nt SUBSCRIBE the topic yet
6. The Messages will be appears on the Center of App
7. Switch Theme but not stored the theme, so when the app closed it will back to default
