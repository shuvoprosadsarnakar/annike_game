import 'package:annike_game/cubit/game_input_cubit.dart';
import 'package:annike_game/screen/home_page.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 720),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Game',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: BlocProvider(
        create: (context) => GameInputCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}
