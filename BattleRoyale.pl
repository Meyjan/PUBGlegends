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
execute(map) :- timer(X), drawMap(1,1, X), nl, !.
execute(n) :- n, nl, !.
execute(s) :- s, nl, !.
execute(e) :- e, nl, !.
execute(w) :- w, nl, !.
execute(take(object)) :- take(object), nl, !.
execute(drop(object)) :- drop(object), nl, !.
execute(use(object)) :- use(object), nl, !.
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
location(2,2,5,5,openField).
location(4,4,5,5,karnakTemple).
location(2,6,5,11,desert).
location(4,6,5,7,lostCityOfIram).
location(5,2,11,5,jungle).
location(5,4,11,5,cuevaDelDiablo).
location(5,6,11,11,miltaTemple).
location(5,6,11,7,mountain).

 /* weapon(X,Y) : Senjata X dapat menampung Y peluru*/
weapon(m16,30).
weapon(rpg7,2).

 /* armor(X,Y) : Armor X memiliki Y endurance */
armor(lvl1,30).
armor(lvl2,60).

 /* ammo(X,Y) : Senjata X menggunakan ammo Y */
ammo(m16,rifleammo).
ammo(rpg7,rocket).

 /* aidkit(X,Y) : Aidkit X menambah Y health */
aidkit(drink,20).
aidkit(bandage,50).

 /* item(X,Y) : Item Y bertipe X */
type(weapon,[m16,rpg7]).
type(armor,[jacket,vest]).
type(ammo,rifleammo).
type(ammo,rocket).
type(aidkit,drink).
type(aidkit,bandage).

 /* Variabel Dinamik */
:- dynamic(player_location/2).
:- dynamic(player_health/1).
:- dynamic(player_armor/1).
:- dynamic(player_weapon/1).
:- dynamic(player_ammo/1).
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
retractall(enemy_count(_X)),
retractall(timer(_X)).

 /* Fakta untuk kondisi awal */
player_health(_X).
player_armor(_X).
player_ammo(_X).
player_location(_X,_Y).
player_weapon(_X),
enemy_count(_X).
timer(_X).
inventory([_A, _B, _C, _D, _E]).

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
assertz(timer(0)).

 /*-------Debugging----------*/
print_health :-
player_health(X),
write(X), nl.

print_timer :-
timer(X),
write(X), nl.

print_armor :-
player_armor(X),
write(X), nl.

