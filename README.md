# Beer Hero

Beer Hero is a [Flutter](https://flutter.io/) application designed to provide beer recommendations
via an intuitive to use app for Android and IOS.

## Project Goal
The objective of the project is to provide a simple application that can recommend different types of beers to people. 
It should be a simple app that is aimed towards anyone who enjoys drinking beer, 
and trying different kinds/brands. 

The app will be able to save what beers someone says they liked, 
and if they dislike a beer it will narrow down the recommendations.

## Technologies
We utilized the
[Flutter](https://flutter.io/)
framework which is built atop the
[Dart](https://www.dartlang.org/)
programming lanugage. We also utilized
[Firebase](https://firebase.google.com/)
for our backend services such as user authentication,
a NoSQL database, and server-less cloud functions.

[![Dart](./internals/logos/dart-144.png)](https://www.dartlang.org/)
[![Flutter](./internals/logos/flutter-144.png)](https://www.flutter.io/)
[![Firebase](./internals/logos/firebase-144.png)](https://firebase.google.com/)

## Build Prerequisites
In order to build this project you will need to install several dependencies
#### Flutter
Follow the 'Getting Started' guides for your operating system at [https://flutter.io/get-started/install/]().
This guide should instruct you on how to install all the dependencies required
to build our app.

#### Configure Editor
If you would like to use an editor, you should follow the steps
here [https://flutter.io/get-started/editor/]() to get the best experience.
If you just want to build the project continue to the
[Build](https://github.com/Beer-Hero/beer-hero#build)
section.

## Build
First clone the repo and change your working directory
```text
git clone https://github.com/Beer-Hero/beer-hero.git
cd beer-hero
```

Run the following commands to build for the target platform of your choice.
##### Android
```text
flutter build apk
```
There should now be an APK in 
`./build/app/outputs/apk/release/app-release.apk`
relative to the project
##### IOS (MacOS only)
```text
flutter build ios
```

## Testing on emulators
Assuming the
[Flutter Installation Guide](https://flutter.io/get-started/install/)
was followed, you should see a list of emulators when running the following command
```text
flutter emulators
```

To run an emulator, run 
```text
flutter emulators --launch <emulator id>
```

Then run
```text
flutter start
```
