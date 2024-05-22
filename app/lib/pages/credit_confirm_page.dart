import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/api/entity/ParametersEntity.dart';
import 'package:app/loginbloc/login_bloc.dart';
import 'package:app/updatebloc/update_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditConfirm extends StatefulWidget{
  CreditEntity credit;
  ParametersEntity parameters;

  CreditConfirm({required this.credit, required this.parameters, super.key});

  @override
  State<StatefulWidget> createState() => _CreditConfirm();

}
class _CreditConfirm extends State<CreditConfirm>{
  String? code;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Globals.mainColor,
       ), backgroundColor: Globals.mainColor,
       body: Padding(
         padding: EdgeInsets.all(22.sp),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Align(alignment: Alignment.center,child: Text("Введите код", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),),),
             SizedBox(height: 15.sp,),
             Text("Пожалуйста введите код отправленный на ваш", style: TextStyle(fontSize: 16.sp, color: Color(0xff6E6F79)),textAlign: TextAlign.center,),
             Text("Номер телефона",style: TextStyle(fontSize: 16.sp, color: Color(0xff6E6F79)),),
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
                   String? phone;
                   if(widget.credit.number!=null && widget.credit.number![0]=="8"){
                     phone = widget.credit.number!.replaceFirst("8", "7");
                   }
                   client.createCredit(Globals.getToken(), widget.credit.duration, widget.credit.percent, widget.credit.value,code!, phone,widget.parameters).then((value){
                     if(value.statusCode==100){
                       final updatebloc = BlocProvider.of<UpdateBloc>(context);
                       updatebloc.add(
                         UpdateEventUpdate()
                       );
                       Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
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
       )
     );
  }

}