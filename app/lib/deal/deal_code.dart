import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Globals.dart';

class DealCode extends StatefulWidget{
  String code;

  DealCode(this.code);

  @override
  State<StatefulWidget> createState() => _DealCode();

}
class _DealCode extends State<DealCode>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Globals.mainColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 50.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Сделки создано!", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            SizedBox(height: 16.sp,),
            Flexible(child: Text("Сделка успешно создано, можете скопировать ссылку и отправить кому вы хотите пригласить на эту сделку.", textAlign: TextAlign.center,)),
            SizedBox(height: 18.sp,),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xff383F49)
              ),
              child: Padding(
                padding: EdgeInsets.all(22.sp),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(widget.code, textAlign: TextAlign.center,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: widget.code)).then((value){
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
                      }, icon: Icon(Icons.copy, color: Colors.white,)),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.maxFinite,
              height: 34.sp,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Globals.buttonColor,
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.sp),
                )),
                child: Text("Выход",),
              ),
            ),
          ],
        ),
      ),
     );
  }

}
