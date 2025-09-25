assembly_hours(Schedules, AH) :-
    findall(FreeSlots, (
        member(Sched, Schedules),
        free_slots_sched(Sched, FreeSlots)
    ), AllFreeSlots),
    common_free(AllFreeSlots, AH).

free_slots_sched(sched(_, Slots), FreeSlots) :-
    findall(Day, member(slot(Day, _, _), Slots), Days),
    sort(Days, StudyDays),
    free_slots_for_days(StudyDays, Slots, FreeSlots).

free_slots_for_days([], _, []).
free_slots_for_days([Day|RestDays], Slots, FreeSlots) :-
    findall(SlotNum, member(slot(Day, SlotNum, _), Slots), Used),
    AllSlots = [1,2,3,4,5],
    subtract(AllSlots, Used, FreeNums),
    findall(slot(Day, Num), member(Num, FreeNums), FreeForDay),
    free_slots_for_days(RestDays, Slots, FreeRest),
    append(FreeForDay, FreeRest, FreeSlots).

common_free([Set], Set).
common_free([Set1, Set2 | Rest], Common) :-
    intersection(Set1, Set2, TempCommon),
    common_free([TempCommon | Rest], Common).

course_slot(Course, Day, SlotNum) :-
    day_schedule(Day, Slots),
    nth1(SlotNum, Slots, SlotCourses),
    member(Course, SlotCourses).