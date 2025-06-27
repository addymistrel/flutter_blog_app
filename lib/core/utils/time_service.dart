import 'package:ntp/ntp.dart';

class TimeService {
  Duration _offset = Duration.zero;

  Future<void> syncTimeWithServer() async {
    try {
      final ntpTime = await NTP.now();
      final localTime = DateTime.now();
      _offset = ntpTime.difference(localTime);
    } catch (e) {
      _offset = Duration.zero; // fallback
    }
  }

  DateTime getAccurateNow() {
    return DateTime.now().add(_offset);
  }

  Duration get offset => _offset;
}
