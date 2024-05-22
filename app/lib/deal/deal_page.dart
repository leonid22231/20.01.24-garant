import 'package:app/Globals.dart';
import 'package:app/api/entity/DialEntity.dart';
import 'package:app/deal/deal_create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DealPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DealPage();

}
class _DealPage extends State<DealPage>{
  List<String> dealType = [
    "Товар",
    "Услуга"
  ];
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  String? selectedDealType;
  String? name,description,duration;
  XFile? file;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        backgroundColor: Globals.mainColor,
        centerTitle: true,
        title: Text("Создание сделки"),
      ),
      body: Builder(
        builder: (context){
          final height = MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight! - 30.sp;
          return Padding(
            padding: EdgeInsets.all(20.sp),
            child: SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff383F49),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: DropdownButton(
                            onChanged: (_){
                              setState(() {
                                selectedDealType = _!;
                              });
                            },
                            hint: Text("Тип сделки"),
                            value: selectedDealType==null?null:selectedDealType,
                            underline: Container(
                              height: 0,
                              color: Globals.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            isExpanded: true,
                            items: dealType.map((e){
                              return DropdownMenuItem(child: Text(e, style: TextStyle(color: Colors.black),), value: e,);
                            }).toList()),
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    TextFormField(
                      controller: controller,
                      onChanged: (value){
                        name = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Globals.backgroundInputColor,
                        contentPadding: EdgeInsets.all(20.sp),
                        hintText: "Название товара",
                        hintStyle: TextStyle(color: Globals.textInputColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                            borderSide: BorderSide.none
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    SizedBox(
                      height: 25.h,
                      width: double.maxFinite,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        maxLines:null,
                        minLines: null,
                        controller: controller1,
                        onChanged: (value){
                          description = value;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Globals.backgroundInputColor,
                          contentPadding: EdgeInsets.all(20.sp),
                          hintText: "Описание товара",
                          hintStyle: TextStyle(color: Globals.textInputColor),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    GestureDetector(
                      onTap: () async {
                        file = await _picker.pickImage(source: ImageSource.gallery);
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 35.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.sp),
                            color: Color(0xff383F49)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Прикрепить файл", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              SizedBox(width: 15.sp,),
                              Icon(Icons.file_copy_outlined, color: Colors.white, size: 18  .sp,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly

                      ],
                      controller: controller2,
                      onChanged: (value){
                        duration = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Globals.backgroundInputColor,
                        contentPadding: EdgeInsets.all(20.sp),
                        hintText: "Срок(в днях)",
                        hintStyle: TextStyle(color: Globals.textInputColor),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                            borderSide: BorderSide.none
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: double.maxFinite,
                      height: 34.sp,
                      child: ElevatedButton(
                        onPressed: () {
                          DialEntity dial = DialEntity(name: name!, description: description!, duration: int.parse(duration!), type: selectedDealType!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DealCreatePage(dial: dial)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Globals.buttonColor,
                            surfaceTintColor: Colors.white,
                            shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.sp),
                        )),
                        child: Text("Далее",),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}