import 'package:driving_school_scheduler_panel/constants/colors.dart';
import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/scroll_controller/scroll_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftAvatarWrapper extends StatelessWidget {
  final ScrollController _localController = ScrollController();

  LeftAvatarWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ScrollEventBus>(context).syncController(_localController, Axis.vertical);
    var data = SchedulerData.of(context);

    return SizedBox(
      width: data.leftPanelWidth,
      height: data.preferredInnerHeight,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          itemBuilder: (_, int index) => InstructorWidget(data.setup.dataPoints[index]),
          separatorBuilder: (_, int index) => Divider(
            height: data.cardSeparatorHeight,
            color: WidgetColors.GreyLight,
          ),
          itemCount: data.setup.dataPoints.length,
          controller: _localController,
        ),
      ),
    );
  }
}

class InstructorWidget extends StatelessWidget {
  final DataPoint dataPoint;
  InstructorWidget(this.dataPoint);
  @override
  Widget build(BuildContext context) {
    var data = SchedulerData.of(context);

    return Container(
      height: data.blockSize.height,
      width: data.leftPanelWidth,
      // margin: EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: data.blockSize.height * 0.1),
          SizedBox(
            height: data.blockSize.height * 0.6,
            child: Center(
              child: dataPoint.image,
            ),
          ),
          SizedBox(
            height: data.blockSize.height * 0.3,
            child: Center(
              child: Text(
                dataPoint.label,
                style: TextStyle(color: WidgetColors.Primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
