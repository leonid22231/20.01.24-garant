import 'dart:io';
import 'dart:typed_data';

import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/MessageEntityUser.dart';
import 'package:app/api/entity/UserEntity.dart';
import 'package:app/appbarbloc/appbar_bloc.dart';
import 'package:app/appbarbloc/appbar_state_enum.dart';
import 'package:app/loginbloc/login_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _UserPage();
}
class _UserPage extends State<UserPage>{
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getUser(), builder: (context, snapshot){
      if(snapshot.hasData){
        UserEntity user = snapshot.data!.json;
        return Scaffold(
          backgroundColor: Globals.mainColor,
          appBar: AppBar(
              backgroundColor: Globals.mainColor,
              centerTitle: true,
              title: Text("+${user.phone}", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              children: [
                FutureBuilder(future: getImage(), builder: (context,snapshot){
                  if(snapshot.hasData){
                    return GestureDetector(
                      onTap: () async {
                        image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          this.image = image;
                        });
                        if(image!=null){
                          File file = File(image!.path);
                          Dio dio = Dio();
                          RestClient client = RestClient(dio);
                          client.changeAvatar(Globals.getToken(), file).then((value){

                            final appbarbloc = BlocProvider.of<AppBarBloc>(context);
                            appbarbloc.add(
                              AppBarChangeState(AppBarStateEnum.HOME)
                            );
                          });
                        }
                      },
                      child: Container(
                        height: 30.w,
                        width: 30.w,
                        child: Stack(
                          children: [
                            Container(
                              height: 30.w,
                              width: 30.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: image==null?Image.memory(snapshot.data!, height: 30.w, width: 30.w,fit: BoxFit.cover,):Image.file(File(image!.path), height: 30.w, width: 30.w,fit: BoxFit.cover,),
                              ),
                            ),
                            Align(alignment: Alignment.bottomRight, child: Padding(padding: EdgeInsets.all(8.sp),child: SvgPicture.asset("assets/edit.svg"),),)
                          ],
                        ),
                      ),
                    );
                  }else{
                    return SizedBox.shrink();
                  }
                }),
                SizedBox(height: 18.sp,),
                field(user.name),
                SizedBox(height: 18.sp,),
                field(user.surname),
                SizedBox(height: 18.sp,),
                field(user.patronymic),
                SizedBox(height: 18.sp,),
                field(user.email),
                SizedBox(height: 18.sp,),
                field(user.identityCard),
                SizedBox(height: 18.sp,),
                SizedBox(
                  width: double.maxFinite,
                  height: 34.sp,
                  child: ElevatedButton(
                    onPressed: () async {
                        SharedPreferences shared = await SharedPreferences.getInstance();
                        shared.remove("token");
                        Globals.token = "";
                        final loginbloc = BlocProvider.of<LoginBloc>(context);
                        loginbloc.add(
                          LoginChangeState(false)
                        );
                        Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        surfaceTintColor: Colors.white,
                        shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.sp),
                    )),
                    child: Text("Выйти из аккаунт", style: TextStyle(color: Colors.white, fontSize: 18.sp),),
                  ),
                ),
              ],
            ),
          ),
        );
      }else{
        print(snapshot.error);
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
  Widget field(String text){
    return Container(
      width: double.maxFinite,
      height: 34.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xff383F49)
      ),
      child: Center(
        child: Text(text, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
      ),
    );
  }
Future<MessageEntityUser> getUser(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.getInfo(Globals.getToken());
}
}