enum DeviceType {
  phone(value: 600),
  tablet(value: 1024),
  desktop(value: 1440);

  const DeviceType({required this.value});

  final double value;
}
