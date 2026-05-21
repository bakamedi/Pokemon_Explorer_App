import 'package:poke_test/data/providers/device/device_provider.dart';
import 'package:poke_test/domain/repositories/device/device_repository.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  DeviceRepositoryImpl({required this._deviceUtilProvider});

  final DeviceUtilProvider _deviceUtilProvider;

  @override
  Future<String?> readString({required String key}) async {
    return await _deviceUtilProvider.readString(key: key);
  }

  @override
  Future<void> writeString({required String key, required String value}) async {
    await _deviceUtilProvider.writeString(key: key, value: value);
  }

  @override
  Future<void> writeBool({required String key, required bool value}) async {
    await _deviceUtilProvider.writeBool(key: key, value: value);
  }

  @override
  Future<void> clear() async {
    await _deviceUtilProvider.clear();
  }

  @override
  Future<void> delete({required String key}) async {
    await _deviceUtilProvider.delete(key: key);
  }
  
  @override
  Future<bool?> readBool({required String key}) async {
    return await _deviceUtilProvider.readBool(key: key);
  }
}
