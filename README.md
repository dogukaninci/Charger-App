<h1 
align="center">
<br>
  <img src="https://user-images.githubusercontent.com/38799123/179360206-263c6742-4d7e-4acc-8bfd-5ecfbf94be91.png" width="100">
<br>
<br>
ChargerApp </h1>

<h5 align="left"> 
<br>
Arçelik A.Ş. is a Turkish multinational household appliances manufacturer.
</h5>
<h5 align="left"> It is active in more than 100 countries including China and the United States through its 13 international subsidiaries and over 4,500 branches in Turkey. The company operates 15 production plants in Turkey, Romania, Russia, China, South Africa and Thailand including refrigerator, washing machine, dishwasher, cooking appliances and components plants. It offers products under its own Eleven brand names, including Arçelik, Beko, Grundig, Dawlance, Altus, Blomberg, Arctic, Defy, Leisure, Arstil, Elektra Bregenz and Flavel.
</h5>
<br>
<h5 align="left"> During the Development, most of the time MVVM rules are considered for the clean code purposes.
</h5>
<br>

<h5 align="left"> - To install the application, it is sufficient to clone the project and install the Alomofire library using swift package manager (if not automatically downloaded by Xcode).
</h5>
<br>


# Features
This is a Electric Vehicle Charging Station Appointment app to manage and schedule appointments. It has many features such as finding the nearest station, local notifications, appointments cancelation, station filtering by features etc.

## Technologies
+ MVVM Architecture ✅ 
+ Programmatically Auto Layout ✅
+ Alamofire ✅

## Requirements
+ iOS 15.4+
+ Swift 5+
+ Xcode 11+

## Launch Screen
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365748-521ce31f-b3f6-46d3-92cf-69a496f41815.png" width="300">
  </tr></td>
</table>

## Permissions
The app asks for permission for location and notification the first time it runs.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179364792-6fc577c1-75b8-48cc-adaa-8ecd8c1e899d.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179364797-2f59e2dd-6782-4434-9c1f-8ce248e69936.png" width="300"></td>
  </tr>
</table>

## Login Screen
When the text field is clicked, the view scrolls according to the height of the opened keyboard. The login button remains inactive until a suitable email address is entered. It becomes active when a suitable e-mail address is entered.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365104-f311ad4c-5cc0-4fcc-97d3-ee2394225245.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365102-aee35081-1b74-4649-99a1-ad02c974b6c7.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365100-5bb7a65a-20ee-4a97-a040-501557c74cca.png" width="300"></td>

  </tr>
</table>

## Appointments Screen
Tableview will be hidden if there is no current and past appointments after login. If there is an active appointment or if there is a past appointment, the tableview will be active. In the active appointments section, the notification time is shown if the notification has been set up. Alse there is a cancel button in the active appointments section for each appointment.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365795-3615502b-55dc-421c-ae5b-08a8fba02a37.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365859-552b98b9-a707-457d-9c31-4ea1049aace1.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365858-2cfa13f7-4a67-4853-b520-c4a93b87c15f.png" width="300"></td>
  </tr>
</table>

## Cancel Appointment Alert Screen
When the delete appointment button is pressed, an alert screen containing the appointment information is opened and it asks for confirmation again to cancel it.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366612-79986807-566e-4c4b-bdd8-dd8fb372ab54.png" width="300"></td>
  </tr>
</table>

## City Selection Screen
The search bar on the city selection screen is designed to handle typos. Upper and lower case letters and Turkish characters can be used. In addition, city name characters were matched according to the letters in the bar and turned into white.The tab bar border turns red if no matches are found with the entered letters.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365959-fd364868-d0bf-4075-927d-a19559293023.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365958-371282b3-7894-4b5e-b471-adc5ecc19c7a.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179365956-c09a902a-56f9-4e97-827e-605fcd48c20a.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366013-caef4240-e5e9-4b1f-bd7c-7f1e43fa46ea.png" width="300"></td>
  </tr>
</table>

## Station Selection Screen
When the station selection screen is first opened, the filter collection view section is hidden. The search bar for station names can also be used on this screen. When filtering elements are selected and returned, the scrollable collection view becomes active. There are buttons to cancel each filter individually. If location permission is granted, the nearest station is listed at the top.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366139-e1829604-633b-4e1d-8a22-ec41e9bb541b.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366309-b64fc01f-f275-4774-bde1-75b17715d6b5.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366308-0913bd7d-feb9-4601-b5fd-8b702dc6b9b1.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366137-8ac07c86-3f3b-4eed-abaa-f05522435e20.png" width="300"></td>
</table>

## Filter Screen
The spesific border turns green when the elements in the filtering screen are selected. There is also a button to clear the filtering process and when this button is pressed, the filters will be inactive.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366351-8823e0fc-0390-4e5a-ac1e-1aaf23343fcd.png" width="300"></td>
</table>

## Slot Selection Screen
The slot selection screen has a field to select the date. Clicking on the date field opens the date picker screen. Slots can be in 1, 2 or 3 parts according to the number of slots. If there is a previously booked appointment, the relevant section will be inactive. Slots can be scrolled vertically. Confirmation button is inactive until the slot is selected.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366425-195e3694-6469-47df-aac3-a267edcac5d5.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366423-a058365b-c4dd-4762-bb75-e05c589af1ed.png" width="300"></td>
</table>

## Date Picker Screen
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366673-e821aa97-61f4-43d2-9498-2251951d3773.png" width="300"></td>
</table>

## Wrong Date Screen
When a past date is selected, a warning screen appears with select today or edit buttons. If the select today option is selected, the slot selection screen will be returned, if the edit date button is pressed, the date selection screen will be returned.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366794-7da983d3-e7da-4796-92ee-46ee7e5ddff9.png" width="300"></td>
</table>

## Appointment Details Screen
The screen containing the information about the appointment. At the bottom there is a switch to turn on notifications. If the switch becomes active, one more row is added to the bottom and the screen is scrolled to the bottom. When the notification row is pressed, the notification schedule screen is opened.
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366519-bcfd0ca8-e071-4102-9338-c31f3202e4fe.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366517-64fad029-3b1b-4dd1-bdce-af36d8526a0b.png" width="300"></td>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366515-32ba4e81-aa09-4082-900b-be9c9d9f2966.png" width="300"></td>
</table>

## Notification Time Picker Screen
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179366691-7f708a89-625c-4e23-8062-f65dad1d238b.png" width="300"></td>
</table>

## Notification
<table>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38799123/179372934-60959ba8-5934-484c-8517-77e394999f38.png" width="300"></td>
</table>

## Demo Video - Youtube
[![Demo](https://img.youtube.com/vi/mlVumRCpD8g/0.jpg)](https://youtu.be/mlVumRCpD8g "Demo")


