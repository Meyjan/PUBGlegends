:- dynamic(map/3).

/* Rules */
drawMap(12,12,Timer) :- print('X'), nl, !.
drawMap(Row,Col,Timer) :-
  (Row > 1, Col > 1, Row < 12, Col < 12, print('- '), !, NextCol is Col+1, map(Row,NextCol,Timer),!);
  (Row =< 1, Col < 12, print('X '), !, NextCol is Col+1, map(Row,NextCol,Timer),!);
  (Row =< 1, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, map(NextRow,NextCol,Timer),!);
  (Row >= 12, Col < 12, print('X '), !, NextCol is Col+1, map(Row,NextCol,Timer),!);
  (Row > 1, Col =< 1, print('X '), !, NextCol is Col+1, map(Row,NextCol,Timer), !);
  (Row > 1, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, map(NextRow,NextCol,Timer),!).
