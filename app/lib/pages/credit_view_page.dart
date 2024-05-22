import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/pages/credit_select_confirm.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreditViewPage extends StatefulWidget{
  CreditEntity credit;

  CreditViewPage({required this.credit, super.key});

  @override
  State<StatefulWidget> createState() => _CreditViewPage();

}
class _CreditViewPage extends State<CreditViewPage>{
  bool garantView = false;
  @override
  Widget build(BuildContext context) {
    CreditEntity credit = widget.credit;
    return Scaffold(
      backgroundColor: Globals.mainColor,
        appBar: AppBar(
          backgroundColor: Globals.mainColor,
          centerTitle: true,
          title: Text("Займ", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color(0xff2D333C)
            ),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xff383F49)
                    ),
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(18.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Заемщик", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                          SizedBox(height: 8.sp,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Имя", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text(credit.borrower!.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                            ],
                          ),
                          SizedBox(height: 8.sp,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Фамилия", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text(credit.borrower!.surname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                            ],
                          ),
                          SizedBox(height: 8.sp,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Отчество", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text(credit.borrower!.patronymic, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                            ],
                          ),
                          SizedBox(height: 8.sp,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Телефон", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("+${credit.borrower!.phone}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                            ],
                          ),
                          SizedBox(height: 8.sp,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Дата рождения", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text(DateFormat("dd.MM.y").format(credit.borrower!.userDate), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                            ],
                          ),
                          SizedBox(height: 8.sp,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("E-mail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text(credit.borrower!.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18.sp,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xff383F49)
                    ),
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(18.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Процент", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${credit.percent.round()}%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Срок", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${credit.duration} дней", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Сумма", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${NumberFormat("##0,000", "kk").format(credit.value)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("C процентами", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${NumberFormat("##0,000", "kk").format((credit.value/100*credit.percent)+credit.value)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  credit.guarant!=null?SizedBox(height: 18.sp,):SizedBox.shrink(),
                  credit.guarant!=null?Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xff383F49)
                    ),
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(18.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                garantView = !garantView;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Гарантное лицо", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Icon(garantView?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 24.sp,)
                              ],
                            ),
                          ),
                          garantView?Column(
                            children: [
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Имя", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.guarant!.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Фамилия", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.guarant!.surname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Отчество", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.guarant!.patronymic, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Телефон", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text("+${credit.guarant!.phone}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ИИН", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.guarant!.identityCard, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                                ],
                              ),
                            ],
                          ):SizedBox.shrink()
                        ],
                      ),
                    ),
                  ):SizedBox.shrink(),
                  SizedBox(height: 14.sp,),
                  SizedBox(
                    width: double.maxFinite,
                    height: 34.sp,
                    child: ElevatedButton(
                      onPressed: () {
                        Dio dio = Dio();
                        RestClient client = RestClient(dio);
                        client.creditConfirm(Globals.getToken()).then((value){
                          if(value.statusCode==100){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreditSelectConfirm(creditId: widget.credit.id)),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Globals.buttonColor,
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.sp),
                      )),
                      child: Text("Дать взаймы", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}