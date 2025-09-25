study_days(Slots, DayCount) :-
    findall(Day, member(slot(Day, _, _), Slots), Days), 
    sort(Days, UniqueDays),
    length(UniqueDays, N), 
    N =< DayCount.