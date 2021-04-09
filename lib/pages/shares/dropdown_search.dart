library dropdown_search;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo_getx/pages/shares/popup_menu.dart';
import 'package:flutter_demo_getx/pages/shares/select_dialog.dart';
import 'package:flutter_demo_getx/utils/cast_object.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

typedef Future<List<T>> DropdownSearchOnFind<T>(String text, [num page]);
typedef String DropdownSearchItemAsString<T>(T item);
typedef bool DropdownSearchFilterFn<T>(T item, String filter);
typedef bool DropdownSearchCompareFn<T>(T item, T? selectedItem);
typedef Widget DropdownSearchBuilder<T>(
    BuildContext context, T? selectedItem, String itemAsString);
typedef Widget DropdownSearchPopupItemBuilder<T>(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef bool DropdownSearchPopupItemEnabled<T>(T item);
typedef Widget ErrorBuilder<T>(
    BuildContext context, String? searchEntry, dynamic exception);
typedef Widget EmptyBuilder<T>(BuildContext context, String? searchEntry);
typedef Widget LoadingBuilder<T>(BuildContext context, String? searchEntry);

enum Mode { DIALOG, BOTTOM_SHEET, MENU }
final double heightRowDefault = 28; // 50
final InputDecoration searchBoxDecorationDeaf = InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.fromLTRB(12, 0, 8, 0),
  labelText: "Tìm kiếm",
);
final shapeBorderDefault = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
  ),
);

class DropdownSearch<T> extends StatefulWidget {
  final String? labelPopupTitle;

  ///DropDownSearch label
  final String? label;

  ///DropDownSearch hint
  final String? hint;

  ///show/hide the search box
  final bool showSearchBox;

  ///true if the filter on items is applied onlie (via API)
  final bool isFilteredOnline;

  ///show/hide clear selected item
  final bool? showClearButton;

  ///offline items list
  final List<T>? items;

  ///selected item
  final T? selectedItem;

  ///function that returns item from API
  final DropdownSearchOnFind<T>? onFind;

  ///called when a new item is selected
  final ValueChanged<T?>? onChanged;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize selected item
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;

  ///decoration for search box
  final InputDecoration? searchBoxDecoration;

  ///the title for dialog/menu/bottomSheet
  final Color? popupBackgroundColor;

  ///custom widget for the popup title
  final Widget? popupTitle;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///enable/disable dropdownSearch
  final bool enabled;

  ///MENU / DIALOG/ BOTTOM_SHEET
  final Mode? mode;

  ///the max height for dialog/bottomSheet/Menu
  final double? maxHeight;

  ///the max width for the dialog
  final double? dialogMaxWidth;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItem;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  ///custom layout for empty results
  final EmptyBuilder? emptyBuilder;

  ///custom layout for loading items
  final LoadingBuilder? loadingBuilder;

  ///custom layout for error
  final ErrorBuilder? errorBuilder;

  ///the search box will be focused if true
  final bool autoFocusSearchBox;

  ///custom shape for the popup
  final ShapeBorder? popupShape;

  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<T>? onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<T>? validator;

  ///custom dropdown clear button icon widget
  final Widget? clearButton;

  ///custom dropdown icon button widget
  final Widget? dropDownButton;

  ///If true, the dropdownBuilder will continue the uses of material behavior
  ///This will be useful if you want to handle a custom UI only if the item !=null
  final bool dropdownBuilderSupportsNullItem;

  ///defines if an item of the popup is enabled or not, if the item is disabled,
  ///it cannot be clicked
  final DropdownSearchPopupItemEnabled<T>? popupItemDisabled;

  ///set a custom color for the popup barrier
  final Color? popupBarrierColor;

  ///text controller to set default search word for example
  final TextEditingController? searchBoxController;

  final double? heightRow;

  final bool isLoadmore;

  final bool? isFilter;

  DropdownSearch(
      {Key? key,
      this.onSaved,
      this.validator,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.onChanged,
      this.mode = Mode.BOTTOM_SHEET,
      this.label,
      this.hint,
      this.isFilteredOnline = false,
      this.popupTitle,
      this.items,
      this.selectedItem,
      this.onFind,
      this.dropdownBuilder,
      this.popupItemBuilder,
      this.showSearchBox = true,
      this.showClearButton = true,
      this.searchBoxDecoration,
      this.popupBackgroundColor,
      this.enabled = true,
      this.maxHeight,
      this.filterFn,
      this.itemAsString,
      this.showSelectedItem = true,
      this.compareFn,
      this.dropdownSearchDecoration,
      this.emptyBuilder,
      this.loadingBuilder,
      this.errorBuilder,
      this.autoFocusSearchBox = false,
      this.dialogMaxWidth,
      this.clearButton,
      this.dropDownButton,
      this.dropdownBuilderSupportsNullItem = false,
      this.popupShape,
      this.popupItemDisabled,
      this.popupBarrierColor,
      this.searchBoxController,
      this.heightRow,
      this.labelPopupTitle,
      this.isLoadmore = true,
      this.isFilter = false})
      : assert(!showSelectedItem || T == String || compareFn != null),
        super(key: key);