print_location :-
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 5, X =< 6, Y >= 5, Y =< 6, write(X), write(' '), write(Y), nl, write('You are in the karnak temple.\nTo the north is an open field.\nTo the east is an open field.\nTo the west is the lost city of iram.\nTo the south is the cueva del diablo.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 2, X =< 4, Y >= 2, Y =< 4, write(X), write(' '), write(Y), nl, write('You are in the open field.\nTo the north is a dead zone.\nTo the east is a desert.\nTo the west is a dead zone.\nTo the south is a jungle.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 5, X =< 6, Y >= 2, Y =< 4, write(X), write(' '), write(Y), nl, write('You are in the open field.\nTo the north is a dead zone.\nTo the east is a desert.\nTo the west is a dead zone.\nTo the south is the karnak temple.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 2, X =< 4, Y >= 5, Y =< 6, write(X), write(' '), write(Y), nl, write('You are in the open field.\nTo the north is a dead zone.\nTo the east is the karnak temple.\nTo the west is a dead zone.\nTo the south is a jungle.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 9, X =< 11, Y >= 2, Y =< 4, write(X), write(' '), write(Y), nl, write('You are in a desert.\nTo the north is a dead zone.\nTo the east is a dead zone.\nTo the west is an open field.\nTo the south is a mountain.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 7, X =< 8, Y >= 5, Y =< 6, write(X), write(' '), write(Y), nl, write('You are in the lost city of iram.\nTo the north is a desert.To the east is a desert.To the west is the karnak temple.To the south is the milta temple.'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 7, X =< 8, Y >= 2, Y =< 4, write(X), write(' '), write(Y), nl, write('You are in a desert.\nTo the north is a dead zone.\nTo the east is a dead zone.\nTo the west is an open field.\nTo the south is the lost city of iram.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 9, X =< 11, Y >= 5, Y =< 6, write(X), write(' '), write(Y), nl, write('You are in a desert.\nTo the north is a dead zone.\nTo the east is a dead zone.\nTo the west is the lost city of iram.\nTo the south is a mountain.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 5, X =< 6, Y >= 7, Y =< 8, write(X), write(' '), write(Y), nl, write('You are in the cueva del diablo.\nTo the north is the karnak temple.\nTo the east is the milta temple.\nTo the west is a jungle.\nTo the south is a jungle.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 2, X =< 4, Y >= 9, Y =< 11, write(X), write(' '), write(Y), nl, write('You are in the jungle.\nTo the north is an open field.\nTo the east is a mountain.\nTo the west is a dead zone.\nTo the south is a deadzone.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 2, X =< 4, Y >= 7, Y =< 8, write(X), write(' '), write(Y), nl, write('You are in the jungle.\nTo the north is an open field.\nTo the east is the cueva del diablo.\nTo the west is a dead zone.\nTo the south is a deadzone.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 5, X =< 6, Y >= 9, Y =< 11, write(X), write(' '), write(Y), nl, write('You are in the jungle.\nTo the north is the cueva del diablo.\nTo the east is a mountain.\nTo the west is a dead zone.\nTo the south is a deadzone.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 7, X =< 8, Y >= 7, Y =< 8, write(X), write(' '), write(Y), nl, write('You are in the milta temple.\nTo the north is the lost city of iram.\nTo the east is a mountain.\nTo the west is the cueva del diablo.\nTo the south is a mountain.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 9, X =< 11, Y >= 9, Y =< 11, write(X), write(' '), write(Y), nl, write('You are in the mountain.\nTo the north is a desert.\nTo the east is a dead zone.\nTo the west is a jungle.\nTo the south is a dead zone.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 9, X =< 11, Y >= 7, Y =< 8, write(X), write(' '), write(Y), nl, write('You are in the mountain.\nTo the north is a desert.\nTo the east is a dead zone.\nTo the west is the milta temple.\nTo the south is a dead zone.\n'), nl, !);
(player_location(X,Y), factor(Min,Max), X > Min, X < Max, Y > Min, Y < Max, X >= 7, X =< 8, Y >= 9, Y =< 11, write(X), write(' '), write(Y), nl, write('You are in the mountain.\nTo the north is the milta temple.\nTo the east is a dead zone.\nTo the west is a jungle.\nTo the south is a dead zone.\n'), nl, !).

print_enemy_count :-
enemy_count(X),
write(X), nl.

print_inventory([]).
print_inventory([Head | _Rest]) :- Head == 0, write('Your inventory is empty!'), !.
print_inventory([Head | Rest]) :- write(Head), write(' '), print_inventory(Rest).

print_weapon :- player_weapon(X), X == 0, write('none').
print_weapon :- player_weapon(X), write(X).

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
drawMap(1,1,Y),
nl,
write(' << Command >> '),
read(X),
execute(X),
retractall(timer(Y)),
assertz(timer(Y+1)),
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
write(' start -- start the game! '), nl,
write(' help -- show available commands '), nl,
write(' quit -- quit the game '), nl,
write(' look -- look around you '), nl,
write(' n -- move north '), nl,
write(' s -- move south '), nl,
write(' e -- move east '), nl,
write(' w -- move west '), nl,
write(' map -- look at the map and detect enemies '), nl,
write(' take(Object). -- pick up an object '), nl,
write(' drop(Object). -- drop an object '), nl,
write(' use(Object). -- use an object '), nl,
write(' attack. -- attack enemy that crosses your path '), nl,
write(' status. -- show your status '), nl,
write(' save(Filename). -- save your game '), nl,
write(' load(Filename). -- load previously saved game '), nl, nl,
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

 /* n() : menggerakkan pemain satu petak ke arah utara  */
n :-
(player_location(X,Y), factor(Min,Max), Z is Y - 1, Z =< Min, write('Invalid move'), !);
(player_location(X,Y), factor(Min,Max), Z is Y - 1, Z > Min, retractall(player_location(X,Y)), assertz(player_location(X,Z)), write('Posisi = '), print_location, !).

 /* s() : menggerakkan pemain satu petak ke arah selatan */
s :-
(player_location(X,Y), factor(Min,Max), Z is Y + 1, Z >= Max, write('Invalid move'), !);
(player_location(X,Y), factor(Min,Max), Z is Y + 1, Z < Max, retractall(player_location(X,Y)), assertz(player_location(X,Z)), write('Posisi = '), print_location, !).

 /* e() : menggerakkan pemain satu petak ke arah timur */
e :-
(player_location(X,Y), factor(Min,Max), Z is X + 1, Z >= Max, write('Invalid move'), !);
(player_location(X,Y), factor(Min,Max), Z is X + 1, Z < Max, retractall(player_location(X,Y)), assertz(player_location(Z,Y)), write('Posisi = '), print_location, !).

 /* w() : menggerakkan pemain satu petak ke arah barat */
w :-
(player_location(X,Y), factor(Min,Max), Z is X - 1, Z =< Min, write('Invalid move'));
(player_location(X,Y), factor(Min,Max), Z is X - 1, Z > Min, retractall(player_location(X,Y)), assertz(player_location(Z,Y)), write('Posisi = '), print_location).

 /* drawMap(X,Y,Z) : memperlihatkan seluruh peta permainan dengan menunjukkan petak deadzone dan petak safezone, serta lokasi pemain */
drawMap(12,12,_Timer) :- print('X'), nl, !.
drawMap(Row,Col,Timer) :-
(player_location(X,Y), Row == Y, Col == X, Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col > Min, Row < Max, Col < Max, print('P '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col > Min, Row < Max, Col < Max, print('- '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row >= Max, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col =< Min, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer), !);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol,Timer),!).

 /* faktor untuk penentu X saat timer dijalankan */
factor(Min,Max) :- (timer(Timer), Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor)).

 /* deadzone_hit: mengecek apakah player berada di deadzone */
deadzone_hit :-
(player_location(X, Y), factor(Min, Max), X =< Min,!);
(player_location(X, Y), factor(Min, Max), X >= Max,!);
(player_location(X, Y), factor(Min, Max), Y >= Max,!);
(player_location(X, Y), factor(Min, Max), Y =< Min,!).

 /* status() : menampilkan status pemain saat ini (health, armor, weapon, ammo) dan list barang yang ada di inventory */
status :-
write(' Health    : '), print_health,
write(' Armor     : '), print_armor,
write(' Weapon    : '), print_weapon, nl,
write(' Inventory : '), inventory(X), print_inventory(X), !, nl,
write(' Enemy left: '), print_enemy_count.
