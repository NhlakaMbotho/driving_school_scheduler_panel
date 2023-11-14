import 'package:driving_school_scheduler_panel/constants/colors.dart';
import 'package:driving_school_scheduler_panel/models/models.dart';
import 'package:driving_school_scheduler_panel/scroll_controller/scroll_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchedulerTimeStamp extends StatelessWidget {
  final int hour;
  const SchedulerTimeStamp(this.hour, {super.key});

  get formattedTime {
    return hour < 10 ? '0$hour:00' : '$hour:00';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: WidgetColors.Primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(6.0),
              ),
            ),
            height: constraints.maxHeight * 0.6,
            width: constraints.maxWidth * 0.4,
            child: Center(
              child: Text(
                '$formattedTime',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                  fontWeight: FontWeight.w100,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          )
        ],
      );
    }));
  }
}

class Header extends StatelessWidget {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var dimensions = SchedulerData.of(context);
    Provider.of<ScrollEventBus>(context).syncController(controller, Axis.horizontal);
    return Container(
      height: dimensions.topPanelHeight,
      width: dimensions.preferredInnerWidth,
      margin: EdgeInsets.only(
        left: dimensions.leftPanelWidth,
        right: dimensions.rightPanelWidth,
      ),
      child: ListView.separated(
        itemBuilder: (_, index) => SizedBox(
          width: dimensions.blockSize.width,
          height: dimensions.topPanelHeight,
          child: SchedulerTimeStamp(dimensions.setup.startHour + index),
        ),
        separatorBuilder: (_, index) => const Divider(),
        itemCount: dimensions.setup.maxHourCount,
        controller: controller,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
