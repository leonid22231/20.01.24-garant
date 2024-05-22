import 'package:app/Globals.dart';
import 'package:app/api/entity/RequisitesEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BankAddPage extends StatefulWidget{
  bool edit;
  BankAddPage({required this.edit, super.key});

  @override
  State<StatefulWidget> createState() => _BankAddPage();

}
class _BankAddPage extends State<BankAddPage>{
  String? bankName;
  String? bikBank;
  String? numberCard;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        centerTitle: true,
        title: Text("Добавить реквизиты", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.sp),
        child: Container(
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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color(0xff383F49)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(18.sp),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value){
                              bankName = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Название банка",
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold)
                            ),
                          ),
                          TextFormField(
                            onChanged: (value){
                              bikBank = value;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly

                            ],
                            decoration: InputDecoration(
                                hintText: "БИК банка",
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold)
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly

                            ],
                            onChanged: (value){
                              numberCard = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Номер карты",
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold)
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.maxFinite,
                height: 34.sp,
                child: ElevatedButton(
                  onPressed: () {
                    RequisitesEntity req = RequisitesEntity(bankName: bankName!, cardNumber: numberCard!, bikNumber: bikBank!);
                    if(widget.edit){
                      Navigator.pop(context, req);
                    }else{
                      NotifyCreateBank(req).dispatch(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Globals.buttonColor,
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.sp),
                  )),
                  child: Text("Добавить", style: TextStyle(color: Globals.mainColor, fontSize: 18.sp),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
class NotifyCreateBank extends Notification{
  RequisitesEntity req;
  NotifyCreateBank(this.req);
}