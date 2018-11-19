/* Nama Kelompok	: Fortine > PUBG */
/* NIM/Nama			: 13517020/T. Antra Oksidian Tafly, 13517059/Nixon Andhika, 13517131/Jan Meyer Saragih, 13517137/Vincent Budianto */
/* Nama file		: BattleRoyale.pl */
/* Topik			: Tugas Besar IF2121 - Logika Informatika */
/* Tanggal			: 21 November 2018 */
/* Deskripsi		: Membuat permainan battle royale menggunakan prolog */

/* Implementasi fungsi execute */
execute(help) :- help, nl, !.
execute(quit) :- quit, nl, !.
execute(look) :- look, nl, !.
execute(map) :- map, nl, !.
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
win :-
dead :-
quit :- write('Alice scheme is successful. You have been killed.'), retractall(location(X,Y)), retractall(inventory(X)), sleep(2), nl, nl, !, credit.

/* Deklarasi Fakta */
/* map : peta permainan */
map :-
([['X','X','X','X','X','X','X','X','X','X','X','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','-','-','-','-','-','-','-','-','-','-','X'],
['X','X','X','X','X','X','X','X','X','X','X','X']]).

/* weapon(X,Y) : Senjata X dapat menampung Y peluru*/
weapon(deagle,7).
weapon(m4,30).
weapon(shotgun,5).
/* armor(X,Y) : Armor X memiliki Y endurance */
armor(lvl1,30).
armor(lvl2,60).
armor(lvl3,100).
/* aidkit(X,Y) : Aidkit X menambah Y health */
aidkit(drink,20).
aidkit(bandage,50).
aidkit(firstaidkit,100).
/* item(X,Y) : Item Y bertipe X */
item(weapon,deagle).
item(weapon,m4).
item(weapon,shotgun).
item(armor,lvl1).
item(armor,lvl2).
item(armor,lvl3).
item(aidkit,drink).
item(aidkit,bandage).
item(aidkit,firstaidkit).

/* Variabel Dinamik */
:- dynamic(location/2).
:- dynamic(health/1).
:- dynamic(armor/1).
:- dynamic(weapon/1).
:- dynamic(ammo/1).
:- dynamic(inventory/1).


/* Deklarasi Rule */
dynamic_facts :- retractall(location(X,Y)), retractall(inventory(X)), random(2,11,X), random(2,11,Y), assertz(location(X,Y)), assertz(inventory(none)).

/* Loop agar game tetap berjalan */
game() :- repeat, read(X), execute(X), (win; dead; X==quit), !.

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
write(' Five seconds before the enemy reaches the battlefield! Smash them! '), nl,
sleep(1), write(' No troops deployed! '), nl,
sleep(2), write(' You`re alone... '), dynamic_facts, game().

/* help() : menampilkan fungsi-fungsi yang dapat dipanggil dalam permainan, dapat mengandung informasi lain yang mungkin dibutuhkan */
help :-
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
write(' X = inaccessible ').

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


/* s() : menggerakkan pemain satu petak ke arah selatan */


/* e() : menggerakkan pemain satu petak ke arah timur */


/* w() : menggerakkan pemain satu petak ke arah barat */


/* map() : memperlihatkan seluruh peta permainan dengan menunjukkan petak deadzone dan petak safezone, serta lokasi pemaim */


/* status() : menampilkan status pemain saat ini (health, armor, weapon, ammo) dan list barang yang ada di inventory */
