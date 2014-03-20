import 'dart:async';
import 'package:angular/angular.dart';

/**
 * Mixing to give light i18n capabilities to Angular Dart components
 *
 * Components and controllers must use this class and define
 * localized JSON files on its i18n directory
 *
 * Classes using this mixing need to define variables:
 *   - Scope scope
 *   - Http http
 */
class I18nHelper {

  static const String TRANSLATE = "translate";

  String i18nPathPrefix = ".";

  Map<String, String> i18n = {};

  var translations = {};

  Future loadTranslation(String locale) {
    return http.get("${i18nPathPrefix}/i18n/${locale}.json")
        .then((res) {
          translations[locale] = res.data;
          print(translations);
        });
  }

  translate(String locale) {
    Map<String, String> newI18n = {};
    i18n.forEach((key,value) {
      newI18n[key] = translations[locale][key];
    });
    print(newI18n);
    i18n = newI18n;
  }

  loadLocale(String locale) {
    if (!translations.containsKey(locale)) {
      Future future = loadTranslation(locale);
      future.then((content) {
        translate(locale);
      });
    } else {
      translate(locale);
    }
  }

  init() {
    scope.on(TRANSLATE).listen((e) {
      print("Event '$TRANSLATE' received, data: ${e.data}");
      loadLocale(e.data);
    } );

  }
}