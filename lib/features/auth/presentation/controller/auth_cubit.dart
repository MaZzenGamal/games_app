import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/urls.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/auth/data/auth_repo_implement/auth_repo_implement.dart';
import 'package:games_app/features/auth/data/models/auth_model.dart';
import 'package:games_app/features/auth/data/models/user_info_model.dart';
import 'package:games_app/features/auth/presentation/controller/auth_states.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/toast.dart';

import '../../../home/presentation/controller/currency_cubit/currency_cubit.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController password2RegisterController = TextEditingController();
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController phoneRegisterController = TextEditingController();


  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  TextEditingController emailProfileController = TextEditingController();
  TextEditingController phoneProfileController = TextEditingController();
  TextEditingController nameProfileController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  AuthModel ?loginModel;
  AuthModel ?registerModel;
  UserInfoModel ?userInfoModel;

  Future<void> createNewAccount({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context
   })async{

    emit(CreateAccountLoadingState());
      registerModel= await AuthRepoImplement().register(
          email: email,
          password: password,
          name: name,
          phone: phone
      );
      if(registerModel!.token != null){
        print('Token: ${registerModel!.token}');
        UserDataFromStorage.setGender(registerModel!.role!);
        await getUserInfo();
        emit(CreateAccountSuccessState());
      }else{
        print('Error in register ${registerModel}');
        customToast(title: 'هذه القيمة مُستخدمة من قبل.', color: Colors.red);
        emit(CreateAccountErrorState());

    }

  }


  Future<void> loginWithApi({
    required String email,
    required String password,
    required BuildContext context
  })async{

    emit(LoginLoadingState());
    loginModel= await AuthRepoImplement().login(
        email: email,
        password: password,
    );
    if(loginModel!.token != "" && loginModel!.token !=null){
      print('Token: ${loginModel!.token}');
      UserDataFromStorage.setGender(loginModel!.role!);
      await getUserInfo();
      emit(LoginSuccessState());
    }else {
      customToast(title: 'البريد او كلمه السر غير صحيحه', color: Colors.red);
      emit(LoginErrorState());
    }
    }

  Future<void> getUserInfo()async{

    emit(GetUserLoadingState());
    userInfoModel= await AuthRepoImplement().getUser();
    if(userInfoModel != null){
      UserDataFromStorage.setFullName(userInfoModel!.name!);
      UserDataFromStorage.setPhoneNumber(userInfoModel!.phone??'');
      UserDataFromStorage.setEmail(userInfoModel!.email!);
      UserDataFromStorage.setDistCustomEarning(userInfoModel!.dist_custom_earning!);
      print('Value of custom dist: ${userInfoModel!.dist_custom_earning}');
      UserDataFromStorage.setBalance(double.parse(userInfoModel!.balance!.toString()));
      emailProfileController.text=userInfoModel!.email!;
      phoneProfileController.text=userInfoModel!.phone??'';
      nameProfileController.text=userInfoModel!.name!;
      print('get user info');
      emit(GetUserSuccessState());
    }else {
      customToast(title: 'حدث خطا اثناء الحصول ع البيانات', color: Colors.red);
      emit(GetUserErrorState());
    }
  }

  Future<void> loginWithGoogle({required BuildContext context})async{

    await AuthRepoImplement().loginWithGoogle().then((value) async{
      await loginWithAccessToken(accessToken: value, context: context);
    });

   emit(GetGoogleInfoState());

  }

  AuthModel? googleModel;

  Future <void> loginWithAccessToken({
    required String accessToken,
    required BuildContext context
  })async{

    emit(LoginWithGoogleLoadingState());

    var googleModel = await AuthRepoImplement().loginWithAccessToken(
        accessToken: accessToken
    );

   if(googleModel.token != "" && googleModel.token != null){
     print('Token: ${googleModel.token}');
     UserDataFromStorage.setGender(googleModel.role!);
     await getUserInfo();
     emit(LoginWithGoogleSuccessState());
   }else {
     customToast(title: 'حدث خطا حاول مره اخري', color: Colors.red);

     emit(LoginWithGoogleErrorState());
   }

  }


  HttpHelper httpHelper = HttpHelper();

  Future <void> logout()async{

    emit(LogoutLoadingState());

     try{
       var response =  await httpHelper.callService(
         responseType: ResponseType.post,
         url: UrlConstants.logoutUrl,
         authorization: true,
       );
       UserDataFromStorage.setUserTokenFromStorage('');
       print(UserDataFromStorage.userTokenFromStorage);

       print('Logout Successfully');
       emit(LogoutSuccessState());
     }catch(error){
       print('error in logout is $error');
       emit(LogoutErrorState());
     }


  }


  Future <void> forgetPassword({
   required String email
  })async{

    emit(ForgetPasswordLoadingState());

    try{
      var response =  await httpHelper.callService(
        responseType: ResponseType.post,
        url: UrlConstants.forgetPasswordUrl,
        authorization: true,
        parameter: {
          'email':email,
        }
      );

      if(response['message'] == 'User not Found'){
        customToast(title: 'البريد الالكتروني غير موجود', color:ColorManager.error);
      }else if(response['message'] == 'Password reset link sent to your email.'){
        customToast(title: 'تم ارسال رابط تغيير كلمه السر', color:ColorManager.primary);
      }else{
        customToast(title: 'حدث خطا حاول مره اخري', color: Colors.red);
      }

      emit(ForgetPasswordSuccessState());
    }catch(error){
      print('error in forget password is $error');
      emit(ForgetPasswordErrorState());
    }


  }


}