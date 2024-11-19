import 'dart:convert';

import '../../../../../core/core.dart';
import '../../../user.dart';

abstract class LocalAuth {
  Future<bool>? addUserToCache(UserModel userModel);
  UserModel? getUserFromCache();
  Future<bool?> clearCache();
}

class AuthSharedPreferencesImpl implements LocalAuth {
  final SharedPreferencesDB authPreferences;
  AuthSharedPreferencesImpl({required this.authPreferences});

  @override
  Future<bool>? addUserToCache(UserModel userModel) async {
    final userData = json.encode(userModel.toJson());
    return await authPreferences.setString(
        key: AppTexts.authUserToCacheKey, value: userData)!;
  }

  @override
  UserModel? getUserFromCache() {
    final user = authPreferences.getString(key: AppTexts.authUserToCacheKey);
    if (user == null) {
      return null;
    }
    return UserModel.fromJson(json.decode(user));
  }

  @override
  Future<bool?> clearCache() async {
    return await authPreferences.remove(key: AppTexts.authUserToCacheKey);
  }
}
