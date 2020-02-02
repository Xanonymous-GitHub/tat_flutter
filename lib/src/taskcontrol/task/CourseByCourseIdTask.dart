import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/debug/log/Log.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/connector/CourseConnector.dart';
import 'package:flutter_app/src/store/json/CourseInfoJson.dart';
import 'package:flutter_app/src/taskcontrol/task/TaskModel.dart';
import 'package:flutter_app/ui/other/MyProgressDialog.dart';

import '../../../ui/other/ErrorDialog.dart';

class CourseByCourseIdTask extends TaskModel{
  static final String taskName = "CourseByCourseIdTask";
  String id;
  CourseByCourseIdTask(BuildContext context,this.id) : super(context, taskName);

  @override
  Future<TaskStatus> taskStart() async{
    MyProgressDialog.showProgressDialog(context, S.current.getCourseDetail );
    CourseInfoJson courseInfo = await CourseConnector.getCourseByCourseId(id);
    MyProgressDialog.hideProgressDialog();
    if( courseInfo != null ) {
      return TaskStatus.TaskSuccess;
    }else {
      _handleError();
      return TaskStatus.TaskFail;
    }
  }

  void _handleError() {
    ErrorDialogParameter parameter = ErrorDialogParameter(
      context: context,
      desc: S.current.getCourseDetailError,
    );
    ErrorDialog(parameter).show();
  }


}