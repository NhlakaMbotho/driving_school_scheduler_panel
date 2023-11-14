import 'package:driving_school_scheduler_panel/constants/colors.dart';
import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/scroll_controller/scroll_controller.dart';
import 'package:driving_school_scheduler_panel/widgets/main_panel.dart';
import 'package:driving_school_scheduler_panel/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SchedulerWidget extends StatelessWidget {
  final SchedulerSetup _setup;

  const SchedulerWidget(SchedulerSetup setup, {super.key}) : _setup = setup;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SchedulerData(
          constraints: constraints,
          setup: _setup,
          child: Provider(
            create: (context) => ScrollEventBus(),
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
                  MiddlePanel()
                  // Footer()
                ],
              ),
            ),
          ),
        );
      },
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
          MainPanel(
            blockWidth: data.blockSize.width,
          ),
          // RightScrollBar(),
        ],
      ),
    );
  }
}