  @override
  DropdownSearchState<T> createState() => DropdownSearchState<T>();
}

class DropdownSearchState<T> extends State<DropdownSearch<T>> {
  final ValueNotifier<T?> _selectedItemNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);

  BehaviorSubject<bool> renderForm = BehaviorSubject<bool>();

  @override
  void initState() {
    super.initState();
    _selectedItemNotifier.value = widget.selectedItem;
    renderForm.add(false);
  }

  @override
  void dispose() {
    renderForm.drain();
    renderForm.stream.drain();
    renderForm.close();
    super.dispose();
  }

  DropdownSearchState() {
    renderForm = BehaviorSubject<bool>();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFilter!) _selectedItemNotifier.value = widget.selectedItem;
    return ValueListenableBuilder<T?>(
      valueListenable: _selectedItemNotifier,
      builder: (context, data, wt) {
        return IgnorePointer(
          ignoring: !widget.enabled,
          child: GestureDetector(
            onTap: () => _selectSearchMode(data),
            child: _formField(data),
          ),
        );
      },
    );
  }

  Widget _defaultSelectItemWidget(T? data) {
    return Container(
      height: widget.heightRow ?? heightRowDefault,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: widget.dropdownBuilder != null
                ? widget.dropdownBuilder!(
                    context,
                    data,
                    _selectedItemAsString(data),
                  )
                : Text(
                    _selectedItemAsString(data),
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          _manageTrailingIcons(data),
        ],
      ),
    );
  }

  Widget _formField(T? value) {
    return StreamBuilder(
        stream: renderForm.stream,
        builder: (context, snapshot) {
          return Container(
            height: (snapshot.hasData && cast<bool>(snapshot.data)!)
                ? ((widget.heightRow ?? heightRowDefault) + 22)
                : (widget.heightRow ?? heightRowDefault),
            child: FormField(
              enabled: widget.enabled,
              onSaved: widget.onSaved,
              validator: widget.validator,
              autovalidateMode: widget.autoValidateMode,
              initialValue: widget.selectedItem,
              builder: (FormFieldState<T> state) {
                if (state.value != value) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    state.didChange(value);
                  });
                }
                if (state.hasError) {
                  renderForm.add(true);
                } else {
                  renderForm.add(false);
                }
                return ValueListenableBuilder(
                    valueListenable: _isFocused,
                    builder: (context, bool isFocused, w) {
                      return InputDecorator(
                        isEmpty: value == null &&
                            (widget.dropdownBuilder == null ||
                                widget.dropdownBuilderSupportsNullItem),
                        isFocused: isFocused,
                        decoration: _manageDropdownDecoration(state),
                        child: _defaultSelectItemWidget(value),
                      );
                    });
              },
            ),
          );
        });
  }

  ///manage dropdownSearch field decoration
  InputDecoration _manageDropdownDecoration(FormFieldState state) {
    return (widget.dropdownSearchDecoration ??
        InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor('#b2b2b2'), width: 0.5),
          ),
          contentPadding: EdgeInsets.fromLTRB(12, -20, 0, 0),
        ).applyDefaults(Theme.of(state.context).inputDecorationTheme).copyWith(
            enabled: widget.enabled,
            labelText: widget.label,
            hintText: widget.hint,
            errorText: state.errorText));
  }

  ///function that return the String value of an object
  String _selectedItemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    } else {
      return data.toString();
    }
  }

  ///function that manage Trailing icons(close, dropDown)
  Widget _manageTrailingIcons(T? data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        (data != null && widget.showClearButton!)
            ? Container(
                height: 20,
                width: 30,
                alignment: Alignment.center,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: widget.clearButton ?? const Icon(Icons.clear, size: 18),
                  onPressed: () => _handleOnChangeSelectedItem(null),
                ),
              )
            : (data == null)
                ? Container(
                    height: 20,
                    width: 30,
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: widget.dropDownButton ??
                          const Icon(Icons.arrow_drop_down, size: 24),
                      onPressed: () => _selectSearchMode(data),
                    ),
                  )
                : Container(),
      ],
    );
  }

  ///open dialog
  Future<T?> _openSelectDialog(T? data) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 400),
      barrierColor: widget.popupBarrierColor ?? const Color(0x80000000),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: widget.popupShape ?? shapeBorderDefault,
          backgroundColor: widget.popupBackgroundColor,
          content: _selectDialogInstance(data),
        );
      },
    );
  }

  ///open BottomSheet (Dialog mode)
  Future<T?> _openBottomSheet(T? data) {
    return showModalBottomSheet<T>(
        barrierColor: widget.popupBarrierColor,
        isScrollControlled: true,
        backgroundColor: widget.popupBackgroundColor,
        shape: widget.popupShape ?? shapeBorderDefault,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: _selectDialogInstance(
                  data,
                  defaultHeight: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
            ),
          );
        });
  }

  ///openMenu
  Future<T?> _openMenu(T? data) {
    // Here we get the render object of our physical button, later to get its size & position
    final RenderBox popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
    final RelativeRect position = RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
    return customShowMenu<T>(
        barrierColor: widget.popupBarrierColor,
        shape: widget.popupShape,
        color: widget.popupBackgroundColor,
        context: context,
        position: position,
        elevation: 8,
        items: [
          CustomPopupMenuItem(
            enabled: false,
            child: Container(
              width: popupButtonObject.size.width,
              child: _selectDialogInstance(data, defaultHeight: 224),
            ),
          ),
        ]);
  }

  SelectDialog<T> _selectDialogInstance(T? data, {double? defaultHeight}) {
    return SelectDialog<T>(
      popupTitle: widget.popupTitle ?? _defaultPopupTitle(),
      maxHeight: widget.maxHeight ?? defaultHeight,
      isFilteredOnline: widget.isFilteredOnline,
      itemAsString: widget.itemAsString,
      filterFn: widget.filterFn,
      items: widget.items,
      onFind: widget.onFind,
      showSearchBox: widget.showSearchBox,
      itemBuilder: widget.popupItemBuilder,
      selectedValue: data,
      searchBoxDecoration:
          widget.searchBoxDecoration ?? searchBoxDecorationDeaf,
      onChanged: _handleOnChangeSelectedItem,
      showSelectedItem: widget.showSelectedItem,
      compareFn: widget.compareFn,
      emptyBuilder: widget.emptyBuilder,
      loadingBuilder: widget.loadingBuilder,
      errorBuilder: widget.errorBuilder,
      autoFocusSearchBox: widget.autoFocusSearchBox,
      dialogMaxWidth: widget.dialogMaxWidth,
      itemDisabled: widget.popupItemDisabled,
      searchBoxController:
          widget.searchBoxController ?? TextEditingController(),
      isLoadmore: widget.isLoadmore,
    );
  }

  Widget _defaultPopupTitle() {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      height: 50,
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 13,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          Align(
            child: Text(
              widget.labelPopupTitle ?? 'Tìm kiếm',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Function that manage focus listener
  ///set true only if the widget already not focused to prevent unnecessary build
  ///same thing for clear focus,
  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) _isFocused.value = false;
  }

  ///handle on change value , if the validation is active , we validate the new selected item
  void _handleOnChangeSelectedItem(T? selectedItem) {
    _selectedItemNotifier.value = selectedItem;
    if (widget.onChanged != null) widget.onChanged!(selectedItem);
    _handleFocus(false);
  }

  ///Function that return then UI based on searchMode
  ///[data] selected item to be passed to the UI
  ///If we close the popup , or maybe we just selected
  ///another widget we should clear the focus
  Future<T?> _selectSearchMode(T? data) async {
    _handleFocus(true);
    T? selectedItem;
    if (widget.mode == Mode.MENU) {
      selectedItem = await _openMenu(data);
    } else if (widget.mode == Mode.BOTTOM_SHEET) {
      selectedItem = await _openBottomSheet(data);
    } else {
      selectedItem = await _openSelectDialog(data);
    }
    _handleFocus(false);

    return selectedItem;
  }

  ///Public Function that return then UI based on searchMode
  ///[data] selected item to be passed to the UI
  ///If we close the popup , or maybe we just selected
  ///another widget we should clear the focus
  ///THIS USED FOR OPEN DROPDOWN_SEARCH PROGRAMMATICALLY,
  ///otherwise you can you [_selectSearchMode]
  Future<T?> openDropDownSearch() =>
      _selectSearchMode(_selectedItemNotifier.value);

  ///Change selected Value; this function is public USED to change the selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItem]
  void changeSelectedItem(T selectedItem) =>
      _handleOnChangeSelectedItem(selectedItem);

  ///Change selected Value; this function is public USED to clear selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItem]
  void clear() => _handleOnChangeSelectedItem(null);

  ///get selected value programmatically
  T? get getSelectedItem => _selectedItemNotifier.value;

  ///check if the dropdownSearch is focused
  bool get isFocused => _isFocused.value;
}
