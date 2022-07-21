import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_bloc.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_event.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_state.dart';
import 'package:task_management/utils/color_extension.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/textfield.dart';

Random random = Random();

class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  final key = GlobalKey<ScaffoldState>();
  GetAllProjectsModel getAllProjectsModel = GetAllProjectsModel();
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
/*  "Personal", "TeamWorks", "Home", "Meet"*/
  //List<String> listTitle = [];
  List<Color> listColors = [
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.red,
    Colors.green,
  ];
  var selectedColors;
  var hexColor;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('id');
      print(id);
      Future.delayed(Duration()).then((_) {
        ProgressDialog.showLoadingDialog(context);
        BlocProvider.of<ProjectBloc>(context).add(
            GetAllProjectsEvent(
                id: int.parse(id ?? ""),
            ));
        return "";
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.white.withOpacity(.97),
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Projects",
          style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocListener<ProjectBloc, BaseState>(
        listener: (context, state) async {
          if (state is StateOnSuccess) {
            ProgressDialog.hideLoadingDialog(context);
          } else if (state is GetAllProjectsState) {
            ProgressDialog.hideLoadingDialog(context);
            getAllProjectsModel = state.model!;
           // GetAllProjectsModel? model = state.model;
            /*for(var i=0;i< getAllProjectsModel.data!.length;i++){
              listTitle.add(getAllProjectsModel.data![i].name ?? "");
            }*/
            print(getAllProjectsModel.message??"");
           // Navigator.of(context).pop();
          } else if (state is DeleteProjectState) {
            ProgressDialog.hideLoadingDialog(context);
            DeleteProjectModel? model = state.model;
            print(model!.message??"");
          }else if (state is AddProjectState) {
            ProgressDialog.hideLoadingDialog(context);
            AddProjectModel? model = state.model;
           /* SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('project_id', model?.data?.id.toString() ?? "");*/
            print(model!.message??"");
            Navigator.of(context).pop();
          }else if (state is UpdateProjectState) {
            ProgressDialog.hideLoadingDialog(context);
            UpdateProjectModel? model = state.model;
            print(model!.message??"");
            Navigator.of(context).pop();
          }else if (state is StateErrorGeneral) {
            ProgressDialog.hideLoadingDialog(context);
          }
        },
        bloc: BlocProvider.of<ProjectBloc>(context),
        child:  BlocBuilder<ProjectBloc, BaseState>(builder: (context, state) {
          return buildWidget();
        }),
      ),
    );
  }

  Widget buildWidget(){
    return (getAllProjectsModel.data != null && getAllProjectsModel.data!.isNotEmpty) ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(getAllProjectsModel.data != null)
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(bottom: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 1.8),
              itemBuilder: (context, index) {
                return listTitleItem(getAllProjectsModel.data![index].name ?? "", index,);
              },
              itemCount: getAllProjectsModel.data?.length,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Theme(
                        data: ThemeData(
                            bottomSheetTheme: const BottomSheetThemeData(
                                backgroundColor: Colors.black,
                                modalBackgroundColor: Colors.grey)),
                        child: showAddDialogContent()));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 18, top: 16),
                width: 100,
                height: 100,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    color: CustomColors.colorBlue,
                    borderRadius: BorderRadius.circular(6)),
              ),
            )
          ],
        )) :  Center(
        child: Text(
        "No Project found for this user",
        style: CustomTextStyle.styleSemiBold
            .copyWith(color: CustomColors.colorBlue, fontSize: 18),
      ),
    );
  }

  listTitleItem(String e, index) {
    var color = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
    return Container(
      margin: EdgeInsets.only(
          left: index % 2 == 0 ? 20 : 4,
          top: 16,
          right: index % 2 == 0 ? 12 : 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(0, 4),
                blurRadius: 4,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: HexColor.fromHex(getAllProjectsModel.data![index].color ?? "").withOpacity(0.2),
                    shape: BoxShape.circle),
              ),
              Container(
                  width: 12,
                  height: 12,
                  decoration:
                      BoxDecoration(color: HexColor.fromHex(getAllProjectsModel.data![index].color ?? ""),
                          shape: BoxShape.circle)),
            ],
          ),
          const Spacer(
            flex: 8,
          ),
          Text(
            e,
            style: CustomTextStyle.styleSemiBold
                .copyWith(color: Colors.black, fontSize: 18),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "10 Tasks",
            style: CustomTextStyle.styleMedium
                .copyWith(color: Colors.grey, fontSize: 14),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: (){
                    titleController?.text = getAllProjectsModel.data![index].name ?? "";
                    descriptionController?.text = getAllProjectsModel.data![index].description ?? "abc";
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Theme(
                            data: ThemeData(
                                bottomSheetTheme: const BottomSheetThemeData(
                                    backgroundColor: Colors.black,
                                    modalBackgroundColor: Colors.grey)),
                            child: showEditDialogContent(
                                index,
                                titleController!,
                                descriptionController!,
                              HexColor.fromHex(getAllProjectsModel.data![index].color ?? ""),
                            )));
                  },
                  icon: const Icon(Icons.edit,color: CustomColors.colorBlue,),
              ),
              IconButton(
                  onPressed: (){
                    _deleteProject(
                      id: getAllProjectsModel.data![index].id
                    );
                  },
                  icon: const Icon(Icons.delete,color: CustomColors.colorBlue,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showAddDialogContent() {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              label: "Title",
              minLines: 5,
              textEditingController: titleController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              label: "Description",
              minLines: 5,
              textEditingController: descriptionController,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 32),
              child: Text(
                "Choose Color",
                style: CustomTextStyle.styleBold,
              ),
            ),
            Container(
              height: 56,
              margin: const EdgeInsets.only(top: 24),
              child: ListView(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: listColors
                    .map((e) => GestureDetector(
                          onTap: () {
                            setState(() async {
                             /* SharedPreferences prefs = await SharedPreferences.getInstance();
                              var authToken = prefs.getString('id');
                              print(authToken);*/
                              selectedColors = e;
                              hexColor = e.toHex();
                              Color color = HexColor.fromHex(hexColor);
                              print(hexColor +" -- " + color.toString());
                            });
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            child: selectedColors == e
                                ? const Icon(Icons.check)
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
            ),
            Button(
              "Done",
              onPress: () {
                _addProject(
                  duration: 0,
                  archive: true,
                  color: hexColor,
                  is_private: true,
                  name: titleController?.text,
                  description: descriptionController?.text
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  showEditDialogContent(int index,TextEditingController title, TextEditingController description, Color selectedColor) {
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
              Container(
                margin: const EdgeInsets.only(left: 16, top: 32),
                child: Text(
                  "Choose Color",
                  style: CustomTextStyle.styleBold,
                ),
              ),
              Container(
                height: 56,
                margin: const EdgeInsets.only(top: 24),
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: listColors
                      .map((e) => GestureDetector(
                    onTap: () {
                      setState(()  {
                        /*SharedPreferences prefs = await SharedPreferences.getInstance();
                              var authToken = prefs.getString('access');
                              print(authToken);*/
                        selectedColor = e;
                        hexColor = e.toHex();
                        Color color = HexColor.fromHex(hexColor);
                        print(hexColor +" -- " + color.toString());
                      });
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      child: selectedColor.value == e.value
                          ? const Icon(Icons.check)
                          : Container(),
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          shape: BoxShape.rectangle,
                          color: e),
                    ),
                  ))
                      .toList(),
                ),
              ),
              Button(
                "Done",
                onPress: () {
                  _updateProject(
                      id: getAllProjectsModel.data![index].id,
                      status_id: getAllProjectsModel.data![index].statusId,
                      duration: 0,
                      archive: getAllProjectsModel.data![index].archive,
                      color: hexColor,
                      is_private: getAllProjectsModel.data![index].isPrivate,
                      name: titleController?.text,
                      description: descriptionController?.text
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _addProject({
    String? color,
    String? name,
    String? description,
    int? duration,
    bool? is_private,
    bool? archive,
  }) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProjectBloc>(context).add(
          AddProjectEvent(
            description: description ?? "",
            name: name ?? "",
            is_private: is_private ?? true,
            color: color ?? "",
            archive: archive ?? true,
            duration: duration ?? 0,
          ));
      return "";
    });
  }

  Future<String> _updateProject({
    int? id,
    String? status_id,
    String? color,
    String? name,
    String? description,
    int? duration,
    bool? is_private,
    bool? archive,
  }) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProjectBloc>(context).add(
          UpdateProjectEvent(
            id: id ?? 0,
            status_id: status_id ?? "",
            description: description ?? "",
            name: name ?? "",
            is_private: is_private ?? true,
            color: color ?? "",
            archive: archive ?? true,
            duration: duration ?? 0,
          ));
      return "";
    });
  }

  Future<String> _deleteProject({
    int? id,
  }) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProjectBloc>(context).add(
          DeleteProjectEvent(
            id: id ?? 0,
          ));
      return "";
    });
  }
}
