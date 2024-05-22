import 'dart:io';
import 'dart:math';

import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/appbarbloc/appbar_bloc.dart';
import 'package:app/appbarbloc/appbar_state_enum.dart';
import 'package:app/loginbloc/login_bloc.dart';
import 'package:app/loginpagebloc/loginpage_bloc.dart';
import 'package:app/loginpagebloc/loginstate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';



class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPage();

}
class _LoginPage extends State<LoginPage>{
  bool hidePassword = true;
  String phone = "";
  String psw = "";
  String? name,surname,patronymic,iin,email,password,passwordConfirm;
  DateTime? iinDateTime, userDateTime;
  bool imagePick = false;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  TextEditingController controller8 = TextEditingController();
  TextEditingController controller9 = TextEditingController();
  TextEditingController controller10 = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Debug ${kDebugMode}");
    if(kDebugMode){
      phone = "79504161115";
      name = "Леонид";
      surname = "Солдатов";
      patronymic = "Андреевич";
      iin = "11111111111";
      email = "lsoldatov.lenya@gmail.com";
      controller4.setText(name!);
      controller5.setText(surname!);
      controller6.setText(patronymic!);
      controller7.setText(iin!);
      controller8.setText(email!);
    }
    controller1.setText(phone);
    controller3.setText(phone);
  }
  @override
  Widget build(BuildContext context) {
    print("1SP ${Adaptive.sp(16)}");
    return BlocBuilder<LoginPageBloc, LoginPageState>(builder: (context, state){
      if(state is LoginPageLoaded){
          switch(state.state){
            case LoginStateEnum.LOGIN: return loginPage();
            case LoginStateEnum.REGISTER_PAGE1: return registerPage();
            case LoginStateEnum.REGISTER_PAGE2: return registerPage2();
            case LoginStateEnum.REGISTER_CONFIRM: return registerConfirm();
            default: return SizedBox(child: Center(child: Text("ERROR"),),);
          }
      }else{
        return SizedBox();
      }
    });
  }
