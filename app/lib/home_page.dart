import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/api/entity/MessageEntity.dart';
import 'package:app/api/entity/MessageEntityCreditList.dart';
import 'package:app/appbarbloc/appbar_bloc.dart';
import 'package:app/appbarbloc/appbar_state_enum.dart';
import 'package:app/deal/deal_join_page.dart';
import 'package:app/deal/deal_page.dart';
import 'package:app/loginbloc/login_bloc.dart';
import 'package:app/pages/credit_list_page.dart';
import 'package:app/pages/credit_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Globals.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _HomePage();
}
class _HomePage extends State<HomePage>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appbarbloc = BlocProvider.of<AppBarBloc>(context);
    appbarbloc.add(
      AppBarChangeState(AppBarStateEnum.HOME)
    );
     return FutureBuilder(future: getToken(), builder: (context, snapshot){
       if(snapshot.hasData){
            if(snapshot.data!.statusCode==100){
              Globals.token = snapshot.data!.message!;
              return FutureBuilder(future: getShared(), builder: (context,snapshot){
                if(snapshot.hasData){
                  snapshot.data!.setString("token", Globals.token);
                }
                return homePage();
              });
            }else{
              return FutureBuilder(future: getShared(), builder: (context, snapshot){
                if(snapshot.hasData){
                  snapshot.data!.remove("token");
                  Globals.token = "";
                  final loginBloc = BlocProvider.of<LoginBloc>(context);
                  loginBloc.add(
                    LoginChangeState(false)
                  );
                }
                return SizedBox();
              });
            }
       }else{
         return SizedBox();
       }
     });
  }
  Future<SharedPreferences> getShared(){
    return SharedPreferences.getInstance();
  }
  Future<MessageEntity> getToken(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.sendNewToken(Globals.getToken());
  }
  Widget homePage(){
    return Padding(
        padding: EdgeInsets.all(18.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 34.sp,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreditPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Globals.buttonColor,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.sp),
              )),
              child: Text("Взять займ", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
            ),
          ),
          SizedBox(height: 19.sp,),
          SizedBox(
            width: double.maxFinite,
            height: 34.sp,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreditListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.sp),
                  side: BorderSide(color: Globals.buttonColor)
              )),
              child: Text("Стать заемщиком", style: TextStyle(color: Globals.buttonColor , fontSize: 18.sp),),
            ),
          ),
          SizedBox(height: 19.sp,),
          SizedBox(
            width: double.maxFinite,
            height: 34.sp,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DealPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.sp),
                  side: BorderSide(color: Globals.buttonColor)
              )),
              child: Text("Создать сделку", style: TextStyle(color: Globals.buttonColor , fontSize: 18.sp),),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("или"),
                TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DealJoinPage()),
                  );
                }, child: Text("вступить в существующую"))
              ],
            ),
          )
          // BlocBuilder<UpdateBloc, UpdateState>(builder: (context, state){
          //     if(state is UpdateStateLoaded){
          //       return FutureBuilder(future: getActive(), builder: (context, snapshot){
          //         if(snapshot.hasData){
          //           if(snapshot.data!.json.isNotEmpty){
          //             List<CreditEntity> list = snapshot.data!.json;
          //             return ConstrainedBox(
          //               constraints: BoxConstraints.loose(Size(100.w, 22.h)),
          //               child: Swiper(
          //                 layout: SwiperLayout.STACK,
          //                 itemWidth: 90.w,
          //                 itemHeight: 22.h,
          //                 onTap: (index){
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(builder: (context) => CreditStatusPage(credit: list[index])),
          //                   );
          //                 },
          //                 itemBuilder: (BuildContext context,int index){
          //                   return Container(
          //                     decoration: BoxDecoration(
          //                         color: Color(0xff2D333C).withOpacity((1/10)*(10-index)),
          //                         borderRadius: BorderRadius.circular(40)
          //                     ),
          //                     child: Padding(
          //                       padding: EdgeInsets.all(15.sp),
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                             color: Color(0xff383F49),
          //                             borderRadius: BorderRadius.circular(36)
          //                         ),
          //                         child: Padding(
          //                           padding: EdgeInsets.all(16.sp),
          //                           child: Column(
          //                             crossAxisAlignment: CrossAxisAlignment.start,
          //                             children: [
          //                               Text(getStatus(list[index], snapshot.data!.message), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
          //                               Row(
          //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text("Сумма с процентами", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
          //                                   Text("${NumberFormat("##0,000", "kk").format(list[index].value+(list[index].value/100)*list[index].percent)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
          //                                 ],
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text("Срок", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
          //                                   Text("${list[index].duration} дней", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
          //                                 ],
          //                               ),
          //                               getMode(list[index], snapshot.data!.message)?Row(
          //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text("Статус", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
          //                                   Text("${list[index].lastStatus}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
          //                                 ],
          //                               ):Row(
          //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Column(
          //                                     children: [
          //                                       Text("Дата начала"),
          //                                       Text(DateFormat("dd.MM.y").format(list[index].startDate!))
          //                                     ],
          //                                   ),
          //                                   Column(
          //                                     children: [
          //                                       Text("Дата окончания"),
          //                                       Text(DateFormat("dd.MM.y").format(list[index].startDate!.add(Duration(days: list[index].duration))))
          //                                     ],
          //                                   )
          //                                 ],
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   );
          //                 },
          //                 itemCount: list.length,
          //                 pagination: SwiperPagination(),
          //               ),
          //             );
          //           }else{
          //             return SizedBox.shrink();
          //           }
          //         }else{
          //           return SizedBox.shrink();
          //         }
          //       });
          //     }else{
          //       return SizedBox.shrink();
          //     }
          // }),
        ],
      ),
    );
  }
  String getStatus(CreditEntity credit,String id){
      if(credit.borrower!=null && credit.borrower!.id==id){
        return "Займ";
      }
      if(credit.lender!=null && credit.lender!.id==id){
        return "Вы заняли";
      }
      return "Error";
  }
  bool getMode(CreditEntity credit, String id){
      if(credit.borrower!=null && credit.borrower!.id==id){
        return true;
      }
      if(credit.lender!=null && credit.lender!.id==id){
        return false;
      }
      return false;
  }
}