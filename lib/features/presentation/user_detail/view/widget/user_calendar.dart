import 'dart:async';

import 'package:flutter/material.dart';

class UserCalendar extends StatefulWidget {
  const UserCalendar({super.key});

  @override
  State<UserCalendar> createState() => _UserCalendarState();
}

class _UserCalendarState extends State<UserCalendar> with WidgetsBindingObserver {
  late DateTime _today;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _today = DateUtils.dateOnly(DateTime.now());
    _scheduleUpdate();
  }

  void _scheduleUpdate() {
    _timer?.cancel();

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final untilMidnight = midnight.difference(now);

    final delay = untilMidnight < const Duration(minutes: 1)
        ? untilMidnight : const Duration(minutes: 1);

    _timer = Timer(delay, _updateToday);
  }

  void _updateToday() {
    if (!mounted) return;

    final today = DateUtils.dateOnly(DateTime.now());

    if (!DateUtils.isSameDay(today, _today)) {
      setState(() {
        _today = today;
      });
    }

    _scheduleUpdate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateToday();
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(_today.year, _today.month, 1);
    final daysInMonth = DateTime(
      _today.year,
      _today.month + 1,
      0
    ).day;

    final leadingEmptyDays = firstDay.weekday - 1;
    final totalCells = ((leadingEmptyDays + daysInMonth + 6) ~/ 7) * 7;

    const weekdays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tháng ${_today.month}/${_today.year}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16,),
            Row(
              children: weekdays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12,),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                mainAxisExtent: 44,
              ),
              itemCount: totalCells,
              itemBuilder: (context, index) {
                final day = index - leadingEmptyDays + 1;

                if (day < 1 || day > daysInMonth) {
                  return const SizedBox.shrink();
                }
                final isToday = day == _today.day;

                return Semantics(
                  label:
                      '$day/${_today.month}/${_today.year}'
                      '${isToday ? ", hôm nay" : ""}',
                  excludeSemantics: true,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isToday
                          ? Colors.green.shade700
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$day',
                      style: TextStyle(
                        color: isToday
                            ? Colors.white
                            : colors.onSurface,
                        fontWeight: isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12,),
            Text(
              'Hôm nay: ${_today.day}/${_today.month}/${_today.year}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}