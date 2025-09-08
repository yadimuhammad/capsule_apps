import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomAppbar extends AppBar {
  final String? titles;
  final bool? centeredTitle;
  final List<Widget>? action;
  final double? height;
  final Widget? widgetLeading;
  final Color? fgColor;
  final Color? bgColor;
  final double? elevations;
  final bool? search;
  final bool? autoImplyLeading;
  final Widget? widgets;
  final bool? isGradient;
  final Color? titleColor;
  final bool? noImage;
  @override
  // ignore: overridden_fields
  PreferredSizeWidget? bottom;

  CustomAppbar({
    this.titles,
    this.centeredTitle,
    this.action,
    this.widgetLeading,
    this.height,
    this.fgColor,
    this.bgColor,
    this.elevations,
    this.search,
    this.autoImplyLeading,
    this.widgets,
    this.isGradient,
    this.titleColor,
    this.bottom,
    this.noImage,
    super.key,
  }) : super(
         backgroundColor: isGradient == true
             ? Colors.transparent
             : (bgColor ?? Theme.of(Get.context!).colorScheme.primary),
         toolbarHeight: height ?? kToolbarHeight,
         leading: widgetLeading,
         surfaceTintColor: Colors.transparent,
         iconTheme: IconThemeData(
           color: fgColor ?? Theme.of(Get.context!).colorScheme.surface,
           size: 30,
         ),
         title: titles != null
             ? Text(titles, style: Theme.of(Get.context!).textTheme.titleMedium)
             : widgets,
         flexibleSpace: isGradient == true
             ? Container(
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                     colors: <Color>[
                       Colors.black.withValues(alpha: 0.8),
                       Colors.transparent,
                     ],
                   ),
                 ),
               )
             : noImage == true
             ? Container()
             : Container(),
         //  : const Image(
         //      image: AssetImage(kImageBgAppbar),
         //      fit: BoxFit.cover,
         //    ),
         elevation: elevations ?? 0.0,
         centerTitle: centeredTitle ?? true,
         automaticallyImplyLeading: autoImplyLeading ?? true,
         actions: action,
         foregroundColor: fgColor ?? Theme.of(Get.context!).colorScheme.surface,
         bottom: bottom,
       );
}
