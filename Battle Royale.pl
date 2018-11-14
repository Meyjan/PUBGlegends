/* Nama Kelompok	: Fortine > PUBG */
/* NIM/Nama			: 13517020/T. Antra Oksidian Tafly, 13517059/Nixon Andhika, 13517131/Jan Meyer Saragih, 13517137/Vincent Budianto */
/* Nama file		: BattleRoyale.pl */
/* Topik			: Tugas Besar IF2121 - Logika Informatika */
/* Tanggal			: 21 November 2018 */
/* Deskripsi		: Membuat permainan battle royale menggunakan prolog */

start. -- start the game!
help. -- show available commands
quit. -- quit the game
look. -- look around you
n. s. e. w. -- move
map. -- look at the map and detect enemies
take(Object). -- pick up an object
drop(Object). -- drop an object
use(Object). -- use an object
attack. -- attack enemy that crosses your path
status. -- show your status
save(Filename). -- save your game
load(Filename). -- load previously saved game

Legends:
W = weapon
A = armor
M = medicine
O = ammo
P = player
E = enemy
- = accessible
X = inaccessible

/* Deklarasi Fakta */


/* Deklarasi Rule */
/* start() : memulai permainan */
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
sleep(2), write(' You`re alone... ').
