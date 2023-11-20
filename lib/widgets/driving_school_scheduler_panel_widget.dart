import 'package:driving_school_scheduler_panel/constants/colors.dart';
import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/scroll_controller/scroll_controller.dart';
import 'package:driving_school_scheduler_panel/widgets/main_panel.dart';
import 'package:driving_school_scheduler_panel/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SchedulerWidget extends StatelessWidget {
  final SchedulerSetup _setup;

  const SchedulerWidget({required SchedulerSetup setup, super.key}) : _setup = setup;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ScrollEventBus())],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SchedulerData(
            constraints: constraints,
            setup: _setup,
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                color: WidgetColors.GreyLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  const MiddlePanel()
                  // Footer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MiddlePanel extends StatelessWidget {
  const MiddlePanel({super.key});

  @override
  Widget build(BuildContext context) {
    var data = SchedulerData.of(context);

    return SizedBox(
      height: data.preferredInnerHeight,
      child: Row(
        children: [
          LeftAvatarWrapper(),
          Center(
            child: MainPanel(
              blockWidth: data.blockSize.width,
            ),
          ),
          // RightScrollBar(),
        ],
      ),
    );
  }
}
