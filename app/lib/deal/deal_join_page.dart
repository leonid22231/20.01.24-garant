import 'package:app/api/RestClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Globals.dart';

class DealJoinPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DealJoinPage();

}
class _DealJoinPage extends State<DealJoinPage>{
  String? code;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
         backgroundColor: Globals.mainColor,
       appBar: AppBar(
         backgroundColor: Globals.mainColor,
         centerTitle: true,
         title: Text("Вступить в сделку"),
       ),
       body: Padding(
         padding: EdgeInsets.all(22.sp),
         child: Center(
           child: Column(
             children: [
               Text("Введите код для вступления в сделку"),
               SizedBox(height: 16.sp,),
               TextFormField(
                 onChanged: (value){
                   code = value;
                 },
                 textAlign: TextAlign.center,
                 decoration: InputDecoration(
                   filled: true,
                   fillColor: Globals.backgroundInputColor,
                   contentPadding: EdgeInsets.all(20.sp),
                   hintText: "Код",
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
               Spacer(),
               SizedBox(
                 width: double.maxFinite,
                 height: 34.sp,
                 child: ElevatedButton(
                   onPressed: () {
                     Dio dio = Dio();
                     RestClient client = RestClient(dio);
                     client.joinDeal(Globals.getToken(), code!).then((value){
                       Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                     });
                   },
                   style: ElevatedButton.styleFrom(
                       backgroundColor: Globals.buttonColor,
                       surfaceTintColor: Colors.white,
                       shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(40.sp),
                   )),
                   child: Text("Вступить",),
                 ),
               ),
             ],
           ),
         ),
       )
     );
  }

}