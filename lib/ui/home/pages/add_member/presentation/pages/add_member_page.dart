import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_bloc.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_event.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/device_file.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/profile_pi.dart';
import '../../../../../../widget/size.dart';
import '../../../../fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import '../../data/model/invite_project_assign_model.dart';

class GetAllUserList extends StatefulWidget {
String project_id;
GetAllUserList({required this.project_id});

  @override
  _GetAllUserListState createState() => _GetAllUserListState();
}

class _GetAllUserListState extends State<GetAllUserList> {
  AddMemberModel addMemberModel = AddMemberModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     await _getAllUser();
    });

  }

  Future<String> _getAllUser() {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddMemberBloc>(context).add(
          AddMemberEvent());
      return "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "All User List",
          style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocListener<AddMemberBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is InviteProjectAssignState) {
              ProgressDialog.hideLoadingDialog(context);
              InviteProjectAssignModel? model = state.model;
              if(model!.status == true){
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: model.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
               // Navigator.of(context).pop();
              }else{
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: model.error ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }
            } else if (state is AddMemberState) {
              ProgressDialog.hideLoadingDialog(context);
              addMemberModel = state.model!;
              if(addMemberModel.success == true){
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: addMemberModel.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }else{
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: addMemberModel.error ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }
            } else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
              Fluttertoast.cancel();
              Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: DeviceUtil.isTablet ? 20 : 12,
                  backgroundColor: CustomColors.colorBlue,
                  textColor: Colors.white
              );
            }
          },
          bloc: BlocProvider.of<AddMemberBloc>(context),
          child:  BlocBuilder<AddMemberBloc, BaseState>(
            builder: (context, state) {
              return (addMemberModel.data != null && addMemberModel.data!.isNotEmpty)
                  ? buildWidget(addMemberModel.data ?? [])
                  : (addMemberModel.data == null)
                  ? const SizedBox():Center(
                child: Text(
                  "No user found",
                  style: CustomTextStyle.styleSemiBold
                      .copyWith(color: CustomColors.colorBlue, fontSize: 18),
                ),
              );
              /* if (state is AddMemberState) {
                ProgressDialog.hideLoadingDialog(context);
                addMemberModel = state.model!;
                return buildWidget(addMemberModel.data ?? []);
              } else if (state is StateErrorGeneral) {
                ProgressDialog.hideLoadingDialog(context);
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
                return const SizedBox();
              }else {
                return Center(
                  child: Text(
                    "No user found",
                    style: CustomTextStyle.styleSemiBold
                        .copyWith(color: CustomColors.colorBlue, fontSize: 18),
                  ),
                );
              }*/
            },
          ),));
  }

  Widget buildWidget(List<Data> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Card(
            elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     children: [
                       sized_16(),
                       userProfilePic(radius: 30.0,imagePath: "${Strings.baseUrl}${list[index].profilePic}"),
                       sized_16(size: 16.0),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                          Row(
                            children: [
                              Text(
                                list[index].firstName ?? "",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.styleSemiBold
                                    .copyWith(fontSize: 15),
                              ),
                              Text(
                                " ${list[index].lastName}",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.styleSemiBold
                                    .copyWith(fontSize: 15),
                              ),
                            ],
                          ),
                           const SizedBox(height: 5),
                           Text(
                             list[index].email ?? "",
                             softWrap: true,
                             overflow: TextOverflow.ellipsis,
                             style: CustomTextStyle.styleSemiBold
                                 .copyWith(fontSize: 15),
                           ),
                           const SizedBox(height: 5),
                           Text(
                             list[index].mobileNumber.toString().substring(3),
                             softWrap: true,
                             overflow: TextOverflow.ellipsis,
                             style: CustomTextStyle.styleSemiBold
                                 .copyWith(fontSize: 15),
                           ),
                         ],
                       ),
                     ],
                   ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            _addMember(
                              assignee_ids: list[index].id.toString(),
                              project_id: widget.project_id,
                            );
                          },
                          child: Text(
                              "Add",
                            style: CustomTextStyle.styleSemiBold
                                .copyWith(
                                fontSize: DeviceUtil.isTablet ? 18 : 16,color: CustomColors.colorBlue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
          ),
        );
      },
    );
  }

  Future<String> _addMember({
    String? project_id,
    String? assignee_ids,
  }) {
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddMemberBloc>(context).add(InviteProjectAssignEvent(
        project_id: project_id ?? "",
        assignee_ids: assignee_ids ?? "",
      ));
      return "";
    });
  }
}
