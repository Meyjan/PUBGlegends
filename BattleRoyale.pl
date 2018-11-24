/* Nama Kelompok	: Fortnite > PUBG */
/* NIM/Nama			  : 13517020/T. Antra Oksidian Tafly, 13517059/Nixon Andhika, 13517131/Jan Meyer Saragih, 13517137/Vincent Budianto */
/* Nama file		  : BattleRoyale.pl */
/* Topik			    : Tugas Besar IF2121 - Logika Informatika */
/* Tanggal			  : 21 November 2018 */
/* Deskripsi		  : Membuat permainan battle royale menggunakan prolog */

/* Implementasi fungsi execute */
execute(help) :- help, nl, !.
execute(half):- half,!.
execute(print_health):- print_health, !.
execute(print_location):- print_location, !.
execute(print_armor):- print_armor, !.
execute(deadzone_hit) :- deadzone_hit, !.
execute(quit) :- quit, nl, !.
execute(look) :- look, nl, !.
execute(map) :- drawMap(1,1), nl, !.
execute(n) :- n, nl, !.
execute(s) :- s, nl, !.
execute(e) :- e, nl, !.
execute(w) :- w, nl, !.
execute(take(Object)) :- take(Object), nl, !.
execute(drop(Object)) :- drop(Object), nl, !.
execute(use(Object)) :- use(Object), nl, !.
execute(attack) :- help, nl, !.
execute(status) :- status, nl, !.
/*execute(save(file)) :- save(file), nl, !.
execute(load(file)) :- load(file), nl, !. */
execute(_) :- write('Invalid command. Please try again.'), nl.

/* Syarat game beres */
win :- enemy_count(X), X == 0, write('Congratulations, Winner Winner Chicken Dinner!'), nl, quit, !.
lose :-
(health == 0, write('Your health reaches 0. No Chicken dinner for you!'), nl, !);
(deadzone_hit, write('You are in the deadzone. You died pitifully. No Chicken dinner for you!'), nl, !).
quit :- retractall(location(X,_Y)), retractall(inventory(X)), nl, nl, !, credit.

/* Deklarasi Fakta */
location(4,4,6,6,karnakTemple).
location(2,2,6,6,openField).
location(7,4,9,6,lostCityOfIram).
location(7,2,11,6,desert).
location(4,7,6,9,cuevaDelDiablo).
location(2,7,6,11,jungle).
location(7,7,9,9,miltaTemple).
location(7,7,11,11,mountain).

/* weapon(X,Y) : Senjata X dapat menampung Y peluru*/
weapon(m16,30).
weapon(rpg7,2).

/* armor(X,Y) : Armor X memiliki Y endurance */
armor(jacket,30).
armor(vest,60).

/* ammo(X,Y) : Senjata X menggunakan ammo Y */
ammo(m16,rifleammo).
ammo(rpg7,rocket).

/* aidkit(X,Y) : Aidkit X menambah Y health */
aidkit(drink,20).
aidkit(bandage,50).

/* item(X,Y) : Item Y bertipe X */
type(weapon,m16).
type(weapon,rpg7).
type(armor,jacket).
type(armor,vest).
type(ammo,rifleammo).
type(ammo,rocket).
type(aidkit,drink).
type(aidkit,bandage).

/* ID(X,Y) : Item X ber-ID Y */
iD(m16,1).
iD(rpg7,2).
iD(jacket,3).
iD(vest,4).
iD(rifleammo,5).
iD(rocket,6).
iD(drink,7).
iD(bandage,8).

/* Variabel Dinamik */
:- dynamic(player_location/2).
:- dynamic(player_health/1).
:- dynamic(player_armor/1).
:- dynamic(player_weapon/1).
:- dynamic(player_ammo/1).
:- dynamic(item_location/3).
:- dynamic(item_list/1).
:- dynamic(enemy_list/1).
:- dynamic(inventory/1).
:- dynamic(drawMap/2).
:- dynamic(enemy_count/1).
:- dynamic(timer/1).

/* Deklarasi Rule */
dynamic_facts :-
retractall(player_location(_X,_Y)),
retractall(player_health(_X)),
retractall(player_armor(_X)),
retractall(player_weapon(_X)),
retractall(player_ammo(_X)),
retractall(inventory([_A, _B, _C, _D, _E])),
retractall(item_location(_ID,_X,_Y)),
retractall(item_list([_H|_T])),
retractall(enemy_count(_X)),
retractall(timer(_X)).

/* Fakta untuk kondisi awal */
player_health(_X).
player_armor(_X).
player_ammo(_X).
player_location(_X,_Y).
player_weapon(_X).
enemy_count(_X).
timer(_X).
inventory([_A, _B, _C, _D, _E]).
item_list([_H|_T]).
enemy_list([_H|_T]).
item_location(_ID,_X,_Y).

/* Inisialisasi Game */
initialize_game :-
assertz(player_health(100)),
assertz(player_armor(0)),
random(10,20,Z),
assertz(enemy_count(Z)),
random(2,11,X),
random(2,11,Y),
assertz(player_location(X,Y)),
assertz(player_weapon(0)),
assertz(inventory([0, 0, 0, 0, 0])),
assertz(timer(0)),
assertz(item_list([])),
assertz(enemy_list([])),
spawnItems,
spawnEnemy.

/*-------Debugging----------*/
half :-
enemy_count(X),
Y is div(X,2),
retractall(enemy_count(X)),
assertz(enemy_count(Y)).

/*--------------------*/

/* Loop agar game tetap berjalan */
game :-
repeat,
timer(Y),
addItem,
enemy_list(B),
print(B),
nl,
item_list(A),
print(A),
nl,
drawMap(1,1),
nl,
write(' Deadzone approaching in '), Z is 10 - (Y mod 10), write(Z), write(' move'),
nl,
enemymove,
nl,
write(' << Command >> '),
read(X),
execute(X),
Y1 is Y + 1,
retractall(timer(Y)),
assertz(timer(Y1)),
(win; lose; X==quit), !.

/* start() : memulai permainan, menampilkan judul dan instruksi permainan */
start :-
write('  _____   _    _  ____    _____  _                                _       '), nl,
write(' |  __ \\ | |  | ||  _ \\  / ____|| |                              | |      '), nl,
write(' | |__) || |  | || |_) || |  __ | |  ___   __ _   ___  _ __    __| | ___  '), nl,
write(' |  ___/ | |  | ||  _ < | | |_ || | / _ \\ / _` | / _ \\| `_ \\  / _` |/ __| '), nl,
write(' | |     | |__| || |_) || |__| || ||  __/| (_| ||  __/| | | || (_| |\\__ \\'), nl,
write(' |_|      \\____/ |____/  \\_____||_| \\___| \\__, | \\___||_| |_| \\__ _||___/ '), nl,
write('                                           __/ |                          '), nl,
write('                                          |___/                           '), nl,
write(' Welcome to PUBG Legends! '), nl,
write(' To see all the command, type help'), nl,
write(' Deploying in T-5 second '), nl,
write(' 5...'), nl,
/*sleep(1), write(' 4...'), nl,
sleep(1), write(' 3...'), nl,
sleep(1), write(' 2...'), nl,
sleep(1), write(' 1...'), nl,
sleep(1), write(' Deploying and opening parachute '), nl,
sleep(1), write(' You landed safely. Kill all enemies '), nl, nl,
sleep(2),*/
dynamic_facts,
initialize_game,
game.

