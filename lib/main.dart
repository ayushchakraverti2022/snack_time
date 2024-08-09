import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:snack_time/admin/add_food.dart';
import 'package:snack_time/admin/admin_login.dart';
import 'package:snack_time/admin/home_admin.dart';
import 'package:snack_time/cubits/database/database_cubit.dart';
import 'package:snack_time/cubits/logincubit/login_cubit.dart';
import 'package:snack_time/cubits/sign/sign_up_cubit.dart';
import 'package:snack_time/firebase_options.dart';
import 'package:snack_time/page/botttom_navigation.dart';
import 'package:snack_time/page/login.dart';
import 'package:snack_time/page/onboard.dart';
import 'package:snack_time/page/order.dart';
import 'package:snack_time/page/profile.dart';
import 'package:snack_time/page/signup.dart';
import 'package:snack_time/page/wallet.dart';
import 'package:snack_time/widget/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Publishable_key;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => DatabaseCubit(),
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,

            body:FirebaseAuth.instance.currentUser?.uid == null?Onboard(): BottomNav() ,
            // body: SignUp(),
          )),
    );
  }
}

