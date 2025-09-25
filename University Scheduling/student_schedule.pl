student_schedule(Student, Slots) :-
    setof(Course, studies(Student, Course), Courses),
    schedule_for_courses(Courses, Slots),
    no_clashes(Slots),
    study_days(Slots, 5).

schedule_for_courses([], []).
schedule_for_courses([Course|RestCourses], [slot(Day, SlotNum, Course)|RestSlots]) :-
    course_slot(Course, Day, SlotNum),
    schedule_for_courses(RestCourses, RestSlots).