/* help() : menampilkan fungsi-fungsi yang dapat dipanggil dalam permainan, dapat mengandung informasi lain yang mungkin dibutuhkan */
help :-
nl,
write(' start.            --   start the game! '), nl,
write(' help.             --   show available commands '), nl,
write(' quit.             --   quit the game '), nl,
write(' look.             --   look around you '), nl,
write(' n.                --   move north '), nl,
write(' s.                --   move south '), nl,
write(' e.                --   move east '), nl,
write(' w.                --   move west '), nl,
write(' map               --   look at the map and detect enemies '), nl,
write(' take(Object).     --   pick up an object '), nl,
write(' drop(Object).     --   drop an object '), nl,
write(' use(Object).      --   use an object '), nl,
write(' attack.           --   attack enemy that crosses your path '), nl,
write(' status.           --   show your status '), nl,
write(' save(Filename).   --   save your game '), nl,
write(' load(Filename).   --   load previously saved game '), nl, nl,
write(' Legends: '), nl,
write(' W = weapon '), nl,
write(' A = armor  '), nl,
write(' M = medicine  '), nl,
write(' O = ammo  '), nl,
write(' P = player  '), nl,
write(' E = enemy  '), nl,
write(' - = accessible  '), nl,
write(' X = inaccessible '),
sleep(5).

/* credit() : tampilan credit */
credit :-
write('  _______  _    _            _   _  _  __  __     __ ____   _    _  '), nl,
write(' |__   __|| |  | |    /\\    | \\ | || |/ /  \\ \\   / // __ \\ | |  | | '), nl,
write('    | |   | |__| |   /  \\   |  \\| || \' /    \\ \\_/ /| |  | || |  | | '), nl,
write('    | |   |  __  |  / /\\ \\  | . ` ||  <      \\   / | |  | || |  | | '), nl,
write('    | |   | |  | | / ____ \\ | |\\  || . \\      | |  | |__| || |__| | '), nl,
write('    |_|   |_|  |_|/_/    \\_\\|_| \\_||_|\\_\\     |_|   \\____/  \\____/  '), nl,
write('____________________________________________________________________'), nl,
write('                                                                    '), nl,
write('                               CREDIT                               '), nl,
write('                                                                    '), nl,
write('                 13517020 - T. Antra Oksidian Tafly                 '), nl,
write('                      13517059 - Nixon Andhika                      '), nl,
write('                    13517131 - Jan Meyer Saragih                    '), nl,
write('                    13517137 - Vincent Budianto                     '), nl,
sleep(2), halt.

/* look() : menuliskan petak-petak 3x3 di sekitar pemain dengan posisi pemain saat ini menjadi center */
look :- lookItem.

/* n : menggerakkan pemain satu petak ke arah utara  */
n :-
(player_location(X,Y), factor(Min,Max), Z is Y - 1, Z =< Min, write(' Invalid move'), !);
(player_location(X,Y), factor(Min,Max), Z is Y - 1, Z > Min, retractall(player_location(X,Y)), assertz(player_location(X,Z)), print_location, !).

/* e : menggerakkan pemain satu petak ke arah timur */
e :-
(player_location(X,Y), factor(Min,Max), Z is X + 1, Z >= Max, write(' Invalid move'), !);
(player_location(X,Y), factor(Min,Max), Z is X + 1, Z < Max, retractall(player_location(X,Y)), assertz(player_location(Z,Y)), print_location, !).

/* s : menggerakkan pemain satu petak ke arah selatan */
s :-
(player_location(X,Y), factor(Min,Max), Z is Y + 1, Z >= Max, write(' Invalid move'), !);
(player_location(X,Y), factor(Min,Max), Z is Y + 1, Z < Max, retractall(player_location(X,Y)), assertz(player_location(X,Z)), print_location, !).

/* w : menggerakkan pemain satu petak ke arah barat */
w :-
(player_location(X,Y), factor(Min,Max), Z is X - 1, Z =< Min, write(' Invalid move'));
(player_location(X,Y), factor(Min,Max), Z is X - 1, Z > Min, retractall(player_location(X,Y)), assertz(player_location(Z,Y)), print_location).

/* print_location : menuliskan lokasi utara, timur, selatan, dan barat dari posisi player setelah bergerak */
print_location :-
nl, player_location(X,Y), write(' You are in '), print_location2(X,Y),
A is Y - 1, write(' To the north is '), print_location2(X,A),
B is X + 1, write(' To the east is '), print_location2(B,Y),
C is Y + 1, write(' To the south is '), print_location2(X,C),
D is X - 1, write(' To the west is '), print_location2(D,Y).

