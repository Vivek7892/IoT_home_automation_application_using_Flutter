import 'package:flutter/material.dart';

class ChannelItem {
  final String name;
  final String room;
  final int activeDevices;
  final int totalDevices;
  final bool isOn;

  const ChannelItem({
    required this.name,
    required this.room,
    required this.activeDevices,
    required this.totalDevices,
    required this.isOn,
  });

  ChannelItem copyWith({
    String? name,
    String? room,
    int? activeDevices,
    int? totalDevices,
    bool? isOn,
  }) {
    return ChannelItem(
      name: name ?? this.name,
      room: room ?? this.room,
      activeDevices: activeDevices ?? this.activeDevices,
      totalDevices: totalDevices ?? this.totalDevices,
      isOn: isOn ?? this.isOn,
    );
  }

  String get devicesLabel => '$activeDevices/$totalDevices Devices';
}

class ChannelStore {
  ChannelStore._();

  static final ChannelStore instance = ChannelStore._();

  final ValueNotifier<List<ChannelItem>> channels = ValueNotifier<List<ChannelItem>>([
    const ChannelItem(
      name: 'Migro_CH 1',
      room: 'Living Room',
      activeDevices: 4,
      totalDevices: 4,
      isOn: true,
    ),
    const ChannelItem(
      name: 'CH 2',
      room: 'Bed Room',
      activeDevices: 1,
      totalDevices: 4,
      isOn: true,
    ),
    const ChannelItem(
      name: 'CH 3',
      room: 'Bath Room',
      activeDevices: 1,
      totalDevices: 4,
      isOn: false,
    ),
    const ChannelItem(
      name: 'CH 4',
      room: 'Kitchen, Bath Room',
      activeDevices: 2,
      totalDevices: 4,
      isOn: true,
    ),
  ]);

  void addChannel({
    required String name,
    String room = 'New Room',
    int totalDevices = 4,
  }) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    final existing = channels.value;
    final alreadyExists = existing.any(
      (channel) => channel.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (alreadyExists) return;

    channels.value = [
      ...existing,
      ChannelItem(
        name: trimmed,
        room: room,
        activeDevices: 0,
        totalDevices: totalDevices,
        isOn: false,
      ),
    ];
  }

  void toggleChannelPower(int index) {
    final existing = channels.value;
    if (index < 0 || index >= existing.length) return;

    final updated = List<ChannelItem>.from(existing);
    final current = updated[index];
    updated[index] = current.copyWith(isOn: !current.isOn);
    channels.value = updated;
  }
}
