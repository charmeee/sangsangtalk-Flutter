import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post_model.dart';
import '../provider/menu_option_provider.dart';

class MenuOptionSelectBox extends ConsumerWidget {
  const MenuOptionSelectBox({
    Key? key,
    required this.isRadio,
    required this.selectedOptions,
    required this.optionGroup,
    required this.index,
  }) : super(key: key);
  final bool isRadio;
  final List<MenuOption> selectedOptions;
  final MenuOptionGroup optionGroup;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectIcon =
        isRadio ? Icons.radio_button_checked : Icons.check_box_outlined;
    final unSelectIcon =
        isRadio ? Icons.radio_button_unchecked : Icons.check_box_outline_blank;
    MenuOption menuOption = optionGroup.options[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  ref
                      .read(menuOptionNotifierProvider.notifier)
                      .setOption(isRadio, optionGroup.id, menuOption);
                },
                icon: Icon(selectedOptions
                        .any((element) => element.id == menuOption.id)
                    ? selectIcon
                    : unSelectIcon)),
            Text(menuOption.name),
          ],
        ),
        Text('${menuOption.price}원'),
      ],
    );
  }
}