/* print_location2(X,Y) : menuliskan nama lokasi dari posisi (X,Y) */
print_location2(X,Y):- factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, !, location(A,B,C,D,Loc), X>=A, Y>=B, X=<C, Y=<D, !, write(Loc), nl, !.
print_location2(_,_):- write('dead zone'), nl, !.

/* drawMap(X,Y) : memperlihatkan seluruh peta permainan dengan menunjukkan petak deadzone dan petak safezone, serta lokasi pemain */
drawMap(12,12) :- print('X'), nl, !.
drawMap(Row,Col) :-
(player_location(X,Y), Row == Y, Col == X, factor(Min,Max), Row > Min, Col > Min, Row < Max, Col < Max, print('P '), !, NextCol is Col+1, drawMap(Row,NextCol),!);
(factor(Min,Max), Row > Min, Col > Min, Row < Max, Col < Max, print('- '), !, NextCol is Col+1, drawMap(Row,NextCol),!);
(factor(Min,Max), Row =< Min, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol),!);
(factor(Min,Max), Row =< Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol),!);
(factor(Min,Max), Row =< Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol),!);
(factor(Min,Max), Row >= Max, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol),!);
(factor(Min,Max), Row > Min, Col =< Min, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol), !);
(factor(Min,Max), Row > Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol),!);
(factor(Min,Max), Row > Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol),!).

/* factor(X,Y) : faktor untuk penentu deadzone saat timer dijalankan */
factor(Min,Max) :- (timer(Timer), Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor)).

/* deadzone_hit: mengecek apakah player berada di deadzone */
deadzone_hit :-
(player_location(X, Y), factor(Min, Max), X =< Min,!);
(player_location(X, Y), factor(Min, Max), X >= Max,!);
(player_location(X, Y), factor(Min, Max), Y >= Max,!);
(player_location(X, Y), factor(Min, Max), Y =< Min,!).

/* Items */

/* take(X) : mengambil barang jika inventory tidak penuh dan X valid */
take(X) :-
(\+isItemExist,!);
(isItemExist,player_location(X1,Y1), item_list(B1), (checkItem([N1,X1,Y1],B1)),
inventory(Y),
banyak_isi_inventory(Y, N),
N < 5,
retractall(inventory(Y)),
assertz(inventory([X|Y])),
delElIL([N1,X1,Y1],[],B1),
write(' You took '),
write(X)).

take(_X) :- inventory(Y), banyak_isi_inventory(Y, N), N == 5, write(' Inventory penuh!').

/* addItem : menambahkan item ke dalam list item yang ada di battlefield */
addItem :-
random(1,15,A), !,
((A\=5,!);
(A==5,random(1,8,B),iD(N,B),factor(Min,Max),random(Min,Max,X),random(Min,Max,Y),item_list(C),retractall(item_list(C)),assertz(item_list([[N,X,Y]|C])))).

/* spawnItems : melakukan spawn item-item yang terdapat dalam inventori ke dalam battlefield */
spawnItems :- spawnItems2(8),!.
spawnItems2(0) :- !.
spawnItems2(Idx) :- random(2,4,A),iD(N,Idx),spawnItems3(A,N), Next is Idx-1, spawnItems2(Next), !.
spawnItems3(0,_) :- !.
spawnItems3(A,N) :- factor(FMin,Max), Min is FMin + 1, random(Min,Max,X),random(Min,Max,Y),item_list(C),retractall(item_list(C)),assertz(item_list([[N,X,Y]|C])),
Next2 is A - 1, spawnItems3(Next2, N), !.

/* spawnEnemy : melakukan spawn enemy di battlefield */
/*spawnEnemy(N) :- spawnEnemy2(A), !.*/
spawnEnemy :- enemy_count(X), retractall(enemy_list(_A)),assertz(enemy_list([])), spawnEnemy2(X),!.
spawnEnemy2(0) :- !.
spawnEnemy2(Idx) :- random(1,3,A),iD(N,A),spawnEnemy3(N,Idx), Next is Idx-1, spawnEnemy2(Next), !.
spawnEnemy3(N,Idx) :- factor(FMin,Max), Min is FMin + 1, random(Min,Max,X),random(Min,Max,Y),enemy_list(C),retractall(enemy_list(_A)),assertz(enemy_list([[Idx,N,X,Y]|C])),!.

