# Currency Calculator

My 1st experiment with flutter and dart in April of 2023.  
This is a simple demo app for currency conversion.

## Architecture

Module logic is separated to application, infrastructure and domain layers.
Project structure is organized by the the ["feature first"](https://codewithandrea.com/articles/flutter-project-structure/) style.
See namespaces structure in folder tree view in the [lib/ tree](doc/lib_tree.md) document. 
Logic is separated to features, and each feature has its own namespace with all layers inside.
Features do not call each other, except the "Front" feature,
which defines the application entry point and general configuration of appearance.

Application layer calls logic from the Infrastructure and Domain layer.
Presentation logic is located in the Application layer in the "view" folders.
Infrastructure layer calls logic from Domain layer.
It contains logic that accesses external resources, such as API, database, etc.
Domain layer operates only in bounds of its own space.
It is pure functional core with business logic and data models.

## Features

### Currency Conversion feature

Most important business logic is located in the "Conversion" feature.
It handles the Currency Calculator and the Conversion History screens.

**Infrastructure layer** is responsible for the currency exchange rate loading by API.
It caches retrieved exchange rate in the [Hive](https://docs.hivedb.dev/) DB.
The lifetime of cached data is set to 1 day in configuration object. 
The Hive DB is also used for storing currency conversion history.
DB access methods are encapsulated in the repository classes.

Rate fetchers implement common interface and are provided by factory.
**Application layer** operates by this interface and provides the currency exchange rate to the UI.
It translates with help of localization package, and format currency amounts 
and exchange rate numbers with help of the [Intl](https://pub.dev/packages/intl) package.  

**Domain layer** validates input values and calculates the currency conversion.

### Settings feature

Settings screen allows to configure several options:  

* Application supports two languages: English and Russian. They define appropriate localization.
* Preferred color is configurable by selection of the application theme. Theme is applied to the whole app.
Custom colors are added with help of [theme extension](https://api.flutter.dev/flutter/material/ThemeExtension-class.html).
* Font family is configured there as well.

Settings are stored with help of the [Shared preferences](https://pub.dev/packages/shared_preferences) package.

## Tests

There are few unit tests for conversion input validation and calculation logic.

## Run

### Install

```sh
# Install dependencies
flutter pub get
# Generate project code
flutter create -t app .
```

### Build

`<uses-permission android:name="android.permission.INTERNET" />` is added 
to the `android/app/src/main/AndroidManifest.xml` file, because application uses the network.

```sh
flutter build apk --no-tree-shake-icons 
```

### Develop

Few reminders for myself:

```sh
# Generate code
flutter pub run build_runner build --delete-conflicting-outputs
# Generate translation classes
flutter gen-l10n
```

#### Document

```sh
# Generate lib/ folder tree in Windows
echo ```sh > ./doc/lib_tree.md & echo lib >> ./doc/lib_tree.md & tree /F /A lib | more +3 >> ./doc/lib_tree.md & echo ``` >> ./doc/lib_tree.md
```

#### TODO

* [ ] JSON model for rate fetching
* [ ] Riverpod
* [ ] Swipe screens

## Screens

![Currency calculator screen](./doc/pic/scr-1.png)
![Settings screen](./doc/pic/scr-2.png)
![History screen](./doc/pic/scr-3.png)

## Links

* [Flutter App Architecture with Riverpod](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
* [Folder structure for Flutter with clean architecture. How I do.](https://felipeemidio.medium.com/folder-structure-for-flutter-with-clean-architecture-how-i-do-bbe29225774f)
* [Style guide for Flutter repo](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
* [Internationalizing Flutter apps](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
* [Flutter 3: How to extend ThemeData](https://medium.com/geekculture/flutter-3-how-to-extend-themedata-56b8923bf1aa)

---

(c) 2023, github.com/tnsoftbear
