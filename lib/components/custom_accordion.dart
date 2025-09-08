import 'package:capsule_apps/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomAccordion extends StatefulWidget {
  final Widget title;
  final Widget? header;
  final Widget? widgets;
  final bool? defaultShow;

  const CustomAccordion({
    super.key,
    required this.title,
    this.header,
    this.widgets,
    this.defaultShow,
  });
  @override
  CustomAccordionState createState() => CustomAccordionState();
}

class CustomAccordionState extends State<CustomAccordion> {
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _showContent = widget.defaultShow ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.header ?? Container(),
                  const SizedBox(height: kPaddingSmall),
                  Row(
                    children: [
                      Expanded(child: widget.title),
                      Row(
                        children: [
                          Icon(
                            (_showContent
                                ? Icons.expand_less
                                : Icons.expand_more),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _showContent ? widget.widgets ?? Container() : Container(),
        ],
      ),
    );
  }
}
