import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/scroll_controller/scroll_controller.dart';
import 'package:driving_school_scheduler_panel/widgets/background_swimlane.dart';
import 'package:driving_school_scheduler_panel/widgets/time_stamp_guidelines.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPanel extends StatefulWidget {
  late final SnapScrollController horizontalController;

  MainPanel({
    required double blockWidth,
  }) {
    horizontalController = SnapScrollController(blockWidth);
  }

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  dispose() {
    Provider.of<ScrollEventBus>(context).dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<ScrollEventBus>(context).syncController(widget.horizontalController, Axis.horizontal);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var schedulerDimensions = SchedulerData.of(context);

    return SizedBox(
      width: schedulerDimensions.preferredInnerWidth,
      height: schedulerDimensions.preferredInnerHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.down,
        controller: widget.horizontalController,
        child: SizedBox(
          height: schedulerDimensions.preferredInnerHeight,
          width: schedulerDimensions.swimlaneAbsoluteMaxWidth,
          child: Stack(
            children: [
              const TimestampGuideLines(),
              BackgroundSwimlanes(schedulerDimensions.blockSize.height + schedulerDimensions.cardSeparatorHeight),
            ],
          ),
        ),
      ),
    );
  }
}
