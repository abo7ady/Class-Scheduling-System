no_clashes([]).
no_clashes([slot(Day,Slot_number,_)|T]):-
\+member(slot(Day,Slot_number,_),T),no_clashes(T).