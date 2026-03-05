import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/my_channels_screen.dart';
import 'screens/channel_home_screen.dart';
import 'screens/add_device_to_channel_screen.dart';
import 'screens/my_devices_screen.dart';
import 'screens/my_scenes_screen.dart';
import 'screens/manage_scene_screen.dart';
import 'screens/users_screen.dart';
import 'screens/user_permissions_screen.dart';
import 'screens/my_account_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const IoTApp());
}

class IoTApp extends StatelessWidget {
  const IoTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF5E60CE),
        ),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const OnboardingScreen(),
      routes: {
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(),
        '/check-email': (_) => const CheckEmailScreen(),
        '/create-password': (_) => const CreateNewPasswordScreen(),
        '/home': (_) => const HomeScreen(),
        '/my-channels': (_) => const MyChannelsScreen(),
        '/channel-home': (_) => const ChannelHomeScreen(),
        '/add-channel-qr': (_) => const AddChannelQRScreen(),
        '/add-channel-wifi': (_) => const AddChannelWifiScreen(),
        '/connecting': (_) => const ConnectingScreen(),
        '/connection-success': (_) => const ConnectionSuccessScreen(),
        '/connection-failed': (_) => const ConnectionFailedScreen(),
        '/add-device': (_) => const AddDeviceToChannelScreen(),
        '/my-devices': (_) => const MyDevicesScreen(),
        '/my-scenes': (_) => const MyScenesScreen(),
        '/manage-scene': (_) => const ManageSceneScreen(),
        '/users': (_) => const UsersScreen(),
        '/user-permissions': (_) => const UserPermissionsScreen(),
        '/my-account': (_) => const MyAccountScreen(),
      },
    );
  }
}
