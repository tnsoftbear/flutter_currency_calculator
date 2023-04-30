# Currency Calculator

My 1st experiment with flutter and dart in April of 2023.  
This is a simple demo app for currency conversion.

## Architecture

Module logic is separated to application, infrastructure and domain layers.
Project structure is organized by the the ["feature first"](https://codewithandrea.com/articles/flutter-project-structure/) style.
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

### Tests

There are few unit tests for conversion input validation and calculation logic.

## Install

```sh
# Install dependencies
flutter pub get
# Generate project code
flutter create -t app .
```

## Build

`<uses-permission android:name="android.permission.INTERNET" />` is added 
to the `android/app/src/main/AndroidManifest.xml` file, because application uses the network.

```sh
flutter build apk --no-tree-shake-icons 
```

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

## lib folder structure

```sh
lib
│   main.dart
│   
├───feature
│   ├───about
│   │   └───app
│   │       └───view
│   │           └───screen
│   │                   about_screen.dart
│   │                   
│   ├───conversion
│   │   ├───app
│   │   │   ├───config
│   │   │   │       conversion_config.dart
│   │   │   │       
│   │   │   ├───history
│   │   │   │   └───view
│   │   │   │       ├───screen
│   │   │   │       │       all_history_screen.dart
│   │   │   │       │       
│   │   │   │       └───widget
│   │   │   │           ├───all_history
│   │   │   │           │       all_history_data_table_source.dart
│   │   │   │           │       all_history_data_table_widget.dart
│   │   │   │           │       
│   │   │   │           ├───dto
│   │   │   │           │       history_output_row.dart
│   │   │   │           │       
│   │   │   │           └───last_history
│   │   │   │                   last_history_data_table_widget.dart
│   │   │   │                   
│   │   │   └───rate
│   │   │       ├───fetch
│   │   │       │       rate_fetcher_factory.dart
│   │   │       │       
│   │   │       ├───translate
│   │   │       │       conversion_validation_translator.dart
│   │   │       │       
│   │   │       └───view
│   │   │           ├───screen
│   │   │           │       calculator_screen.dart
│   │   │           │       
│   │   │           └───widget
│   │   │               └───calculator
│   │   │                       calculator_widget.dart
│   │   │                       
│   │   ├───domain
│   │   │   ├───constant
│   │   │   │       currency_constant.dart
│   │   │   │       
│   │   │   ├───history
│   │   │   │   └───model
│   │   │   │           conversion_history_record.dart
│   │   │   │           conversion_history_record.g.dart
│   │   │   │           
│   │   │   └───rate
│   │   │       ├───calculate
│   │   │       │       currency_converter.dart
│   │   │       │       
│   │   │       ├───fetch
│   │   │       │   │   rate_cached_fetcher.dart
│   │   │       │   │   
│   │   │       │   ├───cache
│   │   │       │   │       rate_cacher.dart
│   │   │       │   │       
│   │   │       │   └───load
│   │   │       │           rate_fetcher.dart
│   │   │       │           
│   │   │       ├───model
│   │   │       │       exchange_rate_record.dart
│   │   │       │       exchange_rate_record.g.dart
│   │   │       │       
│   │   │       └───validate
│   │   │               conversion_validation_result.dart
│   │   │               conversion_validator.dart
│   │   │               
│   │   └───infra
│   │       ├───history
│   │       │   └───repository
│   │       │           conversion_history_record_repository.dart
│   │       │           
│   │       └───rate
│   │           ├───constant
│   │           │       rate_fetching_constant.dart
│   │           │       
│   │           ├───fetch
│   │           │   ├───cache
│   │           │   │       rate_hive_cacher.dart
│   │           │   │       rate_memory_cacher.dart
│   │           │   │       
│   │           │   └───load
│   │           │           fawaz_ahmed_rate_fetcher.dart
│   │           │           fixer_io_rate_fetcher.dart
│   │           │           
│   │           └───repository
│   │                   exchange_rate_record_repository.dart
│   │                   
│   ├───front
│   │   └───app
│   │       ├───constant
│   │       │       appearance_constant.dart
│   │       │       route_constant.dart
│   │       │       
│   │       └───view
│   │           ├───theme
│   │           │       additional_colors.dart
│   │           │       theme_builder.dart
│   │           │       
│   │           └───widget
│   │                   front_header_bar.dart
│   │                   front_main_menu.dart
│   │                   front_material_app.dart
│   │                   
│   └───setting
│       ├───app
│       │   ├───manage
│       │   │       setting_manager.dart
│       │   │       
│       │   └───view
│       │       ├───screen
│       │       │       setting_screen.dart
│       │       │       
│       │       └───widget
│       │               font_family_setting_table_row.dart
│       │               locale_setting_table_row.dart
│       │               setting_widget_export.dart
│       │               theme_setting_table_row.dart
│       │               
│       └───infra
│           └───repository
│                   setting_repository.dart
│                   
└───l10n
        all_en.arb
        all_ru.arb
```

---

(c) 2023, github.com/tnsoftbear
