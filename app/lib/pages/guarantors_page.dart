import 'package:app/Globals.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/GuarantEntity.dart';
import 'package:app/api/entity/MessageEntityGuarantorList.dart';
import 'package:app/pages/guarantor_add_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GuarantorsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GuarantorsPage();

}
class _GuarantorsPage extends State<GuarantorsPage>{
  GuarantEntity? guarantor;
  GuarantEntity? currentGuarant;
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getGuarantors(), builder: (context,snapshot){
      if(snapshot.hasData){
        if(snapshot.data!.json.isEmpty && guarantor==null){
          return NotificationListener<NotifyAddGuarantor>(
            onNotification: (m){
              setState(() {
                guarantor = m.guarant;
                selectIndex = 0;
              });
              return true;
            },
              child: GuarantorAddPage(edit: false,)
          );
        }
        return Scaffold(
          backgroundColor: Globals.mainColor,
          appBar: AppBar(
            backgroundColor: Globals.mainColor,
            centerTitle: true,
            title: Text("Гарантное лицо", style: TextStyle(fontWeight: FontWeight.bold),),
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
                          guarantor!=null?guarant(guarantor!,0):SizedBox.shrink(),
                          guarantor!=null?SizedBox(height: 18.sp,):SizedBox.shrink(),
                          ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.json.length,
                              itemBuilder: (context, index){
                                return Column(
                                  children: [
                                    GestureDetector(onTap: (){

                                    },child: guarant(snapshot.data!.json[index], index+1),),
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
                      MaterialPageRoute(builder: (context) => GuarantorAddPage(edit: true,)),
                    ).then((value){
                      setState(() {
                        guarantor = value;
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
                    Navigator.pop(context, currentGuarant);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Globals.buttonColor,
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.sp),
                  )),
                  child: Text("Выбрать", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
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
            title: Text("Гарантное лицо", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Center(child: Text("Загрузка..."),),
        );
      }
    });
  }
  Widget guarant(GuarantEntity guarant, int index){
    if(index==selectIndex){
      currentGuarant = guarant;
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
              Text("${guarant.surname} ${guarant.name} ${guarant.patronymic}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
              SizedBox(height: 12.sp,),
              Text("+${guarant.phone}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
            ],
          ),
        ),
      ),
    );
  }
Future<MessageEntityGuarantorList> getGuarantors(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.findAllGuarantor(Globals.getToken());
}
}