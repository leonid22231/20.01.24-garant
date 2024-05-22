import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/DialEntity.dart';
import 'package:app/deal/deal_code.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Globals.dart';

class DealCreatePage extends StatefulWidget{
  DialEntity dial;

  DealCreatePage({required this.dial, super.key});

  @override
  State<StatefulWidget> createState() => _DealCreatePage();

}
class _DealCreatePage extends State<DealCreatePage>{
  TextEditingController controller = TextEditingController();
  List<String> role = [
    "Покупатель",
    "Продавец"
  ];
  String? selectedRole;
  String? selectedPayer;
  String? price;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Globals.mainColor,
       appBar: AppBar(
         backgroundColor: Globals.mainColor,
         centerTitle: true,
         title: Text("Создание сделки", style: TextStyle(fontWeight: FontWeight.bold),),
       ),
       body: Padding(
         padding: EdgeInsets.all(20.sp),
         child: Column(
           children: [
             Container(
               decoration: BoxDecoration(
                   color: Color(0xff383F49),
                   borderRadius: BorderRadius.circular(50)
               ),
               width: double.maxFinite,
               child: Padding(
                 padding: EdgeInsets.all(12.sp),
                 child: DropdownButton(
                     onChanged: (_){
                       setState(() {
                         selectedRole = _!;
                       });
                     },
                     style: TextStyle(color: Globals.textInputColor),
                     value: selectedRole!=null?selectedRole:null,
                     hint: Text("Ваша роль в сделке"),
                     underline: Container(
                       height: 0,
                       color: Globals.mainColor,
                     ),
                     borderRadius: BorderRadius.circular(50),
                     isExpanded: true,
                     items: role.map((e){
                       return DropdownMenuItem(child: Text(e), value: e,);
                     }).toList()),
               ),
             ),
             SizedBox(height: 16.sp,),
             Container(
               decoration: BoxDecoration(
                   color: Color(0xff383F49),
                   borderRadius: BorderRadius.circular(50)
               ),
               width: double.maxFinite,
               child: Padding(
                 padding: EdgeInsets.all(12.sp),
                 child: DropdownButton(
                     onChanged: (_){
                       setState(() {
                         selectedPayer = _;
                       });
                     },
                     style: TextStyle(color: Globals.textInputColor),
                     hint: Text("Кто оплачивает комиссию"),
                     value: selectedPayer!=null?selectedPayer:null,
                     underline: Container(
                       height: 0,
                       color: Globals.mainColor,
                     ),
                     borderRadius: BorderRadius.circular(50),
                     isExpanded: true,
                     items: role.map((e){
                       return DropdownMenuItem(child: Text(e, style: TextStyle(color: Colors.black),), value: e,);
                     }).toList()),
               ),
             ),
             SizedBox(height: 16.sp,),
             TextFormField(
               keyboardType: TextInputType.number,
               inputFormatters: <TextInputFormatter>[
                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                 FilteringTextInputFormatter.digitsOnly

               ],
               controller: controller,
               onChanged: (value){
                 price = value;
               },
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Globals.backgroundInputColor,
                 contentPadding: EdgeInsets.all(20.sp),
                 hintText: "Цена",
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
                    if(selectedRole=="Покупатель"){
                      widget.dial.buyer = "yes";
                    }else{
                      widget.dial.seller = "yes";
                    }
                    client.createDeal(Globals.getToken(), widget.dial.name,widget.dial.type ,widget.dial.description, widget.dial.duration, double.parse(price!), widget.dial.seller, widget.dial.buyer).then((value){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DealCode(value)),
                      );
                    });
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

}