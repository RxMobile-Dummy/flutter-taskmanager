import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_state.dart';
import 'package:task_management/utils/color_extension.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/device_file.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/decoration.dart';
import '../../../../../../widget/rounded_corner_page.dart';
import '../../../../../../widget/textfield.dart';


class AddCheckList extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddCheckList> {
  List<Color> listColors = [
    CustomColors.colorPurple,
    CustomColors.colorBlue,
    CustomColors.colorRed,
    Colors.green,
    Colors.cyan
  ];
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

   Color? selectedColors;
  var hexColor;

  var isCheckBoxSelected = false;
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];
  List<String> options = [];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _addTile() {
    return ListTile(
      trailing:  TextButton(
        child: Text("Add check box name",
          style: CustomTextStyle.styleSemiBold
              .copyWith(color: CustomColors.colorBlue, fontSize:
          DeviceUtil.isTablet ? 18 : 16),),
        onPressed: (){
          final controller = TextEditingController();
          final field = TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
              ),
              hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                  fontSize: DeviceUtil.isTablet ? 16 : 14
              ),
              labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                  fontSize: DeviceUtil.isTablet ? 16 : 14
              ),
              labelText: "Check Box Name ${_controllers.length + 1}",
            ),
          );
          setState(() {
            _controllers.add(controller);
            _fields.add(field);
          });
        },
      ),
   /*   onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "name${_controllers.length + 1}",
          ),
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },*/
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: _fields[index],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close,color: CustomColors.colorRed,
                  size: DeviceUtil.isTablet ? 24 : 20,),
                onPressed: (){
                 setState(() {
                   _fields.removeAt(index);
                 });
                },
              )
            ],
        );
      },
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        final alert = AlertDialog(
          title: Text("Count: ${_controllers.length}"),
          content: Text(text.trim()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) => alert,
        );
        setState(() {});
      },
      child: Text("OK"),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddCheckListBloc, BaseState>(
        listener: (context, state) {
          if (state is StateOnSuccess) {
            ProgressDialog.hideLoadingDialog(context);
          }else if (state is AddCheckListState) {
            ProgressDialog.hideLoadingDialog(context);
            AddCheckListModel? model = state.model;
            if(model!.success == true){
              Fluttertoast.cancel();
              Fluttertoast.showToast(
                  msg: model.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
              Navigator.of(context).pop();
              BlocProvider.of<AddCheckListBloc>(context).add(
                  GetCheckListEvent());
            }else {
              Fluttertoast.cancel();
              Fluttertoast.showToast(
                  msg: model.error ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
          }else if (state is StateErrorGeneral) {
            ProgressDialog.hideLoadingDialog(context);
            Fluttertoast.cancel();
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                fontSize: DeviceUtil.isTablet ? 20 : 12,
                backgroundColor: CustomColors.colorBlue,
                textColor: Colors.white
            );
            /*ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: Text(state.message),
              ));*/
          }
        },
        child:  BlocBuilder<AddCheckListBloc, BaseState>(builder: (context, state) {
          return Form(
            key: _formKey,
            child: buildWidget(),
          );
        }),
      ),
    );
  }

  Widget buildWidget(){
    return RoundedCornerPage(
      title: "Add Check List",
      showBackButton: true,
      isFirstPage: false,
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  label: "Title",
                  minLines: 2,
                  errorMessage: "Please Enter Title",
                  textEditingController: titleController,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _addTile(),
                    _listView(),
                    //_okButton(),
                  ],
                ),
                /* ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 8),
                    primary: false,
                    itemBuilder: (context, index) {
                      return checkListItem(index);
                    },
                    itemCount: 4,
                  ),*/
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 32),
                  child: Text(
                    "Choose Color",
                    style: CustomTextStyle.styleBold,
                  ),
                ),
                Container(
                  height: DeviceUtil.isTablet ? 56 : 46,
                  padding: const EdgeInsets.only(left: 16),
                  margin: const EdgeInsets.only(top: 24),
                  child: Scrollbar(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: listColors
                            .map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColors = e;
                              hexColor = e.toHex();
                              Color color = HexColor.fromHex(hexColor);
                              print(hexColor +" -- " + color.toString());
                            });
                          },
                          child: Container(
                            height: DeviceUtil.isTablet ? 56 : 46,
                            width: DeviceUtil.isTablet ? 56 : 46,
                            child: selectedColors != null &&
                                selectedColors == e
                                ? const Icon(Icons.check)
                                : Container(),
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                shape: BoxShape.rectangle,
                                color: e),
                          ),
                        ))
                            .toList(),
                      )),
                ),
                Button(
                  "Done",
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    for(int i=0;i< _controllers.length;i++){
                      options.add(_controllers[i].text);
                    }
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      if(hexColor == null || hexColor == ""){
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                            msg: "Please select color.",
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: DeviceUtil.isTablet ? 20 : 12,
                            backgroundColor: CustomColors.colorBlue,
                            textColor: Colors.white
                        );
                      }else if(_controllers.isEmpty){
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                            msg: "Please enter check box name.",
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: DeviceUtil.isTablet ? 20 : 12,
                            backgroundColor: CustomColors.colorBlue,
                            textColor: Colors.white
                        );
                      }else{
                        _addCheckList(
                          title: titleController.text,
                          options: options,
                          color: hexColor,
                        );
                      }
                    }else{
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          msg: "Please fill all the details.",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkListItem(index) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              value: isCheckBoxSelected,
              onChanged: (checked) {
                setState(() {
                  isCheckBoxSelected = checked!;
                });
              }),
          Text(
            "List Item ${index + 1}",
            style: CustomTextStyle.styleMedium,
          )
        ],
      ),
    );
  }

  Future<String> _addCheckList({
    String? title,
    List<String>? options,
    String? color,
  }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddCheckListBloc>(context).add(
          AddCheckListEvent(
            options: options ?? [],
            title: title ?? "",
            color: color ?? ""
          ));
      return "";
    });
  }
}
