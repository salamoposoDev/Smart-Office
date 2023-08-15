import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_office/home_page/widgets/pill_item.dart';
import 'package:smart_office/riverpod/riverpod.dart';

class TabbarList extends ConsumerStatefulWidget {
  const TabbarList({
    super.key,
    required this.onChanged,
  });
  final void Function(int index) onChanged;

  @override
  ConsumerState<TabbarList> createState() => _TabbarListState();
}

class _TabbarListState extends ConsumerState<TabbarList> {
  int selectedIndex = 0;
  final rooms = ['R. Tamu', 'Teras'];
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(rooms.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onChanged(selectedIndex);
                ref.read(selectedPathProviders.notifier).state =
                    selectedIndex != 0 ? 'relay' : 'dimmer';
              },
              child: PillItem(
                text: rooms[index],
                isSelected: selectedIndex == index ? true : false,
              ),
            ),
          );
        }));
  }
}
