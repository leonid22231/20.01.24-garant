import 'package:app/Globals.dart';
import 'package:app/api/entity/GuarantEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GuarantorAddPage extends StatefulWidget{
  bool edit;
  GuarantorAddPage({required this.edit, super.key});
  @override
  State<StatefulWidget> createState() => _GuarantorAddPage();

}
class _GuarantorAddPage extends State<GuarantorAddPage>{
  String? phome,name,surname,patronic,iin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        centerTitle: true,
        title: Text("Гарантное лицо", style: TextStyle(fontWeight: FontWeight.bold),),
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value){
                              phome = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Номер телефона",
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold)
                            ),
                          ),
                          TextFormField(
                            onChanged: (value){
                              name = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Имя",
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold)
                            ),
                          ),
                          TextFormField(
                            onChanged: (value){
                              surname = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Фамилия",
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4),fontWeight: FontWeight.bold)
                            ),
                          ),
                          TextFormField(
                            onChanged: (value){
                              patronic = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Отчество",
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
                              iin = value;
                            },
                            decoration: InputDecoration(
                                hintText: "ИИН",
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
                    GuarantEntity guarantor = GuarantEntity(id: "", name:name!, surname: surname!, patronymic: patronic!, identityCard: iin!, phone: phome!);
                    if(widget.edit){
                      Navigator.pop(context, guarantor);
                    }else{
                      NotifyAddGuarantor(guarantor).dispatch(context);
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
class NotifyAddGuarantor extends Notification{
  GuarantEntity guarant;
  NotifyAddGuarantor(this.guarant);
}