# Currency Calculator

My 1st experiment with flutter and dart in April of 2023.  
This is a simple demo app for currency conversion.

## Architecture

Project structure is organized by the the ["feature first"](https://codewithandrea.com/articles/flutter-project-structure/) style.

Each feature defines published API for inter-feature communication.
It can be found in the facade class in `/lib/feature/<feature_name>/public/` folder.
Features should not call each other directly, but only through the public API.

Feature internal logic is located in the `/lib/feature/<feature_name>/internal/` folder.
It is separated to ui, application, infrastructure and domain layers.
See namespaces structure in folder tree view in the [lib/ tree](doc/lib_tree.md) document.

Features can call widgets located in the `/lib/feature/front` namespace, where we define common widgets, 
like the application entry point and general configuration of appearance.
Application bootstrapping logic is in the `/lib/boot/` folder.

**Presentation layer** is located in the `/ui` folders. It can call logic of the Application and Domain layers.

**Application layer** (`/app`) can call logic of the Infrastructure (`/infra`) and Domain (`/domain`) layers.

**Infrastructure layer** can call logic of Domain layer.
It contains logic that accesses external resources, such as API, database, etc.

**Domain layer** operates only in bounds of its own space.
It is pure functional core with business logic, entities and data models.

## Features

You can find there the next features:

* **Conversion** - calculates currency conversion according to the exchange rate.
* **History** - displays the history of currency conversions.
* **Currency** - provides the list of available currencies.
* **Settings** - allows to configure application appearance and available currencies.
* **About** - displays information about the application.

### Currency Conversion feature

Most important business logic is located in the "Conversion" feature.
It handles the Currency Calculator.

**Infrastructure layer** is responsible for the currency exchange rate loading by API.
It caches retrieved exchange rate in the [Hive](https://docs.hivedb.dev/) DB.
The lifetime of cached data is set to 1 day in configuration object. 
DB access methods are encapsulated in the repository classes.

Rate fetchers implement common interface and are provided by factory.
**Application layer** operates by this interface and provides the currency exchange rate to the UI.
It translates with help of localization package, and format currency amounts 
and exchange rate numbers with help of the [Intl](https://pub.dev/packages/intl) package.  

**Domain layer** validates input values and calculates the currency conversion.

We display the last 5 conversions at the Calculator screen in the bottom History widget.
The history widget is constructed with help of FutureBuilder, because it depends on data loaded by async call.
Since the history widget is updated after the saving of currency conversion, 
it is notified about the change with help of the [Provider](https://pub.dev/packages/provider) package.
The Last History widget is a part of the History feature and it is exposed by Facade class of its feature's public API.

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
