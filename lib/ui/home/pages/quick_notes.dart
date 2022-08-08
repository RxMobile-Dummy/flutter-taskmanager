import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/update_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_state.dart';

import '../../../core/base/base_bloc.dart';
import '../../../custom/progress_bar.dart';
import '../../../utils/border.dart';
import '../../../utils/colors.dart';
import '../../../utils/device_file.dart';
import '../../../utils/style.dart';

import '../../../widget/button.dart';
import '../../../widget/textfield.dart';
import '../fab_menu_option/add_note/presentation/pages/add_note.dart';

class QuickNotes extends StatefulWidget {
  @override
  _QuickNotesState createState() => _QuickNotesState();
}

class _QuickNotesState extends State<QuickNotes> {
  Random random = new Random(255);
  GetNoteModel getNoteModel = GetNoteModel();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('access');
      print(id);
      await _getNote();
    });

  }

  Future<String> _getNote() {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
  return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context).add(
          GetNoteEvent());
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.10),
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Quick Notes",
          style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocListener<AddNoteBloc, BaseState>(
        listener: (context, state) {
          print("________ $state");
          if (state is StateOnSuccess) {
            ProgressDialog.hideLoadingDialog(context);
          }else if (state is GetNoteState) {
            ProgressDialog.hideLoadingDialog(context);
            getNoteModel = state.model!;
            if(getNoteModel.success == true){
              Fluttertoast.showToast(
                  msg: getNoteModel.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }else{
              Fluttertoast.showToast(
                  msg: getNoteModel.error ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
            print(getNoteModel.message??"");
          }else if (state is UpdateNoteState) {
            ProgressDialog.hideLoadingDialog(context);
             UpdateNoteModel? model = state.model;
            print(model!.message??"");
            if(getNoteModel.success == true){
              Fluttertoast.showToast(
                  msg: model.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
              Navigator.of(context).pop();
              _getNote();
            }else{
              Fluttertoast.showToast(
                  msg: model.error ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
          }else if (state is DeleteNoteState) {
            ProgressDialog.hideLoadingDialog(context);
            DeleteNoteModel? model = state.model;
            print(model!.message??"");
            if(getNoteModel.success == true){
              Fluttertoast.showToast(
                  msg: model.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
              _getNote();
            }else{
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
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                fontSize: DeviceUtil.isTablet ? 20 : 12,
                backgroundColor: CustomColors.colorBlue,
                textColor: Colors.white
            );
          }
        },
        child:  BlocBuilder<AddNoteBloc, BaseState>(builder: (context, state) {
          print(state);
          return (getNoteModel.data != null && getNoteModel.data!.isNotEmpty)
              ? buildWidget()  : (getNoteModel.data == null)? SizedBox():   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No Note",
                  style: CustomTextStyle.styleSemiBold
                      .copyWith(color: CustomColors.colorBlue,
                      fontSize: DeviceUtil.isTablet ? 18 : 14),
                ),
                const SizedBox(height: 10,),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: CustomColors.colorBlue,
                    onSurface: Colors.grey,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNote()),
                    );
                  }, child:  Text(
                  "Add Note",
                  style: CustomTextStyle.styleSemiBold
                      .copyWith(color: Colors.white,
                      fontSize: DeviceUtil.isTablet ? 18 : 14),
                ),)
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildWidget(){
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          return notesItem(index);
        },
        itemCount: getNoteModel.data!.length,
      ),
    );
  }

  Widget notesItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.01), offset: Offset(0, 100))],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16),
            height: 3,
            decoration: BoxDecoration(
                color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
                    random.nextInt(255), 1),
                borderRadius: BorderRadius.circular(4)),
            width: MediaQuery.of(context).size.width / 2.5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Text(
                  getNoteModel.data![index].title ?? "",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.styleMedium.copyWith(
                      fontSize: DeviceUtil.isTablet ? 16 : 15),
                ),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Text(
                  getNoteModel.data![index].description ?? "",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.styleMedium.copyWith(fontSize: DeviceUtil.isTablet ? 16 : 15),
                ),
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 IconButton(
                   icon: Icon(Icons.edit,color: CustomColors.colorBlue,
                   size: DeviceUtil.isTablet ? 24 : 20,),
                   onPressed: (){
                     titleController.text = getNoteModel.data![index].title ?? "";
                     descriptionController.text = getNoteModel.data![index].description ?? "abc";
                     showModalBottomSheet(
                         context: context,
                         isScrollControlled: true,
                         builder: (context) => Theme(
                             data: ThemeData(
                                 bottomSheetTheme: const BottomSheetThemeData(
                                     backgroundColor: Colors.black,
                                     modalBackgroundColor: Colors.grey)),
                             child: Padding(
                               padding: MediaQuery.of(context).viewInsets,
                               child: editNote(
                                 index,
                                 titleController,
                                 descriptionController,
                               ),
                             )));
                   },
                 ),
                 IconButton(
                   icon: Icon(Icons.delete,color: CustomColors.colorBlue,
                   size: DeviceUtil.isTablet ? 24 : 20,),
                   onPressed: (){
                     showDialog(
                       context: context,
                       builder: (ctx) => AlertDialog(
                         title:  Text(
                           "Delete Note",
                           style: TextStyle(fontSize:  DeviceUtil.isTablet ? 18 : 14),
                         ),
                         titlePadding: EdgeInsets.all(10),
                         contentPadding: EdgeInsets.all(10),
                         content:  Container(
                           child: Text(
                             "Are you sure you want to delete?",
                             softWrap: true,
                             overflow: TextOverflow.fade,
                             style:  CustomTextStyle.styleMedium.copyWith(
                                 fontSize: DeviceUtil.isTablet ? 18 : 14
                             ),
                           ),
                         ),
                         actions: <Widget>[
                           TextButton(
                             onPressed: () {
                               _deleteNote(
                                 id: getNoteModel.data![index].id,
                               );
                               Navigator.of(ctx).pop();
                             },
                             child: Text(
                               "Okay",
                               style: CustomTextStyle.styleSemiBold
                                   .copyWith(color: CustomColors.colorBlue, fontSize:
                               DeviceUtil.isTablet ? 18 : 16),),
                           ),
                         ],
                       ),
                     );
                 /*    showDialog(
                       context: context,
                       builder: (ctx) => AlertDialog(
                         title: const Text("Delete Task"),
                         content: const Text("Are you sure you want to delete this note ?"),
                         actions: <Widget>[
                           TextButton(
                             onPressed: () {
                               _deleteNote(
                                 id: getNoteModel.data![index].id,
                               );
                               Navigator.of(ctx).pop();
                             },
                             child: Container(
                               //color: CustomColors.colorBlue,
                               padding: const EdgeInsets.all(14),
                               child:  Text(
                                 "Okay",
                                 style: CustomTextStyle.styleSemiBold
                                     .copyWith(color: CustomColors.colorBlue, fontSize: 18),),
                             ),
                           ),
                         ],
                       ),
                     );*/
                   },
                 )
               ],
             )
             /* Visibility(
                  visible: index % 2 == 1,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 24),
                          child: Text(
                            "Home work today",
                            style: CustomTextStyle.styleMedium,
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(left: 6),
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return noteSubItem();
                          },
                          itemCount: 3,
                        )
                      ],
                    ),
                  ))*/
            ],
          )
        ],
      ),
    );
  }
  Future<String> _updateNote({
    int? id,String? title,String? description,
  }) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context).add(
          UpdateNoteEvent(
            id: id ?? 0,
            description: description ?? "",
            title: title ?? ''
          ));
      return "";
    });
  }

  Future<String> _deleteNote({
    int? id,
  }) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context).add(
          DeleteNoteEvent(
              id: id ?? 0,
          ));
      return "";
    });
  }

  editNote(int index,TextEditingController title, TextEditingController description) {
    return Form(
      key: _formKey,
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              color: Colors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.only(left: 4, right: 16),
                    child: TextFormField(
                      style: CustomTextStyle.styleSemiBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                      controller: titleController,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value == "") {
                          return 'Please enter note title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: titleBorder(color: Colors.grey.shade200),
                         // hintText: "Title",
                          labelText: "Title",
                          labelStyle: CustomTextStyle.styleSemiBold
                              .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14),
                          hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          enabledBorder:
                          titleBorder(color: Colors.transparent),
                          focusedBorder:
                          titleBorder(color: Colors.transparent)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.only(left: 4, right: 16),
                    child: TextFormField(
                      style: CustomTextStyle.styleSemiBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                      controller: descriptionController,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value == "") {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: titleBorder(color: Colors.grey.shade200),
                          // hintText: "Title",
                          labelText: "Description",
                          labelStyle: CustomTextStyle.styleSemiBold
                              .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14),
                          hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          enabledBorder:
                          titleBorder(color: Colors.transparent),
                          focusedBorder:
                          titleBorder(color: Colors.transparent)),
                    ),
                  ),
                 /* CustomTextField(
                    //initialValue: title.text,
                    label: "Title",
                    minLines: 5,
                    textEditingController: title,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    //initialValue: description.text,
                    label: "Description",
                    minLines: 5,
                    textEditingController: description,
                  ),*/
                  Button(
                    "Done",
                    verticalMargin: 10,
                    horizontalMargin: 0,
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState?.save();
                        _updateNote(
                          title: title.text,
                          description: description.text,
                          id: getNoteModel.data![index].id,
                        );
                      }else{
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
            )
          ),
        ),
      ),
    );
  }
  noteSubItem() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (checked) {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text("Buy a milk")
        ],
      ),
    );
  }
}
