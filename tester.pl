/* Deklarasi Fakta */


drawMap(12,12,Timer) :- print('X'), nl, !.
drawMap(Row,Col,Timer) :- 
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col > Min, Row < Max, Col < Max, print('- '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row >= Max, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col =< Min, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer), !);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol,Timer),!).

