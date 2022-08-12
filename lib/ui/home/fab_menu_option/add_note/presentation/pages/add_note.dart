import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_state.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/border.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/device_file.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/decoration.dart';
import '../../../../../../widget/rounded_corner_page.dart';
import '../../data/model/add_note_model.dart';
import '../../data/model/get_note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GetNoteModel getNoteModel = GetNoteModel();
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();

  List<Color> listColors = [
    CustomColors.colorPurple,
    CustomColors.colorBlue,
    CustomColors.colorRed,
    Colors.green,
    Colors.cyan
  ];

   Color? selectedColors;
  String enterDescriptionText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddNoteBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            }else if (state is AddNoteState) {
              ProgressDialog.hideLoadingDialog(context);
              AddNotesModel? model = state.model;
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
                BlocProvider.of<AddNoteBloc>(context).add(
                    GetNoteEvent());
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
          child:  BlocBuilder<AddNoteBloc, BaseState>(builder: (context, state) {
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
      title: "Add Note",
      showBackButton: true,
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
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
                          hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          hintText: "Title",
                          enabledBorder:
                          titleBorder(color: Colors.transparent),
                          focusedBorder:
                          titleBorder(color: Colors.transparent)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.only(left: 4, right: 16),
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
                      maxLength: 300,
                      onChanged: (value){
                        setState(() {
                          enterDescriptionText = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          counterText: "${enterDescriptionText.length}/300",
                          labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          hintText: "Description",
                          enabledBorder:
                          titleBorder(color: Colors.transparent),
                          focusedBorder:
                          titleBorder(color: Colors.transparent)),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  /* CustomTextField(
                  label: "Title",
                  minLines: 5,
                  errorMessage: "Please enter title.",
                  textEditingController: titleController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  label: "Description",
                  errorMessage: "Please enter description.",
                  minLines: 5,
                  textEditingController: descriptionController,
                ),*/
                  /*Container(
                  margin: EdgeInsets.only(left: 16, top: 32),
                  child: Text(
                    "Choose Color",
                    style: CustomTextStyle.styleBold,
                  ),
                ),
                Container(
                  height: 56,
                  margin: EdgeInsets.only(top: 24),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: listColors
                        .map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColors = e;
                        });
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        child: selectedColors != null &&
                            selectedColors == e
                            ? Icon(Icons.check)
                            : Container(),
                        margin: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                            color: e),
                      ),
                    ))
                        .toList(),
                  ),
                ),*/
                  Button(
                    "Done",
                    verticalMargin: 10,
                    horizontalMargin: 0,
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState?.save();
                        _addNote(
                          task_id: "",
                          title: titleController.text,
                          project_id: "",
                          description: descriptionController.text,
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
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _addNote({
    String? project_id,
    String? task_id,
    String? title,
    String? description,
  }) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context)..add(
          AddNoteEvent(
            description: description ?? "",
            project_id: project_id ?? "",
            title: title ?? "",
            task_id: task_id ?? "",
          ))..add(GetNoteEvent());
      return "";
    });
  }
}
