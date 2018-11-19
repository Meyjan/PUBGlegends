/* Nama Kelompok	: Fortine > PUBG */
/* NIM/Nama			: 13517020/T. Antra Oksidian Tafly, 13517059/Nixon Andhika, 13517131/Jan Meyer Saragih, 13517137/Vincent Budianto */
/* Nama file		: BattleRoyale.pl */
/* Topik			: Tugas Besar IF2121 - Logika Informatika */
/* Tanggal			: 21 November 2018 */
/* Deskripsi		: Membuat permainan battle royale menggunakan prolog */

/*Clear screen*/
cls :- write('\e[2J').

/* Implementasi fungsi execute */
execute(help) :- help, nl, !.
execute(half):- half,!.
execute(print_health):- print_health, !.
execute(print_location):- print_location, !.
execute(print_armor):- print_armor, !.
execute(quit) :- quit, nl, !.
execute(look) :- look, nl, !.
execute(map) :- drawMap(1,1,Timer), nl, !.
execute(n) :- n, nl, !.
execute(s) :- s, nl, !.
execute(e) :- e, nl, !.
execute(w) :- w, nl, !.
execute(take(object)) :- take(object), nl, !.
execute(drop(object)) :- drop(object), nl, !.
execute(use(object)) :- use(object), nl, !.
execute(attack) :- help, nl, !.
execute(status) :- status, nl, !.
execute(quit) :- quit, nl, !.
/*execute(save(file)) :- save(file), nl, !.
execute(load(file)) :- load(file), nl, !. */
execute(_) :- write('Invalid command. Please try again.'), nl.

/* Syarat game beres */
win :- enemy_count(X), X == 0, writeln('Congratulations, Winner Winner Chicken Dinner!'), quit, !.
/*lose :- health == 0, writeln('Your health reaches 0. No Chicken dinner for you!'), !.
lose :- deadzone_hit, writeln('You are in the deadzone. You died pitifully. No Chicken dinner for you!'), !.*/
quit :- retractall(location(X,Y)), retractall(inventory(X)), nl, nl, !, credit.

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
:- dynamic(drawMap/3).
:- dynamic(enemy_count/1).

/* Deklarasi Rule */
dynamic_facts :-
retractall(player_location(X,Y)),
retractall(player_health(X)),
retractall(player_armor(X)),
retractall(player_weapon(X)),
retractall(player_ammo(X)),
retractall(inventory(X)),
retractall(enemy_count(X)).

/* Fakta untuk kondisi awal */
player_health(X).
player_armor(X).
player_ammo(X).
player_location(X,Y).
enemy_count(X).

/* Inisialisasi Game */
initialize_game :-
assertz(player_health(100)),
assertz(player_armor(0)),
random(10,20,Z),
assertz(enemy_count(Z)),
random(2,11,X),
random(2,11,Y),
assertz(player_location(X,Y)),
assertz(player_weapon(none)),
assertz(inventory(none)).

/*-------Debugging----------*/
print_health :-
player_health(X),
write(X), nl.

print_armor :-
player_armor(X),
write(X), nl.

print_location :-
player_location(X,Y),
write(X),
write(' '),
write(Y), nl.

print_enemy_count :-
enemy_count(X),
write(X), nl.

half :-
player_health(X),
Y is X/2,
retractall(player_health(X)),
assertz(player_health(Y)).

/*--------------------*/

/* Loop agar game tetap berjalan */
game :-
repeat,
cls,
drawMap(1,1,0),
nl,
write(' << Command >> '),
read(X),
execute(X),
(win; /*lose;*/ X==quit), !.

/* start() : memulai permainan, menampilkan judul dan instruksi permainan */
start :-
cls,
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
sleep(1), write(' 4...'), nl,
sleep(1), write(' 3...'), nl,
sleep(1), write(' 2...'), nl,
sleep(1), write(' 1...'), nl,
sleep(1), write(' Deploying and opening parachute '), nl,
sleep(1), write(' You landed safely. Kill all enemies '), nl, nl,
sleep(2),
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
n :- player_location(X,Y), Z is Y + 1, retractall(player_location(X,Y)), assertz(player_location(X,Z)), write('Posisi = '), print_location.

/* s() : menggerakkan pemain satu petak ke arah selatan */
s :- player_location(X,Y), Z is Y - 1, retractall(player_location(X,Y)), assertz(player_location(X,Z)), write('Posisi = '), print_location.

/* e() : menggerakkan pemain satu petak ke arah timur */
e :- player_location(X,Y), Z is X + 1, retractall(player_location(X,Y)), assertz(player_location(Z,Y)), write('Posisi = '), print_location.

/* w() : menggerakkan pemain satu petak ke arah barat */
w :- player_location(X,Y), Z is X - 1, retractall(player_location(X,Y)), assertz(player_location(Z,Y)), write('Posisi = '), print_location.

/* drawMap(X,Y,Z) : memperlihatkan seluruh peta permainan dengan menunjukkan petak deadzone dan petak safezone, serta lokasi pemain */
drawMap(12,12,Timer) :- print('X'), nl, !.
drawMap(Row,Col,Timer) :-
  (player_location(X,Y), Row == X, Col == Y, Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col > Min, Row < Max, Col < Max, print('P '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col > Min, Row < Max, Col < Max, print('- '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row =< Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row >= Max, Col < Max, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer),!);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col =< Min, print('X '), !, NextCol is Col+1, drawMap(Row,NextCol,Timer), !);
  (Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col >= 12, print('X'), nl, !, NextRow is Row+1, NextCol is 1, drawMap(NextRow,NextCol,Timer),!);
(Factor is (Timer div 10), Min is (1 + Factor), Max is (12 - Factor), Row > Min, Col >= Max, Col < 12, print('X '), !, NextCol is Col + 1, drawMap(Row,NextCol,Timer),!).

/* status() : menampilkan status pemain saat ini (health, armor, weapon, ammo) dan list barang yang ada di inventory */
status :-
write(' Health    : '), print_health,
write(' Armor     : '), print_armor,
write(' Weapon    : '), write(player_weapon), nl,
write(' Inventory : '), write(inventory), nl,
write(' Enemy left: '), print_enemy_count,
sleep(3).
