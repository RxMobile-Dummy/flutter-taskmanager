import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_state.dart';
import 'package:task_management/ui/home/pages/quick_notes.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/decoration.dart';
import '../../../../../../widget/rounded_corner_page.dart';
import '../../../../../../widget/textfield.dart';
import '../../data/model/add_note_model.dart';
import '../../data/model/get_note_model.dart';
import 'package:task_management/injection_container.dart' as Sl;

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GetNoteModel getNoteModel = GetNoteModel();

  List<Color> listColors = [
    CustomColors.colorPurple,
    CustomColors.colorBlue,
    CustomColors.colorRed,
    Colors.green,
    Colors.cyan
  ];

   Color? selectedColors;

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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(model!.message??""),
              ));
              Navigator.of(context).pop();
              //_getNote();
            }else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
            }
          },
          bloc: BlocProvider.of<AddNoteBloc>(context),
          child:  BlocBuilder<AddNoteBloc, BaseState>(builder: (context, state) {
            return buildWidget();
          }),
      ),
    );
  }

  Widget buildWidget(){
    return RoundedCornerPage(
      title: "Add Note",
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
                  label: "title",
                  minLines: 5,
                  textEditingController: titleController,
                ),
                CustomTextField(
                  label: "Description",
                  minLines: 5,
                  textEditingController: descriptionController,
                ),
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
                  onPress: () {
                    _addNote(
                        task_id: "",
                      title: titleController.text,
                      project_id: "",
                      description: descriptionController.text,
                    );
                  },
                ),
              ],
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
      BlocProvider.of<AddNoteBloc>(context).add(
          AddNoteEvent(
            description: description ?? "",
            project_id: project_id ?? "",
            title: title ?? "",
            task_id: task_id ?? "",
          ));
      return "";
    });
  }
}