/* same([X],[Y]) : menghasilkan true jika list X sama dengan list Y */
same([], []).
same([H1|R1], [H2|R2]) :- H1 = H2, !, same(R1, R2).

/* checkItem(X,[Y]) : menghasilkan true jika list X ada di list of list [Y] */
checkItem(_A,[]) :- !, fail.
checkItem(A,[HB|TB]) :-
(same(A,HB));
(checkItem(A,TB)).

/* lookItem : menuliskan nama item pada posisi player */
lookItem :-
player_location(X,Y), item_list(B1), ((checkItem([_N,X,Y],B1),write(' You found '), print_item(X,Y));(true)),
A is Y - 1, ((checkItem([_N1,X,A],B1),write(' To the north there is '), print_item(X,A));(true)),
B is X + 1, ((checkItem([_N2,B,Y],B1),write(' To the east there is '), print_item(B,Y));(true)),
C is Y + 1, ((checkItem([_N3,X,C],B1),write(' To the south there is '), print_item(X,C));(true)),
D is X - 1, ((checkItem([_N4,D,Y],B1),write(' To the west there is '), print_item(D,Y));(true)).

/* print_item(X,Y) : menuliskan nama item yang ada di posisi (X,Y) */
print_item(X,Y) :-
item_list(B),
((\+checkItem([N,X,Y],B), write('Nothing '), nl, !);
(checkItem([N,X,Y],B), write('a/an '), write(N), nl, !)).

/* isItemExist : menghasilkan true jika item pada posisi (X,Y) ada */
isItemExist :- player_location(X,Y), item_list(B), !, (checkItem([_N,X,Y],B)).

/* delElIL(X,Y,[Z]) : menghapus item X pada list item tersedia di battle field X=[Nama item,absis item,ordinat item], Y=[], Z=list item2 yang ada di battlefield */
delElIL(_X,Nl,[]) :- write(Nl),retractall(item_list(_A)),assertz(item_list(Nl)),!.
delElIL(X,Nl,[HO|TO]) :-
((same(HO,X),print('Deleted!'),write(Nl),nl,delElIL(X,Nl,TO),!);
(\+same(HO,X),!,write(Nl),nl,delElIL(X,[HO|Nl],TO))).

/* addElIL(X) : menambahkan item X pada list item tersedia di battle field X=[Nama item,absis item,ordinat item] */
addElIL([X,A,B]) :- item_list(Y), retractall(item_list(_)), L = [[X,A,B]|Y], assertz(item_list(L)), !.

/* use(X) :- menggunakan item X dan menghapusnya dari inventori */
use(X) :-
(inventory(I), checkInventory(X,I),
((type(weapon,X), retractall(player_weapon(A)), assertz(player_weapon(X)), write(' '), write(X), write(' equipped'), nl, !);
(type(armor,X), armor(X,Y), retractall(player_armor(A)), assertz(player_armor(Y)), write(' '), write(X), write(' equipped'), nl, !);
(type(aidkit,X), aidkit(X,Y), player_health(A), retractall(player_health(A)), Z is A + Y, (Z =< 100, assertz(player_health(Z)), write(' '), write(X), write(' used'), nl, !); (Z > 100, assertz(player_health(100))), write(' '), write(X), write(' used'), nl, !);
(type(ammo,X), player_weapon(W), ((ammo(W,X), weapon(W,Z), retractall(player_ammo(A)), assertz(player_ammo(Z)), write(' '), write(W), write(' loaded'), nl, !); (\+ammo(W,X), write(' ammo type doesn`t match'), nl, !)))), delInventory(X,[L],I), retractall(inventory(I)), assertz(inventory(L)));
(inventory(I), \+checkInventory(X,I), write(' You don\'t have the item.'), nl, !).

