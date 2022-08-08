import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import '../../../../../../utils/border.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/device_file.dart';
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
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 =  GlobalKey<FormState>();
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
  var selectedColorsForEdit;
  var hexColor;

  @override
  void initState() {
   /* WidgetsBinding.instance.addPostFrameCallback((_) async {

    });*/
    _getProject();
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
            if(getAllProjectsModel.success == true){
              Fluttertoast.showToast(
                  msg: getAllProjectsModel.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }else{
              Fluttertoast.showToast(
                  msg: getAllProjectsModel.error ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
           // Navigator.of(context).pop();
          } else if (state is DeleteProjectState) {
            ProgressDialog.hideLoadingDialog(context);
            DeleteProjectModel? model = state.model;
            if(model!.success == true){
              Fluttertoast.showToast(
                  msg: model.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
              _getProject();
            }else{
              Fluttertoast.showToast(
                  msg: model.error ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
          }else if (state is AddProjectState) {
            ProgressDialog.hideLoadingDialog(context);
            AddProjectModel? model = state.model;
           /* SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('project_id', model?.data?.id.toString() ?? "");*/
            if(model!.success == true){
              Fluttertoast.showToast(
                  msg: model.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
              Navigator.of(context).pop();
              _getProject();
            }else{
              Fluttertoast.showToast(
                  msg: model.error ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
          }else if (state is UpdateProjectState) {
            ProgressDialog.hideLoadingDialog(context);
            UpdateProjectModel? model = state.model;
            if(model!.success == true){
              Fluttertoast.showToast(
                  msg: model.message ?? "",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
              Navigator.of(context).pop();
              _getProject();
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
                return listTitleItem(
                  getAllProjectsModel.data![index].name ?? "",
                  index,
                  getAllProjectsModel.data![index].description ?? "",
                  getAllProjectsModel.data![index].createdAt ?? "",
                );
              },
              itemCount: getAllProjectsModel.data?.length,
            ),
            GestureDetector(
              onTap: () {
                titleController!.clear();
                descriptionController!.clear();
                selectedColors = "";
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => StatefulBuilder(
    builder: (BuildContext context, StateSetter mystate) {
    return  Theme(
                        data: ThemeData(
                            bottomSheetTheme: const BottomSheetThemeData(
                                backgroundColor: Colors.black,
                                modalBackgroundColor: Colors.grey)),
                        child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SingleChildScrollView(child: addProjectDialog(mystate),)));}));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 18, top: 16),
                width: DeviceUtil.isTablet ? 100 : 70,
                height: DeviceUtil.isTablet ? 100 : 70,
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
        )) : (getAllProjectsModel.data == null)? SizedBox():  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No Project",
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
                titleController!.text = "";
                descriptionController!.text = "";
                selectedColors = "";
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter mystate) {
                        return Theme(
                        data: ThemeData(
                            bottomSheetTheme: const BottomSheetThemeData(
                                backgroundColor: Colors.black,
                                modalBackgroundColor: Colors.grey)),
                        child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: addProjectDialog(mystate)));}));
              }, child:  Text(
              "Add Project",
              style: CustomTextStyle.styleSemiBold
                  .copyWith(color: Colors.white,
                  fontSize: DeviceUtil.isTablet ? 18 : 14),
            ),)
          ],
        ),
    );
  }

  listTitleItem(String projectName, index,String description,String createDate) {
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
            projectName,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.styleSemiBold
                .copyWith(color: Colors.black, fontSize: DeviceUtil.isTablet ? 18 : 16),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            description,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.styleSemiBold
                .copyWith(color: Colors.black, fontSize: DeviceUtil.isTablet ? 18 : 14),
          ),
          const Spacer(
            flex: 1,
          ),
         /* Text(
            createDate,
            style: CustomTextStyle.styleSemiBold
                .copyWith(color: Colors.black, fontSize: 18),
          ),
          const Spacer(
            flex: 1,
          ),*/
       /*   Text(
            "10 Tasks",
            style: CustomTextStyle.styleMedium
                .copyWith(color: Colors.grey, fontSize: 14),
          ),
          const Spacer(flex: 2),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: (){
                    titleController?.text = getAllProjectsModel.data![index].name ?? "";
                    descriptionController?.text = getAllProjectsModel.data![index].description ?? "abc";
                    selectedColorsForEdit = HexColor.fromHex(getAllProjectsModel.data![index].color ?? "");
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => StatefulBuilder(
                          builder: (BuildContext context, StateSetter mystate) {
                            return  Theme(
                                data: ThemeData(
                                    bottomSheetTheme: const BottomSheetThemeData(
                                        backgroundColor: Colors.black,
                                        modalBackgroundColor: Colors.grey)),
                                child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: editProjectDialog(
                                      mystate,
                                      index,
                                      titleController!,
                                      descriptionController!,
                                    )));
                          },
                        ));
                  },
                  icon:  Icon(
                    Icons.edit,color: CustomColors.colorBlue,
                    size: DeviceUtil.isTablet ? 24 : 20,
                  ),
              ),
              IconButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title:  Text(
                          "Delete Project",
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
                              _deleteProject(
                                  id: getAllProjectsModel.data![index].id
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
                  /*  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Task"),
                        content: const Text("Are you sure you want to delete this project ?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              _deleteProject(
                                  id: getAllProjectsModel.data![index].id
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
                  icon:  Icon(Icons.delete,color: CustomColors.colorBlue,
                    size: DeviceUtil.isTablet ? 24 : 20,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  addProjectDialog(StateSetter mystate) {
    return Form(
      key: _formKey1,
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:  SingleChildScrollView(
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
                          return 'Please enter Project title';
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
                ),*/
                  Container(
                    margin: const EdgeInsets.only(left: 16, top: 32),
                    child: Text(
                      "Choose Color",
                      style: CustomTextStyle.styleBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
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
                          mystate(()  {
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
                    verticalMargin: 10,
                    horizontalMargin: 0,
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      if(_formKey1.currentState!.validate()){
                        _formKey1.currentState?.save();
                        if(hexColor == null || hexColor == ""){
                          Fluttertoast.showToast(
                              msg: "Please select color.",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                        }else{
                          _addProject(
                              duration: 0,
                              archive: true,
                              color: hexColor,
                              is_private: true,
                              name: titleController?.text,
                              description: descriptionController?.text
                          );
                        }
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
            ),
          ),
        ),
      ),
    );
  }

  editProjectDialog(StateSetter mystate,int index,TextEditingController title, TextEditingController description) {
    print("Color $selectedColorsForEdit");
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
                    controller: title,
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Please enter Project title';
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
                  margin: const EdgeInsets.only(top: 16),
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.only(left: 4, right: 16),
                  child: TextFormField(
                    style: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                    controller: description,
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
                /*  CustomTextField(
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
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 32),
                  child: Text(
                    "Choose Color",
                    style: CustomTextStyle.styleBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
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
                        FocusScope.of(context).unfocus();
                        mystate(()  {
                          /*SharedPreferences prefs = await SharedPreferences.getInstance();
                              var authToken = prefs.getString('access');
                              print(authToken);*/
                          selectedColorsForEdit = e;
                          hexColor = e.toHex();

                          Color color = HexColor.fromHex(hexColor);
                          print(hexColor +" -- " + color.toString());
                        });
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        margin: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                            color: e),
                        child: selectedColorsForEdit.value == e.value
                            ?  const Icon(Icons.check)
                            : Container(),
                      ),
                    ))
                        .toList(),
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
          ),
        ),
      ),
    ));
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

  Future<String> _getProject() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    print(id);
     return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProjectBloc>(context).add(
          GetAllProjectsEvent(
            id: int.parse(id ?? ""),
          ));
      return "";
    });
  }
}
