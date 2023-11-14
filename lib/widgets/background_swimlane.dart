import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/scroll_controller/scroll_controller.dart';
import 'package:driving_school_scheduler_panel/widgets/session_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class BackgroundSwimlanes extends StatelessWidget {
  double blockHeight;
  late SnapScrollController _controller;
  BackgroundSwimlanes(this.blockHeight, {super.key}) : _controller = SnapScrollController(blockHeight);

  @override
  Widget build(BuildContext context) {
    var schedulerDimensions = SchedulerData.of(context);

    var instructors = schedulerDimensions.setup.dataPoints;

    Provider.of<ScrollEventBus>(context).syncController(_controller, Axis.vertical);

    return ListView.separated(
      itemBuilder: (_, int index) {
        return Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment(0.045, .4),
                tileMode: TileMode.repeated,
                colors: <Color>[
                  Colors.transparent,
                  Colors.transparent,
                  Colors.grey.withOpacity(.14),
                  Colors.grey.withOpacity(.07),
                ],
                stops: <double>[0, .5, .5, 0],
              ),
            ),
            height: schedulerDimensions.blockSize.height,
            width: schedulerDimensions.swimlaneAbsoluteMaxWidth,
          ),
          InstructorSessionLine(instructors[index])
        ]);
      },
      separatorBuilder: (_, int index) => Divider(
        height: schedulerDimensions.cardSeparatorHeight,
        color: WidgetColors.GreyLight,
      ),
      itemCount: instructors.length,
      controller: _controller,
      scrollDirection: Axis.vertical,
    );
  }
}
