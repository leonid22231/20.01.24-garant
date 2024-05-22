import 'dart:typed_data';

import 'package:app/Globals.dart';
import 'package:app/appbarbloc/appbar_bloc.dart';
import 'package:app/appbarbloc/appbar_state_enum.dart';
import 'package:app/home_page.dart';
import 'package:app/login_page.dart';
import 'package:app/loginbloc/login_bloc.dart';
import 'package:app/loginpagebloc/loginpage_bloc.dart';
import 'package:app/loginpagebloc/loginstate.dart';
import 'package:app/pages/history_page.dart';
import 'package:app/pages/user_page.dart';
import 'package:app/updatebloc/update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(value: AppBarBloc()),
      BlocProvider.value(value: LoginBloc()),
      BlocProvider.value(value: LoginPageBloc()),
      BlocProvider.value(value: UpdateBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screentype){
      print(screentype);
      return MaterialApp(
        title: 'ae.com.kz',
        locale: const Locale("ru"),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("ru")
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Globals.secondColor, onPrimary: Colors.white, onSurface: Colors.white),
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 18.sp),
            bodyMedium: TextStyle(fontSize: 16.sp),
            bodySmall: TextStyle(fontSize: 14.sp)
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appbar = "login";
  bool showleading = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        centerTitle: true,
          leading: showleading?BlocBuilder<AppBarBloc, AppBarState>(
            builder: (context, state){
              if(state is AppBarLoaded){
                switch(state.state){
                  case AppBarStateEnum.REGISTER: return backButtonRegister();
                  case AppBarStateEnum.REGISTER_PAGE2: return backButtonRegister2();
                  case AppBarStateEnum.REGISTER_CONFIRM: return backButtonRegisterConfirm();
                  default: return SizedBox.shrink();
                }
              }else{
                return SizedBox();
              }
            },
          ):null,
          backgroundColor: Globals.mainColor,
        title: BlocBuilder<AppBarBloc, AppBarState>(
          builder: (context, state){
            if(state is AppBarLoaded){
              switch(state.state){
                case AppBarStateEnum.HOME: return appBarHome();
                case AppBarStateEnum.REGISTER: return appBarRegister();
                case AppBarStateEnum.REGISTER_PAGE2: return appBarRegister();
                default: return SizedBox();
              }
            }else{
              return SizedBox();
            }
          },
        ),
      ),
      body: FutureBuilder(future: getShared(), builder: (context, snapshot){
        if(snapshot.hasData) {
          String? token = snapshot.data!.getString("token");
          final loginBloc = BlocProvider.of<LoginBloc>(context);
          if (token != null) {
            loginBloc.add(
              LoginChangeState(true)
            );
            print("${token}");
            Globals.token = token;
          }else{
            loginBloc.add(
                LoginChangeState(false)
            );
          }
          return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
            if(state is LoginLoaded){
                if(state.login){
                  return HomePage();
                }else{
                  return LoginPage();
                }
            }
            return SizedBox();
          });
        }else{
          return SizedBox();
        }
      }),
    );
  }
  Widget backButtonRegister(){
    return IconButton(onPressed: (){
      final loginBloc = BlocProvider.of<LoginPageBloc>(context);
      loginBloc.add(
        LoginChangePage(LoginStateEnum.LOGIN)
      );
    }, icon:const Icon(Icons.arrow_back));
  }
  Widget backButtonRegister2(){
    return IconButton(onPressed: (){
      final loginBloc = BlocProvider.of<LoginPageBloc>(context);
      loginBloc.add(
          LoginChangePage(LoginStateEnum.REGISTER_PAGE1)
      );
    }, icon:const Icon(Icons.arrow_back));
  }
  Widget backButtonRegisterConfirm(){
    return IconButton(onPressed: (){
      final loginBloc = BlocProvider.of<LoginPageBloc>(context);
      loginBloc.add(
          LoginChangePage(LoginStateEnum.REGISTER_PAGE2)
      );
    }, icon:const Icon(Icons.arrow_back));
  }
  Widget appBarHome() {
    showleading = false;
    print("SPNEW ${19.sp}");
    return FutureBuilder(future: getImage(), builder: (context, snapshot){
      if(snapshot.hasData){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
              child: Container(
                width: 40.w,
                decoration: BoxDecoration(
                    color: Color(0xff2D333C),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(snapshot.data!, height: 11.w, width: 11.w,fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20.sp,),
                      Padding(padding: EdgeInsets.only(right: 9.sp),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff383F49),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Center(child: Icon(Icons.keyboard_arrow_down_outlined),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
              child: Container(
                height: 11.w + 8.sp,
                width: 11.w + 8.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xffB9BBBD))
                ),
                child: Center(child: SvgPicture.asset("assets/bell.svg", height: 20.sp, width: 20.sp,),),
              ),
            )
          ],
        );
      }else{
        return SizedBox();
      }
    });
  }
  Future<Uint8List> getImage() async {
    late http.Response response;
    response = await http
        .get(
        Uri.parse("http://89.23.117.164:8080/api/v1/user/avatar"),
        headers: {"Authorization":Globals.getToken()}
    )
        .timeout(const Duration(seconds: 7));
    Uint8List image = response.bodyBytes;
    return image;
  }
  Widget appBarLogin(){

      showleading = false;

    return Text("Вход в аккаунт", style: TextStyle(color: Colors.white),);
  }
  Widget appBarRegister(){

      showleading = true;

    return Text("Регистрация");
  }
  Future<SharedPreferences> getShared() async {
     return SharedPreferences.getInstance();
  }
}
