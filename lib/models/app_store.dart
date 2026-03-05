import 'package:flutter/material.dart';

// ─── Device Model ──────────────────────────────────────────────────────────────
class DeviceItem {
  final String name;
  final String channelName;
  final String plug;
  final IconData icon;
  bool isOn;

  DeviceItem({
    required this.name,
    required this.channelName,
    required this.plug,
    required this.icon,
    this.isOn = false,
  });

  DeviceItem copyWith({String? name, String? channelName, String? plug, IconData? icon, bool? isOn}) {
    return DeviceItem(
      name: name ?? this.name,
      channelName: channelName ?? this.channelName,
      plug: plug ?? this.plug,
      icon: icon ?? this.icon,
      isOn: isOn ?? this.isOn,
    );
  }
}

// ─── Channel Model ─────────────────────────────────────────────────────────────
class ChannelItem {
  final String name;
  final String room;
  final int totalPlugs;
  bool isOn;
  List<DeviceItem> devices;

  ChannelItem({
    required this.name,
    this.room = '',
    this.totalPlugs = 4,
    this.isOn = true,
    List<DeviceItem>? devices,
  }) : devices = devices ?? [];

  int get activeDevices => devices.where((d) => d.isOn).length;
  String get devicesLabel => '${devices.length}/$totalPlugs Devices';

  ChannelItem copyWith({String? name, String? room, bool? isOn, List<DeviceItem>? devices}) {
    return ChannelItem(
      name: name ?? this.name,
      room: room ?? this.room,
      totalPlugs: totalPlugs,
      isOn: isOn ?? this.isOn,
      devices: devices ?? this.devices,
    );
  }
}

// ─── Scene Model ───────────────────────────────────────────────────────────────
class SceneItem {
  final String name;
  final int deviceCount;
  bool isOn;
  final IconData icon;

  SceneItem({required this.name, this.deviceCount = 0, this.isOn = false, this.icon = Icons.nightlight_round});
}

// ─── Member Model ──────────────────────────────────────────────────────────────
class MemberItem {
  final String name;
  final String? avatarPath;

  const MemberItem({required this.name, this.avatarPath});
}

// ─── App Store (singleton) ────────────────────────────────────────────────────
class AppStore {
  AppStore._();
  static final AppStore instance = AppStore._();

  // Channels
  final ValueNotifier<List<ChannelItem>> channels = ValueNotifier([
    ChannelItem(
      name: 'Migro_CH1',
      room: 'Living Room',
      isOn: true,
      devices: [
        DeviceItem(name: 'Light Bulb', channelName: 'Migro_CH1', plug: 'Plug 1', icon: Icons.lightbulb_outline, isOn: true),
        DeviceItem(name: 'Fan',        channelName: 'Migro_CH1', plug: 'Plug 2', icon: Icons.air,              isOn: false),
        DeviceItem(name: 'Desktop',    channelName: 'Migro_CH1', plug: 'Plug 3', icon: Icons.desktop_windows,  isOn: false),
        DeviceItem(name: 'TV',         channelName: 'Migro_CH1', plug: 'Plug 4', icon: Icons.tv,               isOn: false),
      ],
    ),
    ChannelItem(name: 'CH 2', room: 'Bed Room',   isOn: true,  devices: [DeviceItem(name: 'Tubelight', channelName: 'CH 2', plug: 'Plug 1', icon: Icons.lightbulb_outline)]),
    ChannelItem(name: 'CH 3', room: 'Bath Room',  isOn: false, devices: [DeviceItem(name: 'Geyser',    channelName: 'CH 3', plug: 'Plug 1', icon: Icons.hot_tub)]),
    ChannelItem(name: 'CH 4', room: 'Kitchen',    isOn: true,  devices: [
      DeviceItem(name: 'Microwave', channelName: 'CH 4', plug: 'Plug 1', icon: Icons.microwave),
      DeviceItem(name: 'Grinder',   channelName: 'CH 4', plug: 'Plug 2', icon: Icons.blender),
    ]),
  ]);

  List<DeviceItem> get allDevices => channels.value.expand((c) => c.devices).toList();

  // Scenes
  final ValueNotifier<List<SceneItem>> scenes = ValueNotifier([
    SceneItem(name: 'Party',   deviceCount: 4,  isOn: true),
    SceneItem(name: 'Outdoor', deviceCount: 12, isOn: false),
    SceneItem(name: 'Night',   deviceCount: 3,  isOn: false),
    SceneItem(name: 'Rainy',   deviceCount: 6,  isOn: true),
  ]);

  // Members
  final List<MemberItem> members = const [
    MemberItem(name: 'Aditya'),
    MemberItem(name: 'Naman'),
    MemberItem(name: 'Tina'),
    MemberItem(name: 'Atishay'),
  ];

  void addChannel(String name, {String room = 'New Room'}) {
    final existing = channels.value;
    if (existing.any((c) => c.name.toLowerCase() == name.toLowerCase())) return;
    channels.value = [...existing, ChannelItem(name: name, room: room, isOn: false)];
  }

  void toggleChannel(int index) {
    final list = List<ChannelItem>.from(channels.value);
    list[index] = list[index].copyWith(isOn: !list[index].isOn);
    channels.value = list;
  }

  void toggleDevice(String channelName, int deviceIndex) {
    final list = List<ChannelItem>.from(channels.value);
    final ci = list.indexWhere((c) => c.name == channelName);
    if (ci == -1) return;
    final devices = List<DeviceItem>.from(list[ci].devices);
    devices[deviceIndex] = devices[deviceIndex].copyWith(isOn: !devices[deviceIndex].isOn);
    list[ci] = list[ci].copyWith(devices: devices);
    channels.value = list;
  }

  void addDeviceToChannel(String channelName, DeviceItem device) {
    final list = List<ChannelItem>.from(channels.value);
    final ci = list.indexWhere((c) => c.name == channelName);
    if (ci == -1) return;
    final devices = [...list[ci].devices, device];
    list[ci] = list[ci].copyWith(devices: devices);
    channels.value = list;
  }

  void toggleScene(int index) {
    final list = List<SceneItem>.from(scenes.value);
    list[index].isOn = !list[index].isOn;
    scenes.value = List.from(list);
  }
}
