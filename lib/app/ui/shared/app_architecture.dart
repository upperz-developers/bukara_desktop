import 'package:bukara/app/ui/shared/style.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ArchitectureApp extends StatefulWidget {
  final List<Widget> items;
  final Color? menuBackgroundColor;
  final Widget? header;
  final List<Widget>? footer;
  final Widget? content;
  final Function()? onTap;
  const ArchitectureApp({
    Key? key,
    required this.items,
    this.menuBackgroundColor,
    this.header,
    this.footer,
    required this.content,
    this.onTap,
  }) : super(key: key);

  @override
  State<ArchitectureApp> createState() => _ArchitectureAppState();
}

class _ArchitectureAppState extends State<ArchitectureApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 85,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.header != null) widget.header!,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.items,
                    ),
                  ),
                ),
                if (widget.footer != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.footer!,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
              ),
              child: widget.content!,
            ),
          ),
        ],
      ),
    );
  }
}
