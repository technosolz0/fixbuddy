import 'package:fixbuddy/app/utils/extensions.dart';
import 'package:fixbuddy/app/utils/gotham_rounded.dart';
import 'package:fixbuddy/app/utils/theme.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.isDisabled = false,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: context.isLightTheme ? Clip.none : Clip.antiAlias,
      color: isSelected
          ? context.isLightTheme
                ? ThemeClass.primaryColorLight
                : const Color(0xff1B283D)
          : context.isLightTheme
          ? const Color(0xffFEFEFF)
          : Colors.white.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: context.isLightTheme && !isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [ThemeClass.lightBoxShadow],
                  color: const Color(0xffFEFEFF),
                )
              : null,
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: isSelected
                      ? null
                      : Border.all(
                          width: 2,
                          color: isDisabled
                              ? context.isLightTheme
                                    ? const Color(0xff060809).withOpacity(0.2)
                                    : Colors.white.withOpacity(0.6)
                              : context.isLightTheme
                              ? const Color(0xff060809).withOpacity(0.4)
                              : Colors.white,
                        ),
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: const Color(0xff1B283D),
                          size: 18,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(width: 5),
              Text(
                text,
                style: isSelected
                    ? GothamRounded.medium(
                        fontSize: 14,
                        color: context.isLightTheme ? Colors.white : null,
                      )
                    : GothamRounded.book(
                        fontSize: 14,
                        color: isDisabled
                            ? context.isLightTheme
                                  ? const Color(0xff060809).withOpacity(0.6)
                                  : Colors.white.withOpacity(0.6)
                            : context.isLightTheme
                            ? const Color(0xff060809).withOpacity(0.6)
                            : Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
