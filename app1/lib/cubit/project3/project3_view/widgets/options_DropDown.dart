import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LangDropdown extends StatelessWidget {
  LangDropdown({Key? key}) : super(key: key);

  final ValueNotifier<categoryModelItem?> _itemNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _itemNotifier,
      builder: (context, value, child) {
        return DropdownButton<categoryModelItem>(
          value: _itemNotifier.value,
   
          items: categoryModelItem.samples.map((e) {
            return DropdownMenuItem<categoryModelItem>(
              child:  _Dropdown_cardItem(e),
              value: e,
            );
          }).toList(),
          onChanged: (value) {
            _itemNotifier.value = value;
          },
        );
      },
    );
  }
}


class _Dropdown_cardItem extends StatelessWidget {
  const _Dropdown_cardItem(this.item);
  final categoryModelItem item;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(item.icon),
          const SizedBox(
            width: 10,
          ),
          Text(item.title),
        ],
      ),
    );
  }
}

class categoryModelItem extends Equatable {
  final String title;
  final IconData icon;

  categoryModelItem({required this.icon, required this.title});
  static final List<categoryModelItem> samples = [
    categoryModelItem(icon: Icons.sports, title: 'spor'),
    categoryModelItem(icon: Icons.face, title: 'sanat'),
  ];

  @override
  List<Object?> get props => [icon, title];
}
