import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/api/entity/GuarantEntity.dart';
import 'package:app/api/entity/RequisitesEntity.dart';
import 'package:app/pages/bank_list_page.dart';
import 'package:app/pages/guarantors_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreditPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CreditPage();

}
class _CreditPage extends State<CreditPage>{
  int procent = 10;
  int days = 5;
  int summ = 5000;
  String? phone;
  GuarantEntity? guarant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        centerTitle: true,
        title: Text("Взять займ", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
        backgroundColor: Globals.mainColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Процент", style: TextStyle(fontSize: 17.sp),),
                                    Text("$procent%", style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                                  ],
                                ),
                                FlutterSlider(
                                  values: [procent.px],
                                  handler: FlutterSliderHandler(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Container(
                                      width: 10.w,
                                      height: 10.w,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        type: MaterialType.canvas,
                                        color: Globals.buttonColor.withOpacity(0.3),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.sp),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Globals.buttonColor
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  trackBar: FlutterSliderTrackBar(
                                    inactiveTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff343B46),
                                    ),
                                    inactiveTrackBarHeight: 8.sp,
                                    activeTrackBarHeight: 10.sp,
                                    activeTrackBar: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Globals.buttonColor
                                    ),
                                  ),
                                  onDragging: (handlerIndex, lowerValue, upperValue){
                                    double value = lowerValue;
                                    setState(() {
                                      procent = value.round();
                                    });
                                  },
                                  tooltip: FlutterSliderTooltip(
                                      disabled: true,
                                      format: (String value) {
                                        return value.replaceAll(".0", "") + '%';
                                      }
                                  ),
                                  min: 1,
                                  max: 50,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("1%", style: TextStyle(color: Color(0xffB9BBBD))),
                                    Text("50%", style: TextStyle(color: Color(0xffB9BBBD)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.sp,),
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Сумма", style: TextStyle(fontSize: 17.sp)),
                                    Text("${NumberFormat("##0,000", "kk").format(summ)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}" , style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                                  ],
                                ),
                                FlutterSlider(
                                  values: [summ.px],
                                  handler: FlutterSliderHandler(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Container(
                                      width: 10.w,
                                      height: 10.w,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        type: MaterialType.canvas,
                                        color: Globals.buttonColor.withOpacity(0.3),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.sp),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Globals.buttonColor
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  trackBar: FlutterSliderTrackBar(
                                    inactiveTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff343B46),
                                    ),
                                    inactiveTrackBarHeight: 8.sp,
                                    activeTrackBarHeight: 10.sp,
                                    activeTrackBar: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Globals.buttonColor
                                    ),
                                  ),
                                  onDragging: (handlerIndex, lowerValue, upperValue){
                                    double value = lowerValue;
                                    setState(() {
                                      summ = value.round();
                                    });
                                  },
                                  step: FlutterSliderStep(step: 500),
                                  tooltip: FlutterSliderTooltip(
                                      disabled: true,
                                      format: (String value) {
                                        return value.replaceAll(".0", "") + '%';
                                      }
                                  ),
                                  min: 3000,
                                  max: 70000,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("3 000 ${ NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(color: Color(0xffB9BBBD))),
                                    Text("70 000 ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(color: Color(0xffB9BBBD)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.sp,),
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Срок", style: TextStyle(fontSize: 17.sp)),
                                    Text("$days д.", style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                                  ],
                                ),
                                FlutterSlider(
                                  values: [days.px],
                                  handler: FlutterSliderHandler(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Container(
                                      width: 10.w,
                                      height: 10.w,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(50),
                                        type: MaterialType.canvas,
                                        color: Globals.buttonColor.withOpacity(0.3),
                                        elevation: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.sp),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Globals.buttonColor
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  trackBar: FlutterSliderTrackBar(
                                    inactiveTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff343B46),
                                    ),
                                    inactiveTrackBarHeight: 8.sp,
                                    activeTrackBarHeight: 10.sp,
                                    activeTrackBar: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Globals.buttonColor
                                    ),
                                  ),
                                  onDragging: (handlerIndex, lowerValue, upperValue){
                                    double value = lowerValue;
                                    setState(() {
                                      days = value.round();
                                    });
                                  },
                                  tooltip: FlutterSliderTooltip(
                                      disabled: true,
                                      format: (String value) {
                                        return value.replaceAll(".0", "") + 'д.';
                                      }
                                  ),
                                  min: 5,
                                  max: 92,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("5 д.", style: TextStyle(color: Color(0xffB9BBBD))),
                                    Text("3 мес.", style: TextStyle(color: Color(0xffB9BBBD)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.sp,),
                        TextFormField(
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
                            hintText: "Телефон заемщика",
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
                        SizedBox(height: 12.sp,),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GuarantorsPage()),
                            ).then((value){
                              setState(() {
                                guarant = value;
                              });
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xff383F49)
                            ),
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsets.all(18.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(guarant==null?"Гарантное лицо":"${guarant!.surname} ${guarant!.name} ${guarant!.patronymic}", style: TextStyle(fontSize: 18.sp),),
                                          SizedBox(height: 15.sp,),
                                          Text(guarant==null?"Выберите гарантное лицо":"+${guarant!.phone}", style: TextStyle(color: Color(0xffB9BBBD)),)
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Globals.buttonColor)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Center(child: Icon(Icons.keyboard_arrow_right, color: Globals.buttonColor,),),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.sp,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.sp),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(child: Align(alignment: Alignment.centerLeft,child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Сумма", style: TextStyle(fontSize: 14.sp, color: Color(0xffB9BBBD)),),
                                      Text("к возврату", style: TextStyle(fontSize: 14.sp, color: Color(0xffB9BBBD)),),
                                      SizedBox(height: 5.sp,),
                                      Text("${(summ/100)*procent+summ} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}")
                                    ],
                                  ),),),
                                  Align(alignment: Alignment.center,child: VerticalDivider(
                                    color: Colors.white,
                                    width: 1.px,
                                    indent: 15.sp,
                                    endIndent: 15.sp,
                                  ),),
                                  Flexible(child: Align(alignment: Alignment.centerRight, child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Срок до", style: TextStyle(fontSize: 14.sp, color: Color(0xffB9BBBD)),),
                                      Text("(включительно)", style: TextStyle(fontSize: 14.sp, color: Color(0xffB9BBBD)),),
                                      SizedBox(height: 5.sp,),
                                      Text(DateFormat("dd.MM.y").format(DateTime.now().add(Duration(days: days))))
                                    ],
                                  ),))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14.sp,),
                SizedBox(
                  width: double.maxFinite,
                  height: 34.sp,
                  child: ElevatedButton(
                    onPressed: () {
                      CreditEntity credit = CreditEntity(id: "", value: summ.toDouble(), percent: procent.toDouble(), duration: days,number: phone ,lastStatus: '', lastStatusTime: DateTime.now(), requisites: RequisitesEntity(bankName: '', cardNumber: '', bikNumber: ''));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BankListPage(creditEntity: credit, guarant: guarant,)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Globals.buttonColor,
                        surfaceTintColor: Colors.white,
                        shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.sp),
                    )),
                    child: Text("Оформить займ", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}