```sh  
lib  
|   main.dart
|   
+---feature
|   +---about
|   |   \---app
|   |       \---view
|   |           \---screen
|   |                   about_screen.dart
|   |                   
|   +---conversion
|   |   +---app
|   |   |   +---config
|   |   |   |       conversion_config.dart
|   |   |   |       
|   |   |   +---history
|   |   |   |   +---model
|   |   |   |   |       last_history_model.dart
|   |   |   |   |       
|   |   |   |   \---view
|   |   |   |       +---screen
|   |   |   |       |       all_history_screen.dart
|   |   |   |       |       
|   |   |   |       \---widget
|   |   |   |           +---all_history
|   |   |   |           |       all_history_data_table_source.dart
|   |   |   |           |       all_history_data_table_widget.dart
|   |   |   |           |       
|   |   |   |           +---dto
|   |   |   |           |       history_output_dto.dart
|   |   |   |           |       
|   |   |   |           \---last_history
|   |   |   |                   last_history_data_table_widget.dart
|   |   |   |                   last_history_output_dto_producer.dart
|   |   |   |                   
|   |   |   \---rate
|   |   |       +---fetch
|   |   |       |       rate_fetcher_factory.dart
|   |   |       |       
|   |   |       +---translate
|   |   |       |       conversion_validation_translator.dart
|   |   |       |       
|   |   |       \---view
|   |   |           +---screen
|   |   |           |       calculator_screen.dart
|   |   |           |       
|   |   |           \---widget
|   |   |               \---calculator
|   |   |                       calculator_widget.dart
|   |   |                       
|   |   +---domain
|   |   |   +---constant
|   |   |   |       currency_constant.dart
|   |   |   |       
|   |   |   +---history
|   |   |   |   \---model
|   |   |   |           conversion_history_record.dart
|   |   |   |           conversion_history_record.g.dart
|   |   |   |           
|   |   |   \---rate
|   |   |       +---calculate
|   |   |       |       currency_converter.dart
|   |   |       |       
|   |   |       +---fetch
|   |   |       |   |   rate_cached_fetcher.dart
|   |   |       |   |   
|   |   |       |   +---cache
|   |   |       |   |       rate_cacher.dart
|   |   |       |   |       
|   |   |       |   \---load
|   |   |       |           rate_fetcher.dart
|   |   |       |           
|   |   |       +---model
|   |   |       |       exchange_rate_record.dart
|   |   |       |       exchange_rate_record.g.dart
|   |   |       |       
|   |   |       \---validate
|   |   |               conversion_validation_result.dart
|   |   |               conversion_validator.dart
|   |   |               
|   |   \---infra
|   |       +---history
|   |       |   \---repository
|   |       |           conversion_history_record_repository.dart
|   |       |           
|   |       \---rate
|   |           +---constant
|   |           |       rate_fetching_constant.dart
|   |           |       
|   |           +---fetch
|   |           |   +---cache
|   |           |   |       rate_hive_cacher.dart
|   |           |   |       rate_memory_cacher.dart
|   |           |   |       
|   |           |   \---load
|   |           |       +---fawaz_ahmed
|   |           |       |       fawaz_ahmed_rate_data.dart
|   |           |       |       fawaz_ahmed_rate_fetcher.dart
|   |           |       |       
|   |           |       \---fixer_io
|   |           |               fixer_io_rate_fetcher.dart
|   |           |               
|   |           \---repository
|   |                   exchange_rate_record_repository.dart
|   |                   
|   +---front
|   |   \---app
|   |       +---constant
|   |       |       appearance_constant.dart
|   |       |       
|   |       +---route
|   |       |       app_router.dart
|   |       |       
|   |       \---view
|   |           +---theme
|   |           |       additional_colors.dart
|   |           |       theme_builder.dart
|   |           |       
|   |           \---widget
|   |                   front_header_bar.dart
|   |                   front_main_menu.dart
|   |                   front_material_app.dart
|   |                   
|   \---setting
|       +---app
|       |   +---manage
|       |   |       setting_manager.dart
|       |   |       
|       |   +---model
|       |   |       setting_model.dart
|       |   |       
|       |   \---view
|       |       +---screen
|       |       |       setting_screen.dart
|       |       |       
|       |       \---widget
|       |           +---appearance
|       |           |   |   appearance_setting.dart
|       |           |   |   
|       |           |   \---option
|       |           |           appearance_setting_option_export.dart
|       |           |           font_family_setting_table_row.dart
|       |           |           locale_setting_table_row.dart
|       |           |           theme_setting_table_row.dart
|       |           |           
|       |           \---currency
|       |                   currency_setting.dart
|       |                   
|       \---infra
|           \---repository
|                   setting_repository.dart
|                   
\---l10n
        all_en.arb
        all_ru.arb
        

``` 
