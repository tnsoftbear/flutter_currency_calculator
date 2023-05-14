```sh  
lib  
|   main.dart
|   
+---core
|   \---clock
|           clock.dart
|           date_time_clock.dart
|           
+---feature
|   +---about
|   |   +---internal
|   |   |   \---ui
|   |   |       \---screen
|   |   |               about_screen.dart
|   |   |               
|   |   \---public
|   |           about_feature_facade.dart
|   |           
|   +---conversion
|   |   +---internal
|   |   |   +---app
|   |   |   |   +---config
|   |   |   |   |       conversion_config.dart
|   |   |   |   |       
|   |   |   |   +---fetch
|   |   |   |   |       rate_fetcher_factory.dart
|   |   |   |   |       
|   |   |   |   +---init
|   |   |   |   |       conversion_feature_dic.dart
|   |   |   |   |       conversion_feature_initializer.dart
|   |   |   |   |       
|   |   |   |   \---translate
|   |   |   |           conversion_validation_translator.dart
|   |   |   |           
|   |   |   +---domain
|   |   |   |   +---calculate
|   |   |   |   |       currency_converter.dart
|   |   |   |   |       
|   |   |   |   +---fetch
|   |   |   |   |   |   rate_cached_fetcher.dart
|   |   |   |   |   |   
|   |   |   |   |   +---cache
|   |   |   |   |   |       rate_cacher.dart
|   |   |   |   |   |       
|   |   |   |   |   \---load
|   |   |   |   |           rate_fetcher.dart
|   |   |   |   |           
|   |   |   |   +---model
|   |   |   |   |       exchange_rate_record.dart
|   |   |   |   |       exchange_rate_record.g.dart
|   |   |   |   |       
|   |   |   |   \---validate
|   |   |   |           conversion_validation_result.dart
|   |   |   |           conversion_validator.dart
|   |   |   |           
|   |   |   +---infra
|   |   |   |   +---constant
|   |   |   |   |       rate_fetching_constant.dart
|   |   |   |   |       
|   |   |   |   +---fetch
|   |   |   |   |   +---cache
|   |   |   |   |   |       rate_hive_cacher.dart
|   |   |   |   |   |       rate_memory_cacher.dart
|   |   |   |   |   |       
|   |   |   |   |   \---load
|   |   |   |   |       +---fawaz_ahmed
|   |   |   |   |       |       fawaz_ahmed_rate_data.dart
|   |   |   |   |       |       fawaz_ahmed_rate_fetcher.dart
|   |   |   |   |       |       
|   |   |   |   |       \---fixer_io
|   |   |   |   |               fixer_io_rate_fetcher.dart
|   |   |   |   |               
|   |   |   |   \---repository
|   |   |   |           exchange_rate_record_repository.dart
|   |   |   |           
|   |   |   \---ui
|   |   |       +---screen
|   |   |       |       calculator_screen.dart
|   |   |       |       
|   |   |       \---widget
|   |   |           \---calculator
|   |   |                   calculator_widget.dart
|   |   |                   
|   |   \---public
|   |           conversion_feature_facade.dart
|   |           
|   +---currency
|   |   +---internal
|   |   |   +---app
|   |   |   |   +---init
|   |   |   |   |       currency_feature_dic.dart
|   |   |   |   |       currency_feature_initializer.dart
|   |   |   |   |       
|   |   |   |   +---load
|   |   |   |   |       currency_loader.dart
|   |   |   |   |       
|   |   |   |   +---populate
|   |   |   |   |       currency_populator.dart
|   |   |   |   |       
|   |   |   |   \---update
|   |   |   |           currency_visibility_updater.dart
|   |   |   |           
|   |   |   +---domain
|   |   |   |   +---collect
|   |   |   |   |       currency_collector.dart
|   |   |   |   |       
|   |   |   |   +---fetch
|   |   |   |   |   \---load
|   |   |   |   |           currency_fetcher.dart
|   |   |   |   |           
|   |   |   |   \---model
|   |   |   |           currency.dart
|   |   |   |           currency.g.dart
|   |   |   |           
|   |   |   +---infra
|   |   |   |   +---fetch
|   |   |   |   |   \---load
|   |   |   |   |       \---fawaz_ahmed
|   |   |   |   |               fawaz_ahmed_available_currency_fetcher.dart
|   |   |   |   |               
|   |   |   |   \---repository
|   |   |   |           currency_repository.dart
|   |   |   |           
|   |   |   \---ui
|   |   |       \---setting
|   |   |               currency_checkbox.dart
|   |   |               currency_setting_one_letter_tab.dart
|   |   |               currency_setting_widget.dart
|   |   |               
|   |   \---public
|   |           currency_feature_facade.dart
|   |           
|   +---history
|   |   +---internal
|   |   |   +---app
|   |   |   |   +---init
|   |   |   |   |       history_feature_dic.dart
|   |   |   |   |       history_feature_initializer.dart
|   |   |   |   |       
|   |   |   |   \---model
|   |   |   |           last_history_model.dart
|   |   |   |           
|   |   |   +---domain
|   |   |   |   \---model
|   |   |   |           conversion_history_record.dart
|   |   |   |           conversion_history_record.g.dart
|   |   |   |           
|   |   |   +---infra
|   |   |   |   \---repository
|   |   |   |           conversion_history_record_repository.dart
|   |   |   |           
|   |   |   \---ui
|   |   |       +---screen
|   |   |       |       all_history_screen.dart
|   |   |       |       
|   |   |       \---widget
|   |   |           +---all_history
|   |   |           |       all_history_data_table_source.dart
|   |   |           |       all_history_data_table_widget.dart
|   |   |           |       
|   |   |           +---history_output
|   |   |           |       history_output_dto.dart
|   |   |           |       history_output_dto_producer.dart
|   |   |           |       
|   |   |           \---last_history
|   |   |                   last_history_widget.dart
|   |   |                   
|   |   \---public
|   |           history_feature_facade.dart
|   |           
|   \---setting
|       +---internal
|       |   +---app
|       |   |   \---model
|       |   |           setting_model.dart
|       |   |           setting_model_manager.dart
|       |   |           
|       |   +---infra
|       |   |   \---repository
|       |   |           setting_repository.dart
|       |   |           
|       |   \---ui
|       |       +---screen
|       |       |       setting_screen.dart
|       |       |       
|       |       \---widget
|       |           \---appearance
|       |               |   appearance_setting.dart
|       |               |   
|       |               \---option
|       |                       appearance_setting_option_export.dart
|       |                       font_family_setting_table_row.dart
|       |                       locale_setting_table_row.dart
|       |                       theme_setting_table_row.dart
|       |                       
|       \---public
|               setting_feature_facade.dart
|               
+---front
|   +---app
|   |   +---boot
|   |   |       bootstrapper.dart
|   |   |       
|   |   +---constant
|   |   |       appearance_constant.dart
|   |   |       
|   |   \---route
|   |           app_router.dart
|   |           
|   \---ui
|       +---theme
|       |       additional_colors.dart
|       |       theme_builder.dart
|       |       
|       \---widget
|               front_header_bar.dart
|               front_main_menu.dart
|               front_material_app.dart
|               standard_error_label.dart
|               standard_progress_indicator.dart
|               
\---l10n
        all_en.arb
        all_ru.arb
        

``` 
