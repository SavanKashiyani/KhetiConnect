import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/user.dart';
import '/data/api/api_service.dart';
import '/data/storage/storage_constants.dart';

class StorageService {
  final _box = Hive.box(box);

  bool hasData(String key) => _box.containsKey(key);

  String get authToken {
    return _box.get(authTokenKey) ?? '';
  }

  setAuthToken(String token) async {
    await _box.put(authTokenKey, token);
    GetIt.I.get<ApiService>().setAuthToken(token);
  }

  Locale get appLocale {
    return Locale(_box.get(appLocaleKey) ?? 'en');
  }

  set appLocale(Locale locale) {
    _box.put(appLocaleKey, locale.languageCode);
  }

  User get userInfo {
    return _box.get(userInfoKey) != null ? User.fromJson(json.decode(_box.get(userInfoKey) ?? User())) : User();
  }

  setUserInfo(User? user) async {
    if (user == null) {
      await remove(userInfoKey);
    } else {
      await _box.put(userInfoKey, json.encode(user.toJson()));
    }
  }

  Future<void> logout() async {
    await remove(box);
    await remove(appLocaleKey);
    await remove(authTokenKey);
    await remove(userInfoKey);
    await Hive.box(box).clear();
    await clear();
  }

  Future<int> clear() async => await _box.clear();

  Future<void> remove(String key) async => await _box.delete(key);

  bool get isUserLoggedIn => authToken.isNotEmpty;
}
