import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/local/shared_preference/shared_preference.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_cubit.dart';
import 'package:games_app/features/balance/presentation/cubit/balance_state.dart';
import 'package:games_app/styles/assets/asset_manager.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:games_app/styles/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateNewBalanceWidget extends StatelessWidget {
   CreateNewBalanceWidget({super.key});

  String paymentMethod='';

  TextEditingController customCodeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BalanceCubit, BalanceStates>(
      listener: (context,state){
         if(state is CreateTransactionSuccessState){
           BalanceCubit.get(context).paymentId='';
           BalanceCubit.get(context).currencyId='';
           BalanceCubit.get(context).image=null;
           BalanceCubit.get(context).amountController.text='';
           BalanceCubit.get(context).totalAmountController.text='';
           customCodeController.text='';
           Navigator.pop(context);
         }
      },
      builder: (context, state) {
        var cubit = BalanceCubit.get(context);
        return Scaffold(
          backgroundColor: UserDataFromStorage.themeIsDarkMode ? ColorManager.darkThemeBackgroundLight : Colors.grey[250],
          appBar:  AppBar(
            centerTitle: true,
            title: Text('شحن الرصيد',style: TextStyles.textStyle24Medium,
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall:  state is CreateCustomCodeLoadingState,
            progressIndicator: const CupertinoActivityIndicator(
              color:  ColorManager.primary,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width*.05,
                      vertical: MediaQuery.of(context).size.height*.02
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [

                      Row(
                        children: [

                          const Spacer(),

                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                if(cubit.paymentId==''){
                                  customToast(title: ' يرجى اختيار طريقة الدفع', color: Colors.red);
                                }else{
                                  if(cubit.currencyId==''){
                                    customToast(title: ' يرجى اختيار العملة', color: Colors.red);
                                  }else{
                                    if(cubit.image ==null){
                                      customToast(title: ' يرجى ارفاق صوره التحويل', color: Colors.red);
                                    }else{
                                      cubit.createTransaction(
                                        paymentId: cubit.paymentId,
                                        currencyId: cubit.currencyId,
                                        image: cubit.image!.path,
                                        amount: cubit.amountController.text,
                                      );
                                    }
                                  }
                                }

                              }
                            },
                            color: ColorManager.primary,
                            child: Row(
                              children: [
                                Text('ارسال الطلب', style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.white
                                ),),
                                SizedBox( width: MediaQuery.of(context).size.width*.02, ),
                                const Icon(Icons.send, color: ColorManager.white,size:  15,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      BlocBuilder<BalanceCubit, BalanceStates>(
                          builder: (context, state) {
                            return DropdownButton(
                                dropdownColor:  ColorManager.white,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: ColorManager.darkThemeBackground
                                ),
                                items: BalanceCubit.get(context).paymentMethodList,
                                hint: BalanceCubit.get(context).paymentMethod==''?
                                Text('اختر طريقة الدفع', style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                )):Text(BalanceCubit.get(context).paymentMethod, style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                )),
                                focusColor: Colors.white,
                                onChanged: (value){
                                  BalanceCubit.get(context).selectPaymentMethod(value: value.toString());
                                }
                            );
                          }
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      BlocBuilder<BalanceCubit, BalanceStates>(
                          builder: (context, state) {
                            return DropdownButton(
                                dropdownColor:  ColorManager.white,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: ColorManager.darkThemeBackground
                                ),
                                items: BalanceCubit.get(context).currencyList,
                                hint: BalanceCubit.get(context).currency==''?
                                Text('اختر العمله', style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                )):Text(BalanceCubit.get(context).currency, style: TextStyles.textStyle18Medium.copyWith(
                                    color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                                )),
                                focusColor: Colors.white,
                                onChanged: (value){

                                  BalanceCubit.get(context).selectCurrency(
                                      value: value.toString(),
                                  );
                                }
                            );
                          }
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      DefaultTextField(
                          controller: cubit.amountController,
                          hintText: 'المبلغ',
                          validator: (value){
                            if(value.isEmpty){
                              return 'ادخل المبلغ الذي سيتم دفعه';
                            }
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          fillColor: ColorManager.gray,
                          onChanged: (value){
                            if(cubit.amountController.text==''){
                              cubit.totalAmountController.text = '';
                            }
                            print('total is ${cubit.chargeRate* double.parse(cubit.amountController.text)}');
                            cubit.totalAmountController.text = '${cubit.chargeRate* double.parse(cubit.amountController.text)}';
                          },
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      DefaultTextField(
                          enable: false,
                          controller: cubit.totalAmountController,
                          hintText: 'المبلغ الذي سيتم استلامه بالدولار',
                          validator: (value){
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          fillColor: ColorManager.gray
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      DefaultTextField(
                          maxLines: 3,
                          controller: customCodeController,
                          hintText: 'ملاحظات',
                          validator: (value){
                            if(value.isEmpty){
                            }
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          fillColor: ColorManager.gray
                      ),

                      SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                      GestureDetector(
                        onTap: (){
                          cubit.pickMoneyTransactionImage();
                        },
                        child: Container(
                          height:  MediaQuery.of(context).size.height*.25,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(20),
                              border:  Border.all(
                                  color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black
                              )
                          ),
                          width: double.infinity,
                          child:
                          cubit.image==null?
                          Column(
                            children: [
                              Text('ارفق اثبات التحويل', style: TextStyles.textStyle18Medium.copyWith(
                                color: UserDataFromStorage.themeIsDarkMode ? ColorManager.white : ColorManager.black,),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox( height: MediaQuery.of(context).size.height*.02, ),

                              const Expanded(
                                child: Image(
                                  image: AssetImage(AssetManager.logo),
                                ),
                              ),

                            ],
                          ):
                          Image(
                            fit: BoxFit.contain,
                            image: FileImage(cubit.image!),
                          ),
                        ),
                        ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
