import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/api/entity/MessageEntityCreditList.dart';
import 'package:app/pages/credit_view_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class CreditListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CreditListPage();

}
class _CreditListPage extends State<CreditListPage>{
  int minDays = 5;
  int maxDays = 92;
  int minProcent = 1;
  int maxProcent = 50;
  int minSumm = 3000;
  int maxSumm = 70000;
  int garant = 0;
  Future<MessageEntityCreditList>? list;
  @override
  void initState() {
    list = getAllCredit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        centerTitle: true,
        title: Text(
          "Стать заемщиком",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showTopModalSheet(context, TopModal(
                  minDays: minDays,
                  maxDays: maxDays,
                  minProcent: minProcent,
                  maxProcent: maxProcent,
                  minSumm: minSumm,
                  maxSumm: maxSumm,
                  garant: garant,
                  onGarant: (value){
                    setState(() {
                      garant = value;
                    });
                  },
                  onDayDrag: (minDay, maxDay){
                    setState(() {
                      minDays = minDay;
                      maxDays = maxDay;
                      list = getAllCredit();
                    });
                  },
                  onProcentDrag: (minProcent, maxProcent){
                    setState(() {
                      this.minProcent = minProcent;
                      this.maxProcent = maxProcent;
                      list = getAllCredit();
                    });
                  },
                  onSummDrag: (minSumm, maxSumm){
                    setState(() {
                      this.minSumm = minSumm;
                      this.maxSumm = maxSumm;
                      list = getAllCredit();
                    });
                  },
                )
                );
              },
              icon: SvgPicture.asset(
                "assets/settings.svg",
                height: 20.sp,
                width: 20.sp,
              ))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: FutureBuilder(
            future: list,
            builder: (context, snapshot){
              if(snapshot.hasData){
                List<CreditEntity> list = filter(snapshot.data!.json);
                print("update");
                return Container(
                  decoration: BoxDecoration(
                      color: Color(0xff2D333C),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: list.isNotEmpty?ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              GestureDetector(onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CreditViewPage(credit: list[index])),
                                );
                              },child: credit(list[index]),),
                              SizedBox(height: 18.sp,)
                            ],
                          );
                        }):Container(width: double.maxFinite,child: Center(child: Text("Займов не найдено!", style: TextStyle(color: Color(0xffEEE364), fontWeight: FontWeight.bold, fontSize: 18.sp),),),),
                  ),
                );
              }else{
                print(snapshot.error);
                return Center(child: Text("Загрузка..."),);
              }
            },
          ),
        ),
    );
  }
  Widget credit(CreditEntity creditEntity){
      return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Color(0xff383F49)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Процент", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                  Text("${creditEntity.percent.round()}%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Color(0xffEEE364)),),
                ],
              ),
              SizedBox(height: 12.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Срок", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  Text("${creditEntity.duration} дней", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Color(0xffEEE364)),),
                ],
              ),
              SizedBox(height: 12.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Сумма", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  Text("${NumberFormat("##0,000", "kk").format(creditEntity.value)}${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Color(0xffEEE364)),),
                ],
              ),
              SizedBox(height: 12.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Гарант", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                  Text(creditEntity.guarant!=null?"Есть":"Нет", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Color(0xffEEE364)),),
                ],
              ),
            ],
          ),
        ),
      );
  }
  List<CreditEntity> filter(List<CreditEntity> list){
    print("Filtering...");
    List<CreditEntity> list_ = [];
    for(int i = 0; i < list.length; i++){
      CreditEntity credit = list[i];
      print("${garant}");
      if(credit.value.round()>= minSumm && credit.value.round()<= maxSumm){
        if(credit.percent.round()>= minProcent && credit.percent.round() <= maxProcent){
          if(credit.duration >= minDays && credit.duration <= maxDays){
              if(garant==0){
                list_.add(credit);
              }else if(garant==1){
                if(credit.guarant!=null){
                  list_.add(credit);
                }
              }else if(garant==2){
                print("Garant 2");
                if(credit.guarant==null){
                  list_.add(credit);
                }
              }
          }
        }
      }
    }
    return list_;
  }
Future<MessageEntityCreditList> getAllCredit(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.findAllCredit(Globals.getToken());
}
}
class TopModal extends StatefulWidget {
  Function(int minDays, int maxDays) onDayDrag;
  Function(int minProcent,int maxProcent) onProcentDrag;
  Function(int minSumm,int maxSumm) onSummDrag;
  Function(int garant) onGarant;
  int minDays,maxDays,minProcent,maxProcent,minSumm,maxSumm, garant;
  TopModal({required this.onDayDrag,required this.onProcentDrag, required this.onSummDrag, required this.minSumm,required this.maxSumm,required this.minDays,required this.maxDays,required this.minProcent,required this.maxProcent, required this.onGarant,required this.garant,super.key});

  @override
  State<StatefulWidget> createState() => _TopModal();
}
class _TopModal extends State<TopModal>{
  int minDays = 5;
  int maxDays = 92;
  int minProcent = 1;
  int maxProcent = 50;
  int minSumm = 3000;
  int maxSumm = 70000;
  int garant = 0;
  @override
  void initState() {
    minDays = widget.minDays;
    maxDays = widget.maxDays;
    minProcent = widget.minProcent;
    maxProcent = widget.maxProcent;
    minSumm = widget.minSumm;
    maxSumm = widget.maxSumm;
    garant = widget.garant;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff2D333C),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).viewPadding.top+13.sp),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Color(0xff2D333C)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Фильтр", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),),
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
                            Text("Процент", style: TextStyle(fontSize: 17.sp),),
                            Text("$minProcent-$maxProcent%", style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                          ],
                        ),
                        FlutterSlider(
                          values: [minProcent.toDouble(),maxProcent.toDouble()],
                          rangeSlider: true,
                          rightHandler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                            ),
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
                          handler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                            ),
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
                            double value_ = upperValue;
                            setState(() {
                              minProcent = value.round();
                              maxProcent = value_.round();
                            });
                            widget.onProcentDrag(minProcent, maxProcent);
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
                            Text("${NumberFormat("##0,000", "kk").format(minSumm)}-${NumberFormat("##0,000", "kk").format(maxSumm)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}" , style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                          ],
                        ),
                        FlutterSlider(
                          values: [minSumm.toDouble(), maxSumm.toDouble()],
                          rangeSlider: true,
                          rightHandler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                            ),
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
                          handler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                            ),
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
                            double value_ = upperValue;
                            setState(() {
                              minSumm = value.round();
                              maxSumm = value_.round();
                            });
                            widget.onSummDrag(minSumm,maxSumm);
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
                            Text("$minDays-$maxDays д.", style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                          ],
                        ),
                        FlutterSlider(
                          values: [minDays.toDouble(),maxDays.toDouble()],
                          rangeSlider: true,
                          rightHandler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                            ),
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
                          handler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                            ),
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
                          trackBar: FlutterSliderTrackBar(
                            activeTrackBarDraggable: true,
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
                            double value_ = upperValue;
                            setState(() {
                              minDays = value.round();
                              maxDays = value_.round();
                            });
                            widget.onDayDrag(minDays, maxDays);

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
                GestureDetector(
                  onTap: (){
                    if(garant<2){
                      garant++;
                    }else if(garant==2){
                      garant=0;
                    }
                    widget.onGarant(garant);
                    setState(() {

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
                              Text("Гарант", style: TextStyle(fontSize: 17.sp)),
                              Text(garant==0?"Неважно":garant==1?"Есть":garant==2?"Нет":"", style: TextStyle(color: Globals.buttonColor, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}