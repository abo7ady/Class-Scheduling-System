:- consult('publicKB').

university_schedule(S) :-
    setof(Student, Course^studies(Student, Course), Students),
    uni_total(Students, S).

uni_total([], []).
uni_total([Student|Rest], [sched(Student, Schedule)|RestSchedules]) :-
    student_schedule(Student, Schedule),
    uni_total(Rest, RestSchedules).


student_schedule(Student, Slots) :-
    setof(Course, studies(Student, Course), Courses),
    schedule_for_courses(Courses, Slots),
    no_clashes(Slots),
    study_days(Slots, 5).

schedule_for_courses([], []).
schedule_for_courses([Course|RestCourses], [slot(Day, SlotNum, Course)|RestSlots]) :-
    course_slot(Course, Day, SlotNum),
    schedule_for_courses(RestCourses, RestSlots).

no_clashes([]).
no_clashes([slot(Day,Slot_number,_)|T]):-
\+member(slot(Day,Slot_number,_),T),no_clashes(T).


study_days(Slots, DayCount) :-
    findall(Day, member(slot(Day, _, _), Slots), Days), 
    sort(Days, UniqueDays),
    length(UniqueDays, N), 
    N =< DayCount.

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

