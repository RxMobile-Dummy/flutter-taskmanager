import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_state.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_state.dart';

import '../../../core/base/base_bloc.dart';
import '../../../core/error_bloc_listener/error_bloc_listener.dart';
import '../../../custom/progress_bar.dart';
import '../../../utils/border.dart';
import '../../../utils/color_extension.dart';
import '../../../utils/colors.dart';
import '../../../utils/device_file.dart';
import '../../../utils/style.dart';

import '../../../widget/button.dart';
import '../fab_menu_option/add_note/presentation/pages/add_note.dart';

class QuickNotes extends StatefulWidget {
  @override
  _QuickNotesState createState() => _QuickNotesState();
}

class _QuickNotesState extends State<QuickNotes> {
  Random random = new Random(255);
  GetNoteModel getNoteModel = GetNoteModel();
  GetCheckListModel getCheckListModel = GetCheckListModel();
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
      await _getCheckList();
    });

  }

  Future<String> _getNote() {
  return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context).add(
          GetNoteEvent());
      return "";
    });
  }

  Future<String> _getCheckList() {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<AddCheckListBloc>(context).add(
          GetCheckListEvent());
      return "";
    });
  }

  Future<String> _updateCheckList({int? id, String? is_completed}) {
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<AddCheckListBloc>(context).add(
          UpdateCheckListEvent(
              id: id ?? 0,
              is_completed: is_completed ?? "false",
          ));
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
      body: ErrorBlocListener<AddNoteBloc>(
        bloc: BlocProvider.of<AddNoteBloc>(context),
        child:  BlocBuilder<AddNoteBloc, BaseState>(builder: (context, state) {
          print(state);
          if(state is GetNoteState){
            ProgressDialog.hideLoadingDialog(context);
            getNoteModel = state.model!;
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
          }else if(state is UpdateNoteState){
            ProgressDialog.hideLoadingDialog(context);
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
            });
             _getNote();
          }else if(state is DeleteNoteState){
            ProgressDialog.hideLoadingDialog(context);
            _getNote();
          }
          return SizedBox();
        }),
      ),
    );
  }

  Widget buildWidget(){
    return Container(
      child: SingleChildScrollView(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return notesItem(index);
              },
              itemCount: getNoteModel.data!.length,
            ),
            BlocBuilder<AddCheckListBloc, BaseState>(
              builder: (context, state) {
                if (state is GetCheckListState) {
                  ProgressDialog.hideLoadingDialog(context);
                  getCheckListModel = state.model!;
                 return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Check List",
                          style: CustomTextStyle.styleBold
                              .copyWith(color: CustomColors.colorBlue,
                              fontSize: DeviceUtil.isTablet ? 20 : 16),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return checkListItem(index);
                        },
                        itemCount: getCheckListModel.data!.length,
                      ),
                    ],
                  );

                }else if (state is DeleteCheckListState) {
                  ProgressDialog.hideLoadingDialog(context);
                  _getCheckList();
                }else if (state is UpdateCheckListState) {
                  ProgressDialog.hideLoadingDialog(context);
                  _getCheckList();
                }else {
                  ProgressDialog.hideLoadingDialog(context);
                  return const SizedBox();
                }
                ProgressDialog.hideLoadingDialog(context);
                return const SizedBox();
              },
            ),
          ],
        ),
      )
    );
  }

  Widget notesItem(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.01), offset: Offset(0, 100))],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
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
                const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
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
                const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                         builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter mystate) =>  Theme(
                             data: ThemeData(
                                 bottomSheetTheme: const BottomSheetThemeData(
                                     backgroundColor: Colors.black,
                                     modalBackgroundColor: Colors.grey)),
                             child: Padding(
                               padding: MediaQuery.of(context).viewInsets,
                               child: editNote(
                                 descriptionController.text,
                                 mystate,
                                 index,
                                 titleController,
                                 descriptionController,
                               ),
                             )) ));
                   },
                 ),
                 IconButton(
                   icon: Icon(Icons.delete,color: CustomColors.colorBlue,
                   size: DeviceUtil.isTablet ? 24 : 20,),
                   onPressed: (){
                     showDialog(
                       context: context,
                       builder: (ctx) => Padding(
                       padding: EdgeInsets.symmetric(horizontal: 20),
                       child: AlertDialog(
                         title:  Text(
                           "Delete Note",
                           style: TextStyle(fontSize:  DeviceUtil.isTablet ? 18 : 14),
                         ),
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
                               "Yes",
                               style: CustomTextStyle.styleSemiBold
                                   .copyWith(color: CustomColors.colorBlue, fontSize:
                               DeviceUtil.isTablet ? 18 : 16),),
                           ),
                         ],
                       ),
                     ));
                   },
                 )
               ],
             )
            ],
          )
        ],
      ),
    );
  }
  Widget checkListItem(int i) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.01), offset: Offset(0, 100))],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            height: 3,
            decoration: BoxDecoration(
                color: HexColor.fromHex(getCheckListModel.data![i].color ?? ""),
                borderRadius: BorderRadius.circular(4)),
            width: MediaQuery.of(context).size.width / 2.5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Text(
                  getCheckListModel.data![i].title ?? "",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.styleMedium.copyWith(
                      fontSize: DeviceUtil.isTablet ? 16 : 15),
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.only(left: 6),
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return noteSubItem(index,i);
                },
                itemCount: getCheckListModel.data![i].optionsDetails!.length,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete,color: CustomColors.colorBlue,
                      size: DeviceUtil.isTablet ? 24 : 20,),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (ctx) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: AlertDialog(
                              title:  Text(
                                "Delete Check List",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize:  DeviceUtil.isTablet ? 18 : 14),
                              ),
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
                                    _deleteCheckList(
                                      id: getCheckListModel.data![i].id,
                                    );
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(
                                    "Yes",
                                    style: CustomTextStyle.styleSemiBold
                                        .copyWith(color: CustomColors.colorBlue, fontSize:
                                    DeviceUtil.isTablet ? 18 : 16),),
                                ),
                              ],
                            ),
                          ));
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  Future<String> _updateNote({
    int? id,String? title,String? description,
  }) {
    return Future.delayed(const Duration()).then((_) {
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
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context).add(
          DeleteNoteEvent(
              id: id ?? 0,
          ));
      return "";
    });
  }

  Future<String> _deleteCheckList({
    int? id,
  }) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddCheckListBloc>(context).add(
          DeleteCheckListEvent(
            id: id.toString(),
          ));
      return "";
    });
  }

  editNote( String enterDescriptionText,StateSetter myState,int index,TextEditingController title, TextEditingController description) {
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
                      maxLength: 300,
                      onChanged: (value){
                        myState(() {
                          enterDescriptionText = value;
                        });
                      },
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
                          labelText: "Description",
                          counterText: "${enterDescriptionText.length}/300",
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
            )
          ),
        ),
      ),
    );
  }
  noteSubItem(int i,int index) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: getCheckListModel.data![index].optionsDetails![i].is_completed ?? false,
            onChanged: (checked) async {
              await _updateCheckList(
                is_completed: checked.toString(),
                id: getCheckListModel.data![index].optionsDetails![i].id,
              );
            },
            activeColor: CustomColors.colorBlue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(
            getCheckListModel.data![index].optionsDetails![i].checklistDetail ?? "",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.styleMedium
                .copyWith(
                fontSize: DeviceUtil.isTablet ? 18 : 14),
          ),
        ],
      ),
    );
  }
}