/* drop(X) : menjatuhkan item X pada lokasi player */
drop(X) :-
(inventory(I), checkInventory(X,I), player_location(A,B), addElIL([X,A,B]), delInventory(X,[L],I) ,retractall(inventory(I)), assertz(inventory(L)), write(' You dropped '), write(X), write('.'), nl);
(inventory(I), \+checkInventory(X,I), write(' You don\'t have the item.'), nl, !).

/* checkInventory(X) : menghasilkan true jika item N ada di list inventory */
checkInventory(_X,[]) :- !, fail.
checkInventory(X,[HI|TI]):-
(X == HI, !);
(checkInventory(X,TI)).

/* delInventory(X,Y,[Z]) : menghapus item X pada list item tersedia di battle field X=[Nama item,absis item,ordinat item], Y=[], Z=list item2 yang ada di battlefield*/
delInventory(_X,I,[]) :- retractall(inventory(_A)),assertz(inventory(I)),!.
delInventory(X,I,[HO|TO]) :-
((same(HO,X), delInventory(X,I,TO), !);
(\+same(HO,X), !, delInventory(X,[HO|I],TO))).

/* enemymove :  */
enemymove :- enemy_list(A), moveEnemy([],NL,A), retractall(enemy_list(_)), assertz(enemy_list(NL)), !.

/* moveEnemy :  */
moveEnemy(L, NL, []) :- !,same(NL,L).
moveEnemy(L, NL, [[_A,_B,X,Y]|_C]) :- random(1,4,Z), checkMove(X,Y,D,E,Z), moveEnemy([[_A,_B,D,E]|L], NL, _C).

/* checkMove :  */
checkMove(X,Y,D,E,Z) :-
(factor(Min,Max), Z == 1, A is X - 1, ((A >= Min, D is A, E is Y);(D is X, E is Y)),!);
(factor(Min,Max), Z == 2, B is X + 1, ((B =< Max, D is B, E is Y);(D is X, E is Y)),!);
(factor(Min,Max), Z == 3, C is Y - 1, ((C >= Min, E is C, D is X);(D is X, E is Y)),!);
(factor(Min,Max), Z == 4, D is Y + 1, ((D =< Max, E is D, D is X);(D is X, E is Y)),!).

/* status : menampilkan status pemain saat ini (health, armor, weapon, ammo) dan list barang yang ada di inventory */
status :-
write(' Health     : '), print_health,
write(' Armor      : '), print_armor,
write(' Weapon     : '), print_weapon, nl,
write(' Enemy left : '), print_enemy_count,
write(' Inventory  : '), inventory(X), print_inventory(X), nl.

/* print_health : menuliskan health player */
print_health :- player_health(X), write(X), nl.

/* print_timer : menuliskan timer */
print_timer :- timer(X), write(X), nl.

/* print_armor : menuliskan armor player */
print_armor :- player_armor(X), write(X), nl.

/* print_weapon : menuliskan weapon player */
print_weapon :- player_weapon(X), X == 0, write('none').
print_weapon :- player_weapon(X), write(X).

/* print_inventory : menuliskan isi inventory player */
print_inventory([]).
print_inventory([Head | _Rest]) :- Head == 0, inventory(X), banyak_isi_inventory(X, N), N > 0, !.
print_inventory([Head | _Rest]) :- Head == 0, write(' Your inventory is empty!'), !.
print_inventory([Head | Rest]) :- write(Head), write(' '), print_inventory(Rest).

/* banyak_isi_inventory : menuliskan jumlah isi inventory player */
banyak_isi_inventory([], N) :- N is 0.
banyak_isi_inventory([Head | _Rest], N) :- Head == 0, N is 0, !.
banyak_isi_inventory([_Head | Rest], N) :- banyak_isi_inventory(Rest, M), N is M + 1.

/* print_enemy_count : menuliskan jumlah musuh tersisa */
print_enemy_count :- enemy_count(X), write(X), nl.
