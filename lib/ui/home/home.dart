import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_bloc.dart';
import 'package:task_management/ui/home/pages/my_task.dart';
import 'package:task_management/ui/home/pages/Project/presentation/pages/project.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/pages/profile.dart';
import 'package:task_management/ui/home/pages/quick_notes.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_bloc.dart';
import '../../utils/device_file.dart';
import '../../utils/style.dart';
import 'fab_menu_option/add_check_list.dart';
import 'fab_menu_option/add_note/presentation/pages/add_note.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import 'fab_menu_option/add_task/presentation/pages/add_task.dart';
import 'package:task_management/injection_container.dart' as Sl;
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  late Widget myTask;
  Widget dashboardWidget =  Project();

  /* Project();*/
  Widget quickNoteWidget = QuickNotes();
  Widget profileWidget = MultiBlocProvider(
    providers: [
      BlocProvider<UserStatusBloc>(
        create: (context) => Sl.Sl<UserStatusBloc>(),
      ),
      BlocProvider<UpdateProfileBloc>(
        create: (context) => Sl.Sl<UpdateProfileBloc>(),
      ),
    ],
    child: Profile(),
  );
  Widget? selectedWidget;
  int menuIndex = 0;
  GlobalKey keyFab = GlobalKey();
  bool isFabClicked = false;
  late AnimationController _controller;
  AddTaskBloc? addTaskBloc;

  static const List<IconData> icons = const [ Icons.add_task, Icons.note_add_outlined, Icons.check_box_outlined ];
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    myTask =  MyTask();/*BlocProvider<AddTaskBloc>(
      create: (context) => Sl.Sl<AddTaskBloc>(),
      child: MyTask(),
    );*/
    selectedWidget = myTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: selectedWidget,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          notchMargin: 8,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: IconButton(
                  icon: Icon(Icons.check_circle,
                      size: DeviceUtil.isTablet ? 30 : 20,
                      color: menuIndex == 0 ? Colors.black : Colors.grey),
                  onPressed: () {
                    menuIndex = 0;
                    getMenuItem();
                  },
                )),
                Expanded(
                    child: IconButton(
                  icon: Icon(
                    Icons.dashboard,
                    size: DeviceUtil.isTablet ? 30 : 20,
                    color: menuIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    menuIndex = 1;
                    getMenuItem();
                  },
                )),
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.receipt,
                            size: DeviceUtil.isTablet ? 30 : 20,
                            color: menuIndex == 2 ? Colors.black : Colors.grey),
                        onPressed: () {
                          menuIndex = 2;
                          getMenuItem();
                        })),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.person,
                            size: DeviceUtil.isTablet ? 30 : 20,
                            color: menuIndex == 3 ? Colors.black : Colors.grey),
                        onPressed: () {
                          menuIndex = 3;
                          getMenuItem();
                        })),
              ],
            ),
          ),
        ),
       //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: /*DeviceUtil.isTablet ? ExpandableFab(
          distance: 112.0,
          children: [
            ActionButton(
              onPressed: () {
                Get.back();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTask()
                )).then((value) {
                print(value);
               (value != null) ? BlocProvider.of<AddTaskBloc>(context).add(GetTaskEvent(
                date: value ?? "",
                )) : const SizedBox();
                });
              },
              icon: const Icon(Icons.add_task),
            ),
            ActionButton(
              onPressed: () {
                Get.back();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNote()),
                );
              },
              icon: const Icon(Icons.note_add_outlined),
            ),
            ActionButton(
              onPressed: (){
                Get.back();
                Get.to(AddCheckList());
              },
              icon: const Icon(Icons.check_box_outlined),
            ),
          ],
        )*/ /*: Column(
          mainAxisSize: MainAxisSize.min,
          children:  List.generate(icons.length, (int index) {
            Widget child =  Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child:  ScaleTransition(
                scale:  CurvedAnimation(
                  parent: _controller,
                  curve:  Interval(
                      0.0,
                      1.0 - index / icons.length / 2.0,
                      curve: Curves.easeOut
                  ),
                ),
                child:  FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.black,
                  mini: true,
                  child:  Icon(icons[index], color: Colors.white),
                  onPressed: () {
                    if(index == 0){
                      Get.back();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTask()),
                      ).then((value) {
                        print(value);
                        BlocProvider.of<AddTaskBloc>(context).add(GetTaskEvent(
                          date: value,
                        ));
                      });
                    }else if(index == 1){
                      Get.back();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNote()),
                      );
                    }else{
                      Get.back();
                      Get.to(AddCheckList());
                    }
                  },
                ),
              ),
            );
            return child;
          }).toList()..add(
             SizedBox(
               height: 42,
               width: 42,
               child: FittedBox(
                 child: FloatingActionButton(
                   heroTag: null,
                   backgroundColor: Colors.black,
                   child:  AnimatedBuilder(
                     animation: _controller,
                     builder: (BuildContext context, Widget? child) {
                       return  Transform(
                         transform:  Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                         alignment: FractionalOffset.center,
                         child:  Icon(_controller.isDismissed ? Icons.add : Icons.close,color: Colors.white),
                       );
                     },
                   ),
                   onPressed: () {
                     if (_controller.isDismissed) {
                       _controller.forward();
                     } else {
                       _controller.reverse();
                     }
                   },
                 ),
               ),
             )
          ),
        )*//*FloatingActionButton(
          onPressed: () {
            showTaskMenuDialog();
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
        )*/  FabCircularMenu(
          alignment: Alignment.bottomCenter,
            fabSize: DeviceUtil.isTablet ? 60 : 40,
            fabColor: Colors.black,
            ringColor: Colors.transparent,
            ringDiameter: MediaQuery.of(context).size.width * 1.0,
            ringWidth:  (MediaQuery.of(context).size.width * 1.0 ) * 0.5,
            /*fabMargin: EdgeInsets.all(0),*/
            fabCloseIcon:  Icon(Icons.close,size: DeviceUtil.isTablet ? 30 : 20,color: Colors.white,),
            fabOpenIcon: Icon(Icons.add,size: DeviceUtil.isTablet ? 30 : 20,color: Colors.white,),
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Get.back();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTask()
                      )).then((value) {
                    print(value);
                    (value != null) ? BlocProvider.of<AddTaskBloc>(context).add(GetTaskEvent(
                      date: value ?? "",
                    )) : const SizedBox();
                  });
                },
                icon:  Icon(
                    Icons.add_task,
                  size: DeviceUtil.isTablet ? 30 : 20,
                ),),
              IconButton(
                onPressed: () {
                  Get.back();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNote()),
                  );
                },
                icon:  Icon(Icons.note_add_outlined,
                  size: DeviceUtil.isTablet ? 30 : 20,),
              ),
              IconButton(
                onPressed: (){
                  Get.back();
                  Get.to(AddCheckList());
                },
                icon:  Icon(Icons.check_box_outlined,
                  size: DeviceUtil.isTablet ? 30 : 20,),
              )
            ]
        ));
  }

  showTaskMenuDialog() {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: Wrap(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Add Task",
                      style: CustomTextStyle.styleSemiBold,
                    ),
                    onPressed: () {
                      Get.back();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(providers: [
                              BlocProvider<AddTaskBloc>(
                                create: (context) => Sl.Sl<AddTaskBloc>(),
                              ),
                            ], child: AddTask())),
                      )/*.then((value) {
                        if (value != null) {
                          context.read<AddTaskBloc>().getTaskCall();
                        }
                        print(value);
                      })*/;
                      //Get.to(AddTask());
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    child: Text(
                      "Add Quick Notes",
                      style: CustomTextStyle.styleSemiBold,
                    ),
                    onPressed: () {
                      Get.back();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddNote()),
                      );
                      //Get.to(AddNote());
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Add Check List",
                      style: CustomTextStyle.styleSemiBold,
                    ),
                    onPressed: () {
                      Get.back();
                      Get.to(AddCheckList());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
    return outputFormat.format(inputDate);
  }

  getMenuItem() {
    if (menuIndex == 0 && selectedWidget != myTask) {
      selectedWidget = myTask;
      setState(() {});
    } else if (menuIndex == 1 && selectedWidget != dashboardWidget) {
      selectedWidget = dashboardWidget;
      setState(() {});
    } else if (menuIndex == 2 && selectedWidget != quickNoteWidget) {
      selectedWidget = quickNoteWidget;
      setState(() {});
    }else if (menuIndex == 3 && selectedWidget != profileWidget) {
      selectedWidget = profileWidget;
      setState(() {});
    }/*  else {
      if (selectedWidget != profileWidget) {
        selectedWidget = profileWidget;
        setState(() {});
      }
    }*/
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
  super.key,
  this.initialOpen,
  required this.distance,
  required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Colors.black,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 90.0),
          progress.value * maxDistance,
        );
        return Positioned(
          left: 426.5 + offset.dx,
          bottom: 0.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
  super.key,
  this.onPressed,
  required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.black,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
  super.key,
  required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
