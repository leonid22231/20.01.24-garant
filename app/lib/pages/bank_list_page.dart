import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/api/entity/GuarantEntity.dart';
import 'package:app/api/entity/MessageEntityRequisites.dart';
import 'package:app/api/entity/ParametersEntity.dart';
import 'package:app/api/entity/RequisitesEntity.dart';
import 'package:app/pages/bank_add_page.dart';
import 'package:app/pages/credit_confirm_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BankListPage extends StatefulWidget{
  CreditEntity creditEntity;
  GuarantEntity? guarant;
  BankListPage({required this.creditEntity, this.guarant,super.key});

  @override
  State<StatefulWidget> createState() => _BankListPage();

}
class _BankListPage extends State<BankListPage>{
  RequisitesEntity? requisites;
  RequisitesEntity? currentRequisites;
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getBanks(), builder: (context, snapshot){
      if(snapshot.hasData){
        if(snapshot.data!.json.isEmpty && requisites==null){
            return NotificationListener<NotifyCreateBank>(
              onNotification: (m){
                setState(() {
                  requisites = m.req;
                  selectIndex = 0;
                });
                return true;
              },
                child: BankAddPage(edit: false,)
            );
        }
        return Scaffold(
          backgroundColor: Globals.mainColor,
          appBar: AppBar(
            backgroundColor: Globals.mainColor,
            centerTitle: true,
            title: Text("Оформить займ", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
          body: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column( children: [Container(
              decoration: BoxDecoration(
                  color: Color(0xff2D333C),
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: Container(
                    height: 60.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          requisites!=null?bank(requisites!,0):SizedBox.shrink(),
                          requisites!=null?SizedBox(height: 18.sp,):SizedBox.shrink(),
                          ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.json.length,
                              itemBuilder: (context, index){
                                return Column(
                                  children: [
                                    GestureDetector(onTap: (){

                                    },child: bank(snapshot.data!.json[index], index+1),),
                                    SizedBox(height: 18.sp,)
                                  ],
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
              Spacer(),
              SizedBox(
                width: double.maxFinite,
                height: 34.sp,
                child: ElevatedButton(
                  onPressed: ()  async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BankAddPage(edit: true,)),
                    ).then((value){
                      setState(() {
                        requisites = value;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                    side: BorderSide(color: Globals.buttonColor),
                    borderRadius: BorderRadius.circular(40.sp),
                  )),
                  child: Text("Добавить новое", style: TextStyle(color: Globals.buttonColor, fontSize: 18.sp),),
                ),
              ),
              SizedBox(height: 18.sp,),
              SizedBox(
                width: double.maxFinite,
                height: 34.sp,
                child: ElevatedButton(
                  onPressed: () {
                      Dio dio = Dio();
                      RestClient client = RestClient(dio);
                      ParametersEntity param = ParametersEntity(requisites: currentRequisites!, guarantor: widget.guarant);
                      client.creditConfirm(Globals.getToken()).then((value){
                        if(value.statusCode==100){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreditConfirm(credit: widget.creditEntity, parameters: param)),
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
                  child: Text("Подтвердить", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
                ),
              ),
            ]),
          ),
        );
      }else{
        return Scaffold(
          backgroundColor: Globals.mainColor,
          appBar: AppBar(
            backgroundColor: Globals.mainColor,
            centerTitle: true,
            title: Text("Оформить займ", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Center(child: Text("Загрузка..."),),
        );
      }
    });
  }
  Widget bank(RequisitesEntity req, int index){
    if(index==selectIndex){
      currentRequisites = req;
    }
    return GestureDetector(
      onTap: (){
        setState(() {
          selectIndex = index;
        });
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Color(0xff383F49),
          border: selectIndex==index?Border.all(color: Globals.buttonColor):null
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(req.bankName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
              SizedBox(height: 12.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("БИК банка", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  Text("${req.bikNumber}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Color(0xffB9BBBD)),),
                ],
              ),
              SizedBox(height: 12.sp,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Номер карты", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  Text("${req.cardNumber}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Color(0xffB9BBBD)),),
                ],
              ),
              SizedBox(height: 12.sp,),
            ],
          ),
        ),
      ),
    );
  }
Future<MessageEntityRequisites> getBanks(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.getBanks(Globals.getToken());
}
}