import 'package:app/Globals.dart';
import 'package:app/api/entity/DealEntity.dart';
import 'package:app/api/entity/MessageEntityUserHistory.dart';
import 'package:app/pages/deal_view_page.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../api/RestClient.dart';
import '../api/entity/CreditEntity.dart';
import '../api/entity/MessageEntityCreditList.dart';
import '../updatebloc/update_bloc.dart';
import 'credit_status_page.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HistoryPage();

}
class _HistoryPage extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Globals.mainColor,
       appBar: AppBar(
         backgroundColor: Globals.mainColor,
         centerTitle: true,
         title: Text("История"),
       ),
       body: Padding(
         padding: EdgeInsets.all(18.sp),
         child:  BlocBuilder<UpdateBloc, UpdateState>(builder: (context, state){
             if(state is UpdateStateLoaded){
               return FutureBuilder(future: getActive(), builder: (context, snapshot){
                 if(snapshot.hasData){
                   if(snapshot.data!.json.credits.isNotEmpty || snapshot.data!.json.deals.isNotEmpty){
                     List<DealEntity> list2 = snapshot.data!.json.deals;
                     List<CreditEntity> list = snapshot.data!.json.credits;
                     print("List2 ${list2.length}");
                     return ListView.builder(
                       itemCount: list.length + list2.length,
                         itemBuilder: (context, index){
                         if(index<list.length){
                           return Column(
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => CreditStatusPage(credit: list[index])),
                                   );
                                 },
                                 child: Container(
                                   decoration: BoxDecoration(
                                       color: Color(0xff2D333C).withOpacity((1/10)*(10-index)),
                                       borderRadius: BorderRadius.circular(40)
                                   ),
                                   child: Padding(
                                     padding: EdgeInsets.all(15.sp),
                                     child: Container(
                                       decoration: BoxDecoration(
                                           color: Color(0xff383F49),
                                           borderRadius: BorderRadius.circular(36)
                                       ),
                                       child: Padding(
                                         padding: EdgeInsets.all(16.sp),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(getStatus(list[index], snapshot.data!.message), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Сумма с процентами", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                                 Text("${NumberFormat("##0,000", "kk").format(list[index].value+(list[index].value/100)*list[index].percent)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Срок", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                                 Text("${list[index].duration} дней", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                               ],
                                             ),
                                             getMode(list[index], snapshot.data!.message)?Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Статус", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                                 Text("${list[index].lastStatus}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                               ],
                                             ):Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Column(
                                                   children: [
                                                     Text("Дата начала"),
                                                     Text(DateFormat("dd.MM.y").format(list[index].startDate!))
                                                   ],
                                                 ),
                                                 Column(
                                                   children: [
                                                     Text("Дата окончания"),
                                                     Text(DateFormat("dd.MM.y").format(list[index].startDate!.add(Duration(days: list[index].duration))))
                                                   ],
                                                 )
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                               SizedBox(height: 16.sp,)
                             ],
                           );
                         }else{
                           return Column(
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => DealViewPage(deal: list2[index-list.length])),
                                   );
                                 },
                                 child: Container(
                                   decoration: BoxDecoration(
                                       color: Color(0xff2D333C).withOpacity((1/10)*(10-index)),
                                       borderRadius: BorderRadius.circular(40)
                                   ),
                                   child: Padding(
                                     padding: EdgeInsets.all(15.sp),
                                     child: Container(
                                       decoration: BoxDecoration(
                                           color: Color(0xff383F49),
                                           borderRadius: BorderRadius.circular(36)
                                       ),
                                       child: Padding(
                                         padding: EdgeInsets.all(16.sp),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text("Сделка", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text(list2[index-list.length].type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                                 Text(list2[index-list.length].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Цена", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                                 Text("${NumberFormat("##0,000", "kk").format(list2[index-list.length].price)} ${NumberFormat.simpleCurrency(locale: "kk").currencySymbol}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Срок", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                                 Text("${list2[index-list.length].duration} дней", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                               ],
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                               SizedBox(height: 16.sp,)
                             ],
                           );
                         }

                         }
                     );
                   }else{
                     return SizedBox.shrink();
                   }
                 }else{
                   print("Error ${snapshot.error}");
                   return SizedBox.shrink();
                 }
               });
             }else{
               return SizedBox.shrink();
             }
         }),
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
  Future<MessageEntityUserHistory> getActive(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.findAllActive(Globals.getToken());
  }
}