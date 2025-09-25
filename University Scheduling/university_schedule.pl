university_schedule(S) :-
    setof(Student, Course^studies(Student, Course), Students),
    uni_total(Students, S).

uni_total([], []).
uni_total([Student|Rest], [sched(Student, Schedule)|RestSchedules]) :-
    student_schedule(Student, Schedule),
    uni_total(Rest, RestSchedules).


