library component1;

import 'package:angular/angular.dart';

import '../i18n_helper/i18n_helper.dart';

@NgComponent(
    selector: 'component1',
    templateUrl: 'component1/component1.html',
    cssUrl: 'component1/component1.css',
    publishAs: 'cmp1')
class Component1 extends Object with I18nHelper  {
  Scope scope;
  Http http;

  Component1(this.scope, this.http) {
    i18n = {
         "hi": "Hi, I'm the component",
         "value": "Value",
         "button": "Press here to put value",
         "map": "And the map:"
       };
       i18nPathPrefix = "component1";
       init();
  }

  @NgTwoWay('value')
  String value;

  @NgAttr('whoami')
  String id;

  @NgTwoWay('amap')
  Map aMap;

  setValue() {
    value= id.toString();
  }

  addToMap() {
    Map tMap = {'lastClick': id}
      ..addAll(aMap);
    aMap = tMap;
    print(aMap);
  }
}