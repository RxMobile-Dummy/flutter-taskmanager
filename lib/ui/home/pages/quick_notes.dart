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
import '../../../utils/colors.dart';
import '../../../utils/style.dart';

import '../../../widget/button.dart';
import '../../../widget/textfield.dart';

class QuickNotes extends StatefulWidget {
  @override
  _QuickNotesState createState() => _QuickNotesState();
}

class _QuickNotesState extends State<QuickNotes> {
  Random random = new Random(255);
  GetNoteModel getNoteModel = GetNoteModel();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
            Fluttertoast.showToast(
                msg: getNoteModel.message ?? "",
                toastLength: Toast.LENGTH_LONG,
                fontSize: 20,
                backgroundColor: CustomColors.colorBlue,
                textColor: Colors.white
            );
            print(getNoteModel.message??"");
          }else if (state is UpdateNoteState) {
            ProgressDialog.hideLoadingDialog(context);
             UpdateNoteModel? model = state.model;
            Fluttertoast.showToast(
                msg: model!.message ?? "",
                toastLength: Toast.LENGTH_LONG,
                fontSize: 20,
                backgroundColor: CustomColors.colorBlue,
                textColor: Colors.white
            );
            print(model.message??"");
            if(getNoteModel.success == true){
              Navigator.of(context).pop();
              _getNote();
            }
          }else if (state is DeleteNoteState) {
            ProgressDialog.hideLoadingDialog(context);
            DeleteNoteModel? model = state.model;
            Fluttertoast.showToast(
                msg: model!.message ?? "",
                toastLength: Toast.LENGTH_LONG,
                fontSize: 20,
                backgroundColor: CustomColors.colorBlue,
                textColor: Colors.white
            );
            print(model.message??"");
            if(getNoteModel.success == true){
              _getNote();
            }
          }else if (state is StateErrorGeneral) {
            ProgressDialog.hideLoadingDialog(context);
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 20,
                backgroundColor: CustomColors.colorBlue,
                textColor: Colors.white
            );
          }
        },
        child:  BlocBuilder<AddNoteBloc, BaseState>(builder: (context, state) {
          print(state);
          return (getNoteModel.data != null && getNoteModel.data!.isNotEmpty)
              ? buildWidget()  :  Center(
            child: Text(
              "No Note found for this user",
              style: CustomTextStyle.styleSemiBold
                  .copyWith(color: CustomColors.colorBlue, fontSize: 18),
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
                EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
                child: Text(
                  getNoteModel.data![index].title ?? "",
                  style: CustomTextStyle.styleMedium.copyWith(fontSize: 16),
                ),
              ),
              Container(
                padding:
                EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
                child: Text(
                  getNoteModel.data![index].description ?? "",
                  style: CustomTextStyle.styleMedium.copyWith(fontSize: 16),
                ),
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 IconButton(
                   icon: Icon(Icons.edit,color: CustomColors.colorBlue,),
                   onPressed: (){
                     titleController.text = getNoteModel.data![index].title ?? "";
                     descriptionController.text = getNoteModel.data![index].description ?? "abc";
                     showModalBottomSheet(
                         context: context,
                         builder: (context) => Theme(
                             data: ThemeData(
                                 bottomSheetTheme: const BottomSheetThemeData(
                                     backgroundColor: Colors.black,
                                     modalBackgroundColor: Colors.grey)),
                             child: showEditDialogContent(
                               index,
                               titleController,
                               descriptionController,
                             )));
                   },
                 ),
                 IconButton(
                   icon: Icon(Icons.delete,color: CustomColors.colorBlue,),
                   onPressed: (){
                     _deleteNote(
                       id: getNoteModel.data![index].id,
                     );
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

  showEditDialogContent(int index,TextEditingController title, TextEditingController description) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              CustomTextField(
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
              ),
              Button(
                "Done",
                onPress: () {
                  _updateNote(
                    title: title.text,
                    description: description.text,
                    id: getNoteModel.data![index].id,
                  );
                },
              ),
            ],
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
