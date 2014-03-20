import 'package:angular/angular.dart';
import 'dart:async';

import 'i18n_helper/i18n_helper.dart';

import 'component1/component1.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

@NgController(
    selector: '[mainScope]',
    publishAs: 'mainCtrl'
    )
class MainScope extends Object with I18nHelper {

  Http http;
  Scope scope;

  MainScope(this.scope, this.http) {
    i18n = {
      "title": "AngularDartTests",
      "mainScope": "Hi, I'm the main scope",
      "mainScopeButton": "Press here to put value 42 on components 1 and 2",
      "andTheMap": "And the map:"
    };
    i18nPathPrefix = ".";
  }

  /**
   * With Dart2JS expressions {{ctrl.toto['titi']}} doesn't work
   * We need to create getters
   */
  String get i18nTitle => i18n['title'];
  String get i18nMainScope => i18n['mainScope'];
  String get i18nMainScopeButton => i18n['mainScopeButton'];
  String get i18nAndTheMap => i18n['andTheMap'];

  String value = "0";

  Map aMap = { 'a': 'b', 'c': 'd' };

  clickMe() {
    value = "42";
  }

  List<String> locales = [ "en_US", "fr_FR"];

  String _selectedLocale = "en_US";

  String get selectedLocale =>  _selectedLocale;

  void   set selectedLocale(String locale) {
    print(locale);
    _selectedLocale = locale;
    loadLocale(locale);
    print("Sending event");
    scope.broadcast(I18nHelper.TRANSLATE, locale);
  }





}

void main() {
    ngBootstrap(module: new Module()
    ..type(MainScope)
    ..type(Component1));
}
