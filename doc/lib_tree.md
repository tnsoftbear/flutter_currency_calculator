```sh  
lib  
|   main.dart
|   
+---core
|   \---network
|       \---http
|           |   http_client.dart
|           |   
|           +---exception
|           |       could_not_fetch_any_http_response.dart
|           |       could_not_fetch_success_http_response.dart
|           |       
|           \---impl
|                   dio_http_client.dart
|                   http_http_client.dart
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
|   |   |   |   +---config
|   |   |   |   |       conversion_config.dart
|   |   |   |   |       
|   |   |   |   +---fetch
|   |   |   |   |   |   rate_cached_fetcher.dart
|   |   |   |   |   |   rate_fetcher_factory.dart
|   |   |   |   |   |   
|   |   |   |   |   +---cache
|   |   |   |   |   |   |   caching_type.dart
|   |   |   |   |   |   |   rate_cacher.dart
|   |   |   |   |   |   |   
|   |   |   |   |   |   \---impl
|   |   |   |   |   |           rate_memory_cacher.dart
|   |   |   |   |   |           rate_repository_cacher.dart
|   |   |   |   |   |           
|   |   |   |   |   \---load
|   |   |   |   |       |   fetching_type.dart
|   |   |   |   |       |   rate_fetcher.dart
|   |   |   |   |       |   
|   |   |   |   |       +---exception
|   |   |   |   |       |       could_not_fetch_exchange_rate.dart
|   |   |   |   |       |       
|   |   |   |   |       +---fawaz_ahmed
|   |   |   |   |       |       fawaz_ahmed_rate_data.dart
|   |   |   |   |       |       fawaz_ahmed_rate_fetcher.dart
|   |   |   |   |       |       
|   |   |   |   |       \---fixer_io
|   |   |   |   |               fixer_io_rate_fetcher.dart
|   |   |   |   |               
|   |   |   |   +---model
|   |   |   |   |       exchange_rate_record.dart
|   |   |   |   |       exchange_rate_record.g.dart
|   |   |   |   |       
|   |   |   |   +---repository
|   |   |   |   |       exchange_rate_record_data_source.dart
|   |   |   |   |       exchange_rate_record_repository.dart
|   |   |   |   |       exchange_rate_record_repository_impl.dart
|   |   |   |   |       
|   |   |   |   \---validate
|   |   |   |           conversion_validation_result.dart
|   |   |   |           conversion_validator.dart
|   |   |   |           
|   |   |   +---infra
|   |   |   |   \---data_source
|   |   |   |           exchange_rate_record_hive_data_source.dart
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
|   |   |   |   \---init
|   |   |   |           currency_feature_dic.dart
|   |   |   |           currency_feature_initializer.dart
|   |   |   |           
|   |   |   +---domain
|   |   |   |   +---collect
|   |   |   |   |       currency_collector.dart
|   |   |   |   |       
|   |   |   |   +---fetch
|   |   |   |   |   \---load
|   |   |   |   |       |   currency_fetcher.dart
|   |   |   |   |       |   
|   |   |   |   |       +---exception
|   |   |   |   |       |       could_not_fetch_exchange_rate.dart
|   |   |   |   |       |       
|   |   |   |   |       \---fawaz_ahmed
|   |   |   |   |               fawaz_ahmed_available_currency_fetcher.dart
|   |   |   |   |               
|   |   |   |   +---model
|   |   |   |   |       currency.dart
|   |   |   |   |       currency.g.dart
|   |   |   |   |       
|   |   |   |   +---populate
|   |   |   |   |       currency_populator.dart
|   |   |   |   |       
|   |   |   |   +---repository
|   |   |   |   |       currency_data_source.dart
|   |   |   |   |       currency_repository.dart
|   |   |   |   |       currency_repository_impl.dart
|   |   |   |   |       update_time_data_source.dart
|   |   |   |   |       
|   |   |   |   \---update
|   |   |   |       |   currency_visibility_updater.dart
|   |   |   |       |   
|   |   |   |       \---internal
|   |   |   |           \---selection
|   |   |   |                   currency_selection_corrector.dart
|   |   |   |                   
|   |   |   +---infra
|   |   |   |   \---data_source
|   |   |   |           currency_hive_data_source.dart
|   |   |   |           update_time_shared_prefs_data_source.dart
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
|   |   |   |   \---init
|   |   |   |           history_feature_dic.dart
|   |   |   |           history_feature_initializer.dart
|   |   |   |           
|   |   |   +---domain
|   |   |   |   +---last_history
|   |   |   |   |   \---model
|   |   |   |   |           last_history_model.dart
|   |   |   |   |           
|   |   |   |   +---model
|   |   |   |   |       conversion_history_record.dart
|   |   |   |   |       conversion_history_record.g.dart
|   |   |   |   |       
|   |   |   |   \---repository
|   |   |   |           conversion_history_record_data_source.dart
|   |   |   |           conversion_history_record_repository.dart
|   |   |   |           conversion_history_record_repository_impl.dart
|   |   |   |           
|   |   |   +---infra
|   |   |   |   \---repository
|   |   |   |           conversion_history_record_hive_data_source.dart
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
|       |   |   \---init
|       |   |           setting_feature_dic.dart
|       |   |           
|       |   +---domain
|       |   |   +---model
|       |   |   |       setting_model.dart
|       |   |   |       setting_model_manager.dart
|       |   |   |       
|       |   |   \---repository
|       |   |           setting_data_source.dart
|       |   |           setting_repository.dart
|       |   |           setting_repository_impl.dart
|       |   |           
|       |   +---infra
|       |   |   \---data_source
|       |   |           setting_shared_prefs_data_source.dart
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
