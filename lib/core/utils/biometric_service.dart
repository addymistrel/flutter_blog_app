import 'package:flutter/services.dart';

class BiometricService {
  static const MethodChannel _channel = MethodChannel('com.example.biometric');

  static Future<bool> authenticate() async {
    try { 
      final result = await _channel.invokeMethod<bool>('authenticate');
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }
}
