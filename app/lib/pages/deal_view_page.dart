import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/DealEntity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DealViewPage extends StatefulWidget{
  DealEntity deal;

  DealViewPage({required this.deal, super.key});

  @override
  State<StatefulWidget> createState() => _DealViewPage();


}
class _DealViewPage extends State<DealViewPage>{
  bool sellerView = false;
  bool buyerView = false;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Globals.mainColor,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () async {
              await Clipboard.setData(ClipboardData(text: widget.deal.code)).then((value){
                Fluttertoast.showToast(
                    msg: "Код скопирован в буфер обмена",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              });
            }, icon: Icon(Icons.copy, color: Colors.white,))
          ],
          backgroundColor: Globals.mainColor,
          centerTitle: true,
          title: Text("Сделка", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.sp),
            child: Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${widget.deal.type}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Название", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Text("${widget.deal.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Срок", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Text("${widget.deal.duration} дней", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Сумма", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Text("${NumberFormat("##0,000", "kk").format(widget.deal.price)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Код", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Text("${widget.deal.code}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Дата создания", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Text("${DateFormat("dd.MM.y HH:mm").format(widget.deal.startDate)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Globals.buttonColor),),
                              ],
                            ),
                            widget.deal.endDate!=null?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Дата завершения", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Text("${DateFormat("dd.MM.y HH:mm").format(widget.deal.endDate!)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Globals.buttonColor),),
                              ],
                            ):SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Color(0xff383F49)
                      ),
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.all(18.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Описание", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              ],
                            ),
                            Text(widget.deal.description, style: TextStyle(color: Globals.buttonColor),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    widget.deal.seller!=null?Container(
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
                                  sellerView = !sellerView;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Продавец", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Icon(sellerView?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 24.sp,)
                                ],
                              ),
                            ),
                            sellerView?Column(
                              children: [
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Имя", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.seller!.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Фамилия", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.seller!.surname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Отчество", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.seller!.patronymic, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Телефон", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text("+${widget.deal.seller!.phone}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Дата рождения", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(DateFormat("dd.MM.y").format(widget.deal.seller!.userDate), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("ИИН", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.seller!.identityCard, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                              ],
                            ):SizedBox.shrink()
                          ],
                        ),
                      ),
                    ):SizedBox.shrink(),
                    widget.deal.seller!=null?SizedBox(height: 16.sp,):SizedBox.shrink(),
                    widget.deal.buyer!=null?Container(
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
                                  buyerView = !buyerView;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Покупатель", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Icon(buyerView?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 24.sp,)
                                ],
                              ),
                            ),
                            buyerView?Column(
                              children: [
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Имя", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.buyer!.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Фамилия", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.buyer!.surname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Отчество", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.buyer!.patronymic, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Телефон", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text("+${widget.deal.buyer!.phone}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Дата рождения", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(DateFormat("dd.MM.y").format(widget.deal.buyer!.userDate), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                                SizedBox(height: 8.sp,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("ИИН", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                    Text(widget.deal.buyer!.identityCard, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                                  ],
                                ),
                              ],
                            ):SizedBox.shrink()
                          ],
                        ),
                      ),
                    ):SizedBox.shrink(),
                    widget.deal.buyer!=null?SizedBox(height: 16.sp,):SizedBox.shrink(),
                    widget.deal.seller!=null && widget.deal.buyer!=null && widget.deal.endDate==null?SizedBox(
                      width: double.maxFinite,
                      height: 34.sp,
                      child: ElevatedButton(
                        onPressed: () {
                          Dio dio = Dio();
                          RestClient client = RestClient(dio);
                          client.endDeal(Globals.getToken(), widget.deal.id).then((value){
                            Navigator.of(context).pop();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Globals.buttonColor,
                            surfaceTintColor: Colors.white,
                            shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.sp),
                        )),
                        child: Text("Завершить сделку", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

}