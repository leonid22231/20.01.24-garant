import 'package:app/Globals.dart';
import 'package:app/api/entity/CreditEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreditStatusPage extends StatefulWidget{
  CreditEntity credit;
  CreditStatusPage({required this.credit, super.key});

  @override
  State<StatefulWidget> createState() => _CreditStatusPage();
}
class _CreditStatusPage extends State<CreditStatusPage>{
  bool garantView = false;
  bool leaanderView = false;
  @override
  Widget build(BuildContext context) {
    CreditEntity credit = widget.credit;
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        actions: [
          widget.credit.doc!=null?IconButton(onPressed: (){
            download();
          }, icon: Icon(Icons.sim_card_download, color: Colors.white,)):SizedBox.shrink()
        ],
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
                          Text("Реквизиты", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Название банка", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${credit.requisites.bankName}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("БИК Банка", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${credit.requisites.bikNumber}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Номер карты", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                              Text("${credit.requisites.cardNumber}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),),
                            ],
                          )
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ИИН", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.guarant!.identityCard, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                                ],
                              ),
                            ],
                          ):SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ):SizedBox.shrink(),
                  credit.lender!=null?SizedBox(height: 18.sp,):SizedBox.shrink(),
                  credit.lender!=null?Container(
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
                                leaanderView = !leaanderView;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Займодатель", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                Icon(leaanderView?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 24.sp,)
                              ],
                            ),
                          ),
                          leaanderView?Column(
                            children: [
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Имя", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.lender!.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Фамилия", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.lender!.surname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Отчество", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.lender!.patronymic, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Телефон", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text("+${credit.lender!.phone}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("E-Mail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.lender!.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                                ],
                              ),
                              SizedBox(height: 8.sp,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ИИН", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                                  Text(credit.lender!.identityCard, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Globals.buttonColor),)
                                ],
                              ),
                            ],
                          ):SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ):SizedBox.shrink(),
                  // SizedBox(height: 14.sp,),
                  // SizedBox(
                  //   width: double.maxFinite,
                  //   height: 34.sp,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Dio dio = Dio();
                  //       RestClient client = RestClient(dio);
                  //       client.creditConfirm(Globals.getToken()).then((value){
                  //
                  //       });
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Globals.buttonColor,
                  //         surfaceTintColor: Colors.white,
                  //         shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(40.sp),
                  //     )),
                  //     child: Text("Дать взаймы", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  download() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      requestPermission(Permission.manageExternalStorage);
      requestPermission(Permission.storage);
    }
    //
    FileDownloader.downloadFile(
      headers: {"Authorization":Globals.getToken()},
      downloadDestination: DownloadDestinations.publicDownloads,
        url: "http://89.23.117.164:8080/api/v1/user/credit/"+widget.credit.id+"/file",
      name: "doc${DateFormat("dd MM y mm:SS").format(DateTime.now())}.docx",
      onDownloadCompleted: (str){
        Fluttertoast.showToast(
            msg: "Файл сохранен в папке "+str.split("/")[str.split("/").length-2],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    );
  }
  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}