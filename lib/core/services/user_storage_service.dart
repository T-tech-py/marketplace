import 'dart:convert';

import 'package:marketplace/core/services/local_storage_service.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';

abstract class UserStorageService {
  void saveToken(String token);

  // ignore: avoid_positional_boolean_parameters
  void setLoggedIn(bool value);

  String? getToken();
  String? getCookie();
  String? getDeviceToken();
  String? getUserLoggedInEmail();
  bool getLoggedIn();
  bool getLoggingOut();
  List<ProductEntity>? getFavourite();
  void saveFavourite(ProductEntity product);
  void deleteFavourite(ProductEntity product);
  void clearFavourite();
  void clearStorage();
}

class UserStorageServiceImpl implements UserStorageService {
  UserStorageServiceImpl(this._localStorageService);
  final LocalStorageService _localStorageService;

  final defaultDeviceToken = 'd9708df38d23192e';
  final _tokenKey = '__token';
  final _deviceTokenKey = '__deviceToken';
  final _loggedInKey = '__loggedIn';
  final _loggingInKey = '__loggingIn';
  final _cookieKey = '__cookie';
  final _userEmail = '__userEmail';
  final _productKey = '__product';

  @override
  String? getToken() {
    try {
      return _localStorageService.getPreference(key: _tokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await _localStorageService.savePreference(key: _tokenKey, data: token);
    } catch (e) {
      return;
    }
  }

  @override
  void clearStorage() {}

  @override
  Future<void> setLoggedIn(bool value) async {
    try {
      await _localStorageService.savePreference(
        key: _loggedInKey,
        data: value ? 'True' : 'False',
      );
    } catch (e) {
      return;
    }
  }

  @override
  bool getLoggedIn() {
    try {
      final value = _localStorageService.getPreference(key: _loggedInKey);
      // ignore: avoid_bool_literals_in_conditional_expressions
      return (value == 'True') ? true : false;
    } catch (e) {
      return false;
    }
  }

  @override
  String? getDeviceToken() {
    try {
      return _localStorageService.getPreference(key: _deviceTokenKey) ??
          defaultDeviceToken;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveDeviceToken(String token) async {
    try {
      await _localStorageService.savePreference(
        key: _deviceTokenKey,
        data: token,
      );
    } catch (e) {
      return;
    }
  }

  @override
  bool getLoggingOut() {
    try {
      final value = _localStorageService.getPreference(key: _loggingInKey);
      // ignore: avoid_bool_literals_in_conditional_expressions
      return (value == 'True') ? true : false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setLoggingOut(bool value) async {
    try {
      await _localStorageService.savePreference(
        key: _loggingInKey,
        data: value ? 'True' : 'False',
      );
    } catch (e) {
      return;
    }
  }

  Future<void> saveCookie(String cookie) async {
    try {
      await _localStorageService.savePreference(
        key: _cookieKey,
        data: cookie,
      );
    } catch (e) {
      return;
    }
  }

  @override
  String? getCookie() {
    try {
      return _localStorageService.getPreference(key: _cookieKey);
    } catch (e) {
      return null;
    }
  }



  @override
  String? getUserLoggedInEmail() {
    try {
      return _localStorageService.getPreference(key: _userEmail) ?? '';
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserLoggedInEmail(String email) async {
    try {
      await _localStorageService.savePreference(
        key: _userEmail,
        data: email,
      );
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> saveFavourite(ProductEntity product) async {
    try {
      var favourites = [];
      final data =  _localStorageService.getPreference(key: _productKey);
     if(data != null){
       var keep = json.decode(data);
       favourites.addAll(keep as List);
       favourites.add(product.toJson());
       await _localStorageService.savePreference(
         key: _productKey,
         data: json.encode(favourites),
       );
     }else{
       favourites.add(product.toJson());
       await _localStorageService.savePreference(
         key: _productKey,
         data: json.encode(favourites),
       );
     }
    } catch (e) {
      return;
    }
  }

  @override
  List<ProductEntity>? getFavourite() {
    try {
      final data = json.decode(_localStorageService.getPreference(key: _productKey)??'');
      return  (data as List).map((product)=>ProductEntity.fromJson(product)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  void clearFavourite() {
    try {
      _localStorageService.deletePreference(key: _productKey);
    } catch (e) {
      return null;
    }
  }

  @override
  void deleteFavourite(ProductEntity product) async{
    try {
      final favourites = [];
      final data = json.decode(_localStorageService.getPreference(key: _productKey)??'');
      favourites.addAll((data as List).map((product)=>ProductEntity.fromJson(product)).toList());
      favourites.removeWhere((data)=> data.id == product.id);
      _localStorageService.deletePreference(key: _productKey);
      favourites.map((element)=>element.toJson()).toList();
      await _localStorageService.savePreference(
        key: _productKey,
        data: json.encode(favourites),
      );
    } catch (e) {
      return null;
    }
  }
}
