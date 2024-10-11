import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/auth/data/auth_repo/auth_repo.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';

class AuthRepoImplement implements AuthRepo{

  HttpHelper httpHelper = HttpHelper();
  @override
  Future<AuthModel> login({required String email, required String password}) async{

    AuthModel authModel=AuthModel();

    var parameter = {
      'email' : email,
      'password' : password
    };

    try{
      var response = await httpHelper.callService(
        responseType: ResponseType.post,
        url: loginUrl,
        parameter: parameter,
        authorization: false,
      );

      print('Login response: ${response.toString()}');
      authModel=AuthModel.fromJson(response);
      UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
      print('login success');

    }catch(e){
      print('Error in login: ${e.toString()}');
    }

    return authModel??AuthModel();

  }

  @override
  Future<AuthModel> register({
    required String email,
    required String password,
    required String name,
    required String phone
  }) async{
    AuthModel authModel=AuthModel();

    var parameter = {
      'email' : email,
      'password' : password,
      'name' : name,
      'phone' : phone,
    };

    print('parameter: ${parameter.toString()}');
    try{
      var response = await httpHelper.callService(
        responseType: ResponseType.post,
        url: registerUrl,
        parameter: parameter,
        authorization: false,
      );

      print('Register response: ${response.toString()}');
      authModel=AuthModel.fromJson(response);
      UserDataFromStorage.setUserTokenFromStorage(authModel.token!);
      print('register success');

    }catch(e){
      print('Error in login: ${e.toString()}');
    }

    return authModel??AuthModel();

  }

  @override
  Future<UserInfoModel> getUser() async{

    UserInfoModel userInfoModel = UserInfoModel();

    var response = await httpHelper.callService(
        url: getUserInfoUrl,
        responseType: ResponseType.get,
        authorization: true
    );

    print(response);

    userInfoModel=UserInfoModel.fromJson(response);
    print('Get user info: ${userInfoModel.toString()}');
    return userInfoModel??UserInfoModel();
  }


}