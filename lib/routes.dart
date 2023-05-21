import 'package:get/get.dart';
import 'package:students/core/middelware.dart';
import 'package:students/view/screen/auth/student/login_student.dart';
import 'package:students/view/screen/auth/teacher/login_teacher.dart';
import 'package:students/view/screen/home/choose_login.dart';
import 'package:students/view/screen/home/student/student_lessons.dart';
import 'package:students/view/screen/home/teacher/add_date.dart';
import 'package:students/view/screen/home/teacher/add_lesson_student.dart';
import 'package:students/view/screen/home/teacher/add_student.dart';
import 'package:students/view/screen/home/teacher/dashboard.dart';
import 'package:students/view/screen/home/load_page.dart';
import 'package:students/view/screen/home/student/student_dashboard.dart';
import 'package:students/view/screen/home/teacher/date_data.dart';
import 'package:students/view/screen/home/teacher/lesoonsDataPage.dart';

import 'core/constant/approutes.dart';
import 'view/screen/home/teacher/choose_student_page.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: AppRoute.load,
      page: () => const LoadPage(),
      middlewares: [MiddleWare()]),
  GetPage(
    name: AppRoute.userTypePage,
    page: () => const UserTypePage(),
  ),
  GetPage(
    name: AppRoute.studentLessons,
    page: () => const StudentLessonsPage(),
  ),
  GetPage(
    name: AppRoute.dateDataPage,
    page: () => const DateDataPage(),
  ),
  GetPage(
    name: AppRoute.addDate,
    page: () => const AddDatePage(),
  ),
  GetPage(
    name: AppRoute.addStudent,
    page: () => const TeacherAddStudentPage(),
  ),
  GetPage(
    name: AppRoute.lessonsData,
    page: () => const LessonsData(),
  ),
  GetPage(
    name: AppRoute.studentDashboard,
    page: () => const StudentDashboard(),
  ),
  GetPage(
    name: AppRoute.addLessonStudent,
    page: () => const AddLessonStudentPage(),
  ),
  GetPage(
    name: AppRoute.chooseStudents,
    page: () => const ChooseStudentsPage(),
  ),
  GetPage(
    name: AppRoute.teacherDashboard,
    page: () => const TeacherDashboardPage(),
  ),
  GetPage(
    name: AppRoute.loginStudent,
    page: () => const LoginStudentPage(),
  ),
  GetPage(
    name: AppRoute.loginTeacher,
    page: () => const LoginTeacherPage(),
  ),
];