Widget loginPage(){
  final appbarBloc = BlocProvider.of<AppBarBloc>(context);
  appbarBloc.add(
      AppBarChangeState(AppBarStateEnum.LOGIN)
  );
    return SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(22.sp),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 75.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(alignment: Alignment.center, child: Text("Вход в аккаунт", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),),),
                          SizedBox(height: 34.sp,),
                          TextFormField(
                            controller: controller1,
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              phone = value;
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly

                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Globals.backgroundInputColor,
                              contentPadding: EdgeInsets.all(20.sp),
                              hintText: "Телефон",
                              hintStyle: TextStyle(color: Globals.textInputColor),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                                  borderSide: BorderSide.none
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                          SizedBox(height: 16.sp,),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              TextFormField(
                                onChanged: (value){
                                  psw = value;
                                },
                                controller: controller2,
                                obscureText: hidePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Globals.backgroundInputColor,
                                  contentPadding: EdgeInsets.all(20.sp),
                                  hintText: "Пароль",
                                  hintStyle: TextStyle(color: Globals.textInputColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                                      borderSide: BorderSide.none
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                                      borderSide: BorderSide.none
                                  ),
                                ),
                              ),
                              Align(alignment: Alignment.centerRight,child: Padding(padding: EdgeInsets.only(right: 20.sp),child: IconButton(icon: hidePassword?SvgPicture.asset("assets/password_visible.svg", height: 19.sp, width: 19.sp,):SvgPicture.asset("assets/password_visible.svg", color: Colors.white, height: 19.sp, width: 19.sp,),onPressed: (){
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },),),),
                            ],
                          ),
                          SizedBox(
                            height: 34.sp,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {

                                },
                                child: Text("Восстановить пароль", style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 34.sp,
                            child: ElevatedButton(
                              onPressed: () {
                                  Dio dio = Dio();
                                  RestClient client = RestClient(dio);
                                  if(phone[0]=="8"){
                                    phone = phone.replaceFirst("8", "7");
                                  }
                                  print(phone);
                                  client.login(phone, psw).then((value) async {
                                    if(value.statusCode==100){
                                      SharedPreferences shared = await SharedPreferences.getInstance();
                                      shared.setString("token", value.message!);
                                      Globals.token = value.message!;
                                      final loginbloc = BlocProvider.of<LoginBloc>(context);
                                      loginbloc.add(
                                          LoginChangeState(true)
                                      );
                                    }else{
                                      error(value.message);
                                    }
                                  });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Globals.buttonColor,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.sp),
                              )),
                              child: Text("Вход",),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Нет аккаунта?"),
                          SizedBox(width: 5.sp,),
                          TextButton(onPressed: (){
                            final loginbloc = BlocProvider.of<LoginPageBloc>(context);
                            loginbloc.add(
                                LoginChangePage(LoginStateEnum.REGISTER_PAGE1)
                            );
                          }, child: Text("Регистрация", style: TextStyle(color: Globals.buttonColor),))
                        ],
                      )
                  ],
                ),
          ),
    );
}
Widget registerPage(){
  final appbarbloc = BlocProvider.of<AppBarBloc>(context);
  appbarbloc.add(
      AppBarChangeState(AppBarStateEnum.REGISTER)
  );
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(22.sp),
      child: Column(
        children: [
          SizedBox(
            height: 74.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  GestureDetector(
                    onTap: () async {
                        print("Click");
                        image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          imagePick = true;
                        });
                    },
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: !imagePick?Icon(Icons.person, size: 30.w, color: Color(0xFFE9E9F0),):ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(File(image!.path), height: 30.w, width: 30.w,fit: BoxFit.cover,),
                            ),
                          ),
                          Align(alignment: Alignment.bottomRight, child: SvgPicture.asset("assets/edit.svg", height: 23.sp, width: 23.sp,),)
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller3,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    phone = value;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly

                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "Телефон",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller4,
                  onChanged: (value){
                    name = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "Имя",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller5,
                  onChanged: (value){
                    surname = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "Фамилия",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller6,
                  onChanged: (value){
                    patronymic = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "Отчество",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                GestureDetector(
                  onTap: (){
                    showCupertinoDialog(context: context, builder: (context){
                      return Center(
                        child: Container(
                          height: 50.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.sp),
                            child: SfDateRangePicker(
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                textStyle: TextStyle(
                                  fontSize: 16.sp
                                )
                              ),
                              showActionButtons: true,
                              onSubmit: (_){
                                Navigator.of(context).pop();
                              },
                              onCancel: (){
                                Navigator.of(context).pop();
                              },
                              cancelText: "Отмена",
                              confirmText: "Ok",
                              onSelectionChanged: (args){
                                setState(() {
                                  userDateTime = args.value;
                                });
                              },
                              selectionMode: DateRangePickerSelectionMode.single,
                              initialDisplayDate: DateTime.now().add(Duration(days: -365*18)),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Globals.backgroundInputColor,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: userDateTime==null?Text("Дата рождения"):Text(DateFormat("dd.MM.y").format(userDateTime!)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 34.sp,
            child: ElevatedButton(
              onPressed: () {
                final loginbloc = BlocProvider.of<LoginPageBloc>(context);
                loginbloc.add(
                    LoginChangePage(LoginStateEnum.REGISTER_PAGE2)
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Globals.buttonColor,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.sp),
              )),
              child: Text("Далее",),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget registerPage2(){
  final appbarbloc = BlocProvider.of<AppBarBloc>(context);
  appbarbloc.add(
      AppBarChangeState(AppBarStateEnum.REGISTER_PAGE2)
  );
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(22.sp),
      child: Column(
        children: [
          SizedBox(
            height: 74.h,
            child: Column(
              children: [
                TextFormField(
                  controller: controller7,
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    iin = value;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly

                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "ИИН",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                GestureDetector(
                  onTap: (){
                    showCupertinoDialog(context: context, builder: (context){
                      return Center(
                        child: Container(
                          height: 50.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.sp),
                            child: SfDateRangePicker(
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                textStyle: TextStyle(
                                  fontSize: 16.sp
                                )
                              ),
                              showActionButtons: true,
                              onSubmit: (_){
                                Navigator.of(context).pop();
                              },
                              onCancel: (){
                                Navigator.of(context).pop();
                              },
                              cancelText: "Отмена",
                              confirmText: "Ok",
                              onSelectionChanged: (args){
                                setState(() {
                                  iinDateTime = args.value;
                                });
                              },
                              selectionMode: DateRangePickerSelectionMode.single,
                              initialDisplayDate: DateTime.now().add(Duration(days: -365*18)),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Globals.backgroundInputColor,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: iinDateTime==null?Text("Дата выдачи удостоверение"):Text(DateFormat("dd.MM.y").format(iinDateTime!)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller8,
                  onChanged: (value){
                    email = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller9,
                  onChanged: (value){
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "Пароль",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 16.sp,),
                TextFormField(
                  controller: controller10,
                  onChanged: (value){
                    passwordConfirm = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Globals.backgroundInputColor,
                    contentPadding: EdgeInsets.all(20.sp),
                    hintText: "Повторите пароль",
                    hintStyle: TextStyle(color: Globals.textInputColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 34.sp,
            child: ElevatedButton(
              onPressed: () async {
                Dio dio = Dio();
                RestClient client = RestClient(dio);
                if(phone[0]=="8"){
                  phone = phone.replaceFirst("8", "7");
                }
                print(phone);
                if(!imagePick){
                  client.register(phone, name!, surname!, patronymic!, iin!, email!, password!,userDateTime!,iinDateTime!).then((value){
                    if(value!=null){
                      if(value.statusCode==100){
                        Globals.token = value.json!;
                        final loginbloc = BlocProvider.of<LoginPageBloc>(context);
                        loginbloc.add(
                            LoginChangePage(LoginStateEnum.REGISTER_CONFIRM)
                        );
                      }else{
                        error(value.message);
                      }
                    }else{
                      error(null);
                    }
                  });
                }else{
                  File file = File(image!.path);
                  client.registerandimage(phone, name!, surname!, patronymic!, iin!, email!, password!,userDateTime!,iinDateTime!,file).then((value){
                    if(value!=null){
                      if(value.statusCode==100){
                        Globals.token = value.json!;
                        final loginbloc = BlocProvider.of<LoginPageBloc>(context);
                        loginbloc.add(
                            LoginChangePage(LoginStateEnum.REGISTER_CONFIRM)
                        );
                      }else{
                        error(value.message);
                      }
                    }else{
                      error(null);
                    }
                  });
                }
                print("Number ${phone}");
                print("Name ${name}");
                print("Surname ${surname}");
                print("Patronymic ${patronymic}");
                print("Iin ${iin}");
                print("E-mail ${email}");
                print("Password ${password}");
                print("Password conf ${passwordConfirm}");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Globals.buttonColor,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.sp),
              )),
              child: Text("Регистрация",),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget registerConfirm(){
    final appbarbloc = BlocProvider.of<AppBarBloc>(context);
    appbarbloc.add(AppBarChangeState(AppBarStateEnum.REGISTER_CONFIRM));
    String code = "";
    return Padding(
        padding: EdgeInsets.all(22.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(alignment: Alignment.center,child: Text("Введите код", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),),),
          SizedBox(height: 15.sp,),
          Text("Пожалуйста введите код отправленный на", style: TextStyle(fontSize: 16.sp, color: Color(0xff6E6F79)),),
          Text("+$phone",style: TextStyle(fontSize: 16.sp, color: Color(0xff6E6F79)),),
          SizedBox(height: 25.sp,),
          Pinput(
            length: 4,
            obscureText: true,
            obscuringWidget: Icon(Icons.close, color: Globals.secondColor,),
            onChanged: (value){
              code = value;
            },
          ),
          SizedBox(height: 25.sp,),
          SizedBox(
            width: double.maxFinite,
            height: 34.sp,
            child: ElevatedButton(
              onPressed: () async {
                 Dio dio = Dio();
                 RestClient client = RestClient(dio);
                 client.registerConfirm(Globals.getToken(), code).then((value) async {
                   if(value!=null){
                     if(value.statusCode==100){
                       SharedPreferences shared = await SharedPreferences.getInstance();
                       shared.setString("token", value.message!);
                       Globals.token = value.message!;
                       final loginbloc = BlocProvider.of<LoginBloc>(context);
                       loginbloc.add(
                         LoginChangeState(true)
                       );
                     }else{
                       error(value.message);
                     }
                   }
                 });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Globals.buttonColor,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.sp),
              )),
              child: Text("Подтвердить",),
            ),
          ),
          SizedBox(height: 21.sp,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Не получил код?", style: TextStyle(color: Color(0xff6E6F79)),),
              SizedBox(width: 5.sp,),
              TextButton(onPressed: (){
                Dio dio = Dio();
                RestClient client = RestClient(dio);
                client.resendCode(Globals.getToken());
              }, child: Text("Отправить повторно", style: TextStyle(color: Globals.buttonColor),))
            ],
          )
        ],
      ),
    );
}
error(String? error){
    if(error==null){
      print("Error");
    }else{
      print("Error ${error}");
    }
}
}