import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.core.PApplet; 
import processing.core.PGraphics; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pong extends PApplet {

//1 - creer une balle qui rebondit sur les murs CHECK
//2 - creer des joueurs qui peuvent se deplacer verticalement CHECK
//3 - faire rebondir la balle sur les joueurs CHECK
//4 - compter les points 


Balle balle;
Player player1;
Player player2;
PImage cube;
PImage cube_gele;
PImage bullet1;
PImage bullet2;
PImage boule_de_feu1;
PImage boule_de_feu2;
PImage boule_de_neige1;
PImage boule_de_neige2;
PImage platform1;
PImage platform2;
PImage red_champ;
PImage green_champ;
PImage etoile;
PImage green_shell;
PImage red_shell;
PImage blue_shell;
PImage chateau_mushroom;
PImage bowser_castle;
PImage peach_castle;
PImage eclair;
PImage foudre;
PImage mega_champ;
PImage platform1_foudre;
PImage platform2_foudre;
PImage platform1_feu;
PImage platform2_feu;
PImage platform1_ice;
PImage platform2_ice;
PImage platform1_gele;
PImage platform2_gele;
PImage king_boo;
PImage bowser_cecite;
PImage bowser_cecite_foudre;
PImage fire_mario;
PImage ice_mario;
PImage game_over;
PFont rubber_biscuit;
PGraphics name_player_1_graphics;
PGraphics name_player_2_graphics;
Objet objet_changement_direction;
Objet objet_fire_mario;
Objet objet_king_boo;
Objet objet_etoile;
Objet objet_platforme_maudite_boost;
Objet objet_ice_mario;
Objet objet_eclair;
Objet objet_mega_champ;
Objet objet_red_champ;
Objet objet_green_champ;
int weed;
float starting_heil; 
int score1 = 5;
int score2 = 5;
int ballcolor = color(255,255,255);
int apparition_objet = 0;
int size_objet;
ArrayList<Projectile> projectiles;
ArrayList<Objet_au_sol> red_champs;
ArrayList<Objet_au_sol> green_champs;
ArrayList<Objet_au_sol> etoiles;
ArrayList<Objet_au_sol> eclairs;
ArrayList<Objet_au_sol> mega_champs;
ArrayList<Objet_au_sol> king_boos;
float global_heil1;
float global_heil2;
Mur mur1;
Mur mur2;
Mur fire_wall;
int etoile_compte = 0;
boolean is_foudre_falling;
int size_king_boo;
int size_fire_mario;
int size_ice_mario;
int size_eclair;
int size_mega_champ;
int size_red_champ;
int size_green_champ;
int size_etoile;
int size_ball;
int duree_invisiblite = 80;
String player1_name = "";
String player2_name = "";
boolean settings_done = false;
boolean game_over_bool = false;
boolean player1_name_validate = false;
boolean player2_na_validate = false;
int mur_weed;
int projectile_size;
boolean fire_game;
int vel_normal_bullet;
int vel_fire_bullet;
int vel_ice_bullet;
int acc_fire_bullet;
int acc_ice_bullet;
int acc_normal_bullet;
int vel_cube;



public void settings() {
    fullScreen();
}


public void setup() {
    rubber_biscuit = createFont("Rubber Biscuit Bold",128);
    weed = width / 30;
    size_objet = 100* width / 1300;
    size_king_boo = 100* width / 1300;
    size_fire_mario = 100* width / 1300;
    size_ice_mario = 100* width / 1300;
    size_ball = 30* width / 1300;
    mur_weed = 60* width / 1300;
    starting_heil = height / 7;
    projectile_size = 30 * width / 1300;
    size_eclair = 120 * width/1300;
    size_mega_champ = 160 * width/1300;
    size_red_champ = 120 * width/1300;
    size_green_champ = 100 * width/1300;
    size_etoile = 150 * width/1300;
    fire_game = false;
    vel_normal_bullet = 20 * width / 1300;
    vel_fire_bullet = 40 * width / 1300;
    vel_ice_bullet = 20 * width / 1300;
    acc_fire_bullet = 1* width / 1300;
    acc_ice_bullet = 0;
    acc_normal_bullet = 0;
    vel_cube = 3 * width / 1300;

    if (settings_done) {
        is_foudre_falling = false;
        cube = loadImage("cube_mystere.png");
        cube_gele = loadImage("cube_gele.png");
        bullet1 = loadImage("bullet1.png");
        bullet2 = loadImage("bullet2.png");
        boule_de_feu1 = loadImage("boule_de_feu1.png");
        boule_de_feu2 = loadImage("boule_de_feu2.png");
        boule_de_neige1 = loadImage("boule_de_neige1.png");
        boule_de_neige2 = loadImage("boule_de_neige2.png");
        platform1 = loadImage("platform1.png");
        platform2 = loadImage("platform2.png");
        red_champ = loadImage("red_champ.png");
        green_champ = loadImage("green_champ.png");
        etoile = loadImage("etoile.png");
        green_shell = loadImage("carapace_verte.png");
        red_shell = loadImage("carapace_rouge.png");
        blue_shell = loadImage("carapace_bleue.png");
        chateau_mushroom = loadImage("chateau_mushroom.png");
        bowser_castle = loadImage("bowser_castle.jpg");
        peach_castle = loadImage("peach_castle.jpg");
        eclair = loadImage("eclair.png");
        foudre = loadImage("foudre.png");
        bowser_cecite = loadImage("bowser_cecite.jpg");
        bowser_cecite_foudre = loadImage("bowser_cecite_foudre.jpg");
        mega_champ = loadImage("mega_champ.png");
        king_boo = loadImage("king_boo.png");
        game_over = loadImage("game_over.jpg");
        chateau_mushroom.resize(width,height);
        bowser_castle.resize(width,height);
        peach_castle.resize(width,height);
        foudre.resize(width,height);
        bowser_cecite.resize(width,height);
        bowser_cecite_foudre.resize(width,height);
        game_over.resize(width,height);
        platform1_foudre = loadImage("platform1_foudre.png");
        platform2_foudre = loadImage("platform2_foudre.png");
        platform1_feu = loadImage("platform1_feu.png");
        platform2_feu = loadImage("platform2_feu.png");
        platform1_ice = loadImage("platform1_ice.png");
        platform2_ice = loadImage("platform2_ice.png");
        platform1_gele = loadImage("platform1_gele.png");
        platform2_gele = loadImage("platform2_gele.png");
        fire_mario = loadImage("fire_mario.png");
        ice_mario = loadImage("ice_mario.png");
        projectiles = new ArrayList<Projectile>();
        red_champs = new ArrayList<Objet_au_sol>();
        green_champs = new ArrayList<Objet_au_sol>();
        mega_champs = new ArrayList<Objet_au_sol>();
        king_boos = new ArrayList<Objet_au_sol>();
        etoiles = new ArrayList<Objet_au_sol>();
        eclairs = new ArrayList<Objet_au_sol>();
        
        balle = new Balle(new PVector(width/2, height/2), new PVector(8 * width / 1300, 0), new PVector(0, 0), size_ball);
        make_text_player1();
        make_text_player2();
        player1 = new Player(new PVector(width/15, height / 2 - global_heil1/2) , new PVector(0, 0), weed, global_heil1, name_player_1_graphics);
        player2 = new Player(new PVector(width - width/15 - weed, height/2 - global_heil2/2) , new PVector(0, 0), weed, global_heil2, name_player_2_graphics);
        objet_changement_direction = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"changement_direction");
        objet_fire_mario = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"fire_mario");
        objet_king_boo = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"king_boo");
        objet_etoile = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"etoile");
        objet_platforme_maudite_boost = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"platforme_maudite_boost");
        objet_ice_mario = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"ice_mario");
        objet_eclair = new Objet(new PVector(width/2 - size_objet/2,-size_objet),new PVector(0,0), size_objet,"eclair");
        objet_mega_champ = new Objet(new PVector(width/2 - size_objet/2, -size_objet),new PVector(0,0), size_objet,"mega_champ");
        objet_red_champ = new Objet(new PVector(width/2 - size_objet/2, -size_objet),new PVector(0,0), size_objet,"red_champ");
        objet_green_champ = new Objet(new PVector(width/2 - size_objet/2, -size_objet),new PVector(0,0), size_objet,"green_champ");
        mur1 = new Mur(new PVector(-2*mur_weed,0), mur_weed, height, "rainbow_wall");
        mur2 = new Mur(new PVector(width + 2*mur_weed,0),mur_weed , height, "rainbow_wall");
        fire_wall = new Mur(new PVector(width + 2*mur_weed,0),mur_weed , height, "fire_wall");

    }
    else {
        global_heil1 = height/7;
        global_heil2 = height/7;
    }
}   

public void draw() {
    if (settings_done) {
        if (is_foudre_falling && balle.est_invisible > 0) {
            background(bowser_cecite_foudre);
        }
        else if (is_foudre_falling) {
            background(foudre);
        }
        else if (balle.est_invisible > 0) {
            background(bowser_cecite);
        }
        else {
            background(bowser_castle);
        }
        tint(255,128);
        for (int i = 0; i < score1; ++i) {
            image(green_champ,5 * width / 1300 + i * (width/4 - 80 * width / 1300) / score1, 3 * width / 1300, (width/4 - 80 * width / 1300) / score1, (width/4 - 80 * width / 1300) / score1);
        }
        for (int i = 0; i < score2; ++i) {
            image(green_champ,3*width/4 + 75 * width / 1300 + i * (width/4 - 80 * width / 1300)/score2 , 3 * width / 1300, (width/4 - 80 * width / 1300) / score2 , (width/4 - 80 * width / 1300) / score2);
        }
        tint(255,255);
        if (balle.press_p) {
            for (int j = projectiles.size()-1; j > -1; j--) {
                projectiles.remove(j);
            }
            for (int j = red_champs.size()-1; j > -1; j--) {
                red_champs.remove(j);
            }
            for (int j = green_champs.size()-1; j > -1; j--) {
                green_champs.remove(j);
            }
            for (int j = etoiles.size()-1; j > -1; j--) {
                etoiles.remove(j);
            }
            for (int j = eclairs.size()-1; j > -1; j--) {
                eclairs.remove(j);
            }
            for (int j = mega_champs.size()-1; j > -1; j--) {
                mega_champs.remove(j);
            }
            for (int j = king_boos.size()-1; j > -1; j--) {
                king_boos.remove(j);
            }
            balle.pos.x = 10 * width + 2*mur2.weed;
            balle.pos.y = height/2;
            balle.vel.x = 0;
            balle.vel.y = 0;
            balle.acc.x = 0;
            balle.acc.y = 0;
            player1.objet_stocke = "";
            player1.est_objet_stocke = false;
            player2.objet_stocke = "";
            player2.est_objet_stocke = false;
        }

        for (int j = projectiles.size()-1; j > -1; j--) {
            projectiles.get(j).show();
            projectiles.get(j).update();
            if (projectiles.get(j).pos.x > width || projectiles.get(j).pos.x < 0 || projectiles.get(j).dead) {
                projectiles.remove(j);
            }
        }
        for (int j = red_champs.size()-1; j > -1; j--) {
            red_champs.get(j).show();
            red_champs.get(j).update();
            if (red_champs.get(j).dead) {
                red_champs.remove(j);
            }
        }
        for (int j = green_champs.size()-1; j > -1; j--) {
            green_champs.get(j).show();
            green_champs.get(j).update();
            if (green_champs.get(j).dead) {
                green_champs.remove(j);
            }
        }
        for (int j = etoiles.size()-1; j > -1; j--) {
            etoiles.get(j).show();
            etoiles.get(j).update();
            if (etoiles.get(j).dead) {
                etoiles.remove(j);
            }
        }
        for (int j = eclairs.size()-1; j > -1; j--) {
            eclairs.get(j).show();
            eclairs.get(j).update();
            if (eclairs.get(j).dead) {
                eclairs.remove(j);
            }
        }
        for (int j = mega_champs.size()-1; j > -1; j--) {
            mega_champs.get(j).show();
            mega_champs.get(j).update();
            if (mega_champs.get(j).dead) {
                mega_champs.remove(j);
            }
        }
        for (int j = king_boos.size()-1; j > -1; j--) {
            king_boos.get(j).show();
            king_boos.get(j).update();
            if (king_boos.get(j).dead) {
                king_boos.remove(j);
            }
        }
        if (score1 == 0 || global_heil2 >= height) {
            balle.vel.x = 0;
            balle.vel.y = 0;
            balle.pos.x = width/2;
            balle.pos.y = height/2;
            // game_over(player2);
        }
        if (score2 == 0 || global_heil1 >= height) {
            balle.vel.x = 0;
            balle.vel.y = 0;
            balle.pos.x = width/2;
            balle.pos.y = height/2;
            // game_over(player1);  
        }
        if (balle.press_p) {
            fill(255,255,255);
            text("Press g", width/2, height/2);
        }
        balle.show();
        balle.update();
        tint(255,255,255);
        fill(0,0,255);
        player1.show();
        player2.show();
        player1.update();
        player2.update();
        objet_changement_direction.show();
        objet_fire_mario.show();
        objet_king_boo.show();
        objet_etoile.show();
        objet_platforme_maudite_boost.show();
        objet_ice_mario.show();
        objet_eclair.show();
        objet_mega_champ.show();
        objet_red_champ.show();
        objet_green_champ.show();
        objet_changement_direction.update();
        objet_fire_mario.update();
        objet_king_boo.update();
        objet_etoile.update();
        objet_platforme_maudite_boost.update();
        objet_ice_mario.update();
        objet_eclair.update();
        objet_mega_champ.update();
        objet_red_champ.update();
        objet_green_champ.update();
        mur1.show();
        mur2.show();
        fire_wall.show();
        image(player1.name, 31*width/100, height/100, 17 * width/100,height/19 );
        image(player2.name, 52* width/100, height/100, 17 * width/100,height/19);

    }
    else {
        background(50);
        if (!player1_name_validate) {
            fill(255,255,255);
            textFont(rubber_biscuit, 30);
            text(player1_name, 300, 130);
        }
        else {
            textFont(rubber_biscuit, 30);
            text(player1_name, 300, 130);
            textSize(36);
            fill(0,200,0);
            text("Player 2: ",25,300);
            if (!player2_na_validate) {
                fill(255,255,255);
                textFont(rubber_biscuit, 30);
                text(player2_name, 300, 300);
            }
            else {
                fill(255,255,255);
                textFont(rubber_biscuit, 30);
                text(player2_name, 300, 300);
                fill(255,255,255);
                textSize(100);
                text("PRESS START",25,500);
            }
        }
    }
}   

public void keyTyped() {
    if (!settings_done) {
        if (!player1_name_validate) {
            if (key == 8) {
                if (player1_name.length() > 0) {
                    player1_name = player1_name.substring(0, player1_name.length() -1);
                }
            }
            else {
                if (keyCode != ENTER) {
                    player1_name += key;
                }
            }
        }
        else {
            if (!player2_na_validate) {
                if (key == 8) {
                    if (player2_name.length() > 0) {
                        player2_name = player2_name.substring(0, player2_name.length() -1);
                    }
                }
                else {
                    if (keyCode != ENTER) {
                        player2_name += key;
                    }
                }
            }
        }
    }
}


public void keyPressed() {
    if (settings_done) {
        if (key == 'p' && !balle.press_p) {
            player2.vel.y = -player2.vel_max;
        }
        if (key == 'm' && !balle.press_p) {
            player2.vel.y = player2.vel_max;
        }
        if (key == 'a' && !balle.press_p) {
            player1.vel.y = -player1.vel_max;
        }
        if (key == 'q' && !balle.press_p) {
            player1.vel.y = player1.vel_max;
        }
        if (key == 'g') {
            if (balle.press_p) {
                balle.press_p = false;
                setup();
            }
        }
        if (key == 'o' && player2.est_objet_stocke) {
            if (player2.objet_stocke == "king_boo") {
                player2.objet_stocke = "";
                player2.est_objet_stocke = false;
                balle.est_invisible = abs(duree_invisiblite - 3*PApplet.parseInt(abs(balle.vel.x* width / 1300)));
                king_boos.add(new Objet_au_sol(new PVector(player2.pos.x - size_king_boo, height - size_king_boo), new PVector(-5 * width / 1300 ,0), new PVector(0,0), size_king_boo, "king_boo"));
            }
            else if (player2.objet_stocke == "fire_mario") {
                if (player1.est_cheate == 0) {
                    player2.objet_stocke = "";
                    player2.est_objet_stocke = false;
                    if (player1.objet_stocke == "fire_mario")
                        player1.objet_stocke = "";
                        player1.est_objet_stocke = false;
                    player2.est_en_feu = 3;
                    player2.est_en_ice = 0;
                    player2.est_geant = 0;
                    player2.est_gele = 0;
                    player2.est_foudre = 0;
                    fire_game = true;
                    fire_wall.pos.x = 0;
                    for (int j = projectiles.size()-1; j > -1; j--) {
                        projectiles.remove(j);
                    }
                    for (int j = red_champs.size()-1; j > -1; j--) {
                        red_champs.remove(j);
                    }
                    for (int j = green_champs.size()-1; j > -1; j--) {
                        green_champs.remove(j);
                    }
                    for (int j = etoiles.size()-1; j > -1; j--) {
                        etoiles.remove(j);
                    }
                    for (int j = eclairs.size()-1; j > -1; j--) {
                        eclairs.remove(j);
                    }
                    for (int j = mega_champs.size()-1; j > -1; j--) {
                        mega_champs.remove(j);
                    }
                    for (int j = king_boos.size()-1; j > -1; j--) {
                        king_boos.remove(j);
                    }
                    balle.vel_x_precedente = balle.vel.x;
                    balle.vel.x = 0;
                    balle.vel.y = 0;
                    balle.pos.y = height/2;
                    balle.pos.x = -10 * width - mur1.weed * 2;
                    balle.acc.x = 0;
                    balle.acc.y = 0;
                }
            }
            else if (player2.objet_stocke == "ice_mario") {
                player2.objet_stocke = "";
                player2.est_objet_stocke = false;
                player2.est_en_ice = 3;
                player2.est_en_feu = 0;
                player2.est_gele = 0;
            }
        }
        if (key == 'z' && player1.est_objet_stocke) {
            if (player1.objet_stocke == "king_boo") {
                player1.objet_stocke = "";
                player1.est_objet_stocke = false;
                balle.est_invisible = abs(duree_invisiblite - 3*PApplet.parseInt(abs(balle.vel.x* width / 1300)));
                king_boos.add(new Objet_au_sol(new PVector(player1.pos.x + player1.weed, height - size_king_boo), new PVector(5* width / 1300,0), new PVector(0,0), size_king_boo, "king_boo"));
            }
            else if (player1.objet_stocke == "fire_mario") {
                if (player2.est_cheate == 0) {
                    player1.objet_stocke = "";
                    player1.est_objet_stocke = false;
                    if (player2.objet_stocke == "fire_mario")
                        player2.objet_stocke = "";
                        player2.est_objet_stocke = false;
                    player1.est_en_ice = 0;
                    player1.est_gele = 0;
                    player1.est_geant = 0;
                    player1.est_foudre = 0;
                    player1.est_en_feu = 3;
                    fire_game = true;
                    fire_wall.pos.x = width-fire_wall.weed;
                    for (int j = projectiles.size()-1; j > -1; j--) {
                        projectiles.remove(j);
                    }
                    for (int j = red_champs.size()-1; j > -1; j--) {
                        red_champs.remove(j);
                    }
                    for (int j = green_champs.size()-1; j > -1; j--) {
                        green_champs.remove(j);
                    }
                    for (int j = etoiles.size()-1; j > -1; j--) {
                        etoiles.remove(j);
                    }
                    for (int j = eclairs.size()-1; j > -1; j--) {
                        eclairs.remove(j);
                    }
                    for (int j = mega_champs.size()-1; j > -1; j--) {
                        mega_champs.remove(j);
                    }
                    for (int j = king_boos.size()-1; j > -1; j--) {
                        king_boos.remove(j);
                    }
                    balle.vel_x_precedente = balle.vel.x;
                    balle.vel.x = 0;
                    balle.vel.y = 0;
                    balle.pos.y = width / 2;
                    balle.pos.x = 10 * width + mur2.weed * 2;
                    balle.acc.x = 0;
                    balle.acc.y = 0;
                }
            }
            else if (player1.objet_stocke == "ice_mario") {
                player1.objet_stocke = "";
                player1.est_objet_stocke = false;
                player1.est_en_ice = 3;
                player1.est_en_feu = 0;
                player1.est_gele = 0;
            }
        }
        if (key == 'l' && balle.vel.x <= 0 && projectiles.size() < 3 && !balle.press_p) {
            if (player2.est_en_feu > 0) {
                player2.est_en_feu -= 1;
                projectiles.add(new Projectile(new PVector(player2.pos.x - projectile_size - 1* width / 1300, player2.pos.y + player2.heil/2 - projectile_size/2), new PVector(-vel_fire_bullet, 0), new PVector(-acc_fire_bullet, 0), projectile_size, "fire_bullet"));
            }
            else if (player2.est_en_ice > 0) {
                player2.est_en_ice -= 1;
                projectiles.add(new Projectile(new PVector(player2.pos.x - projectile_size - 1* width / 1300, player2.pos.y + player2.heil/2 - projectile_size/2), new PVector(-vel_ice_bullet, 0), new PVector(-acc_ice_bullet, 0), projectile_size, "ice_bullet"));
            }
            else {
                projectiles.add(new Projectile(new PVector(player2.pos.x - projectile_size - 1* width / 1300, player2.pos.y + player2.heil/2 - projectile_size/2), new PVector(-vel_normal_bullet, 0), new PVector(-acc_normal_bullet, 0), projectile_size, "normal_bullet"));
            }
        }
        if (key == 's' && balle.vel.x >= 0 && projectiles.size() < 3 && !balle.press_p) {
            if (player1.est_en_feu > 0) {
                player1.est_en_feu -= 1;
                projectiles.add(new Projectile(new PVector(player1.pos.x + player1.weed + 1, player1.pos.y + player1.heil/2 - projectile_size/2), new PVector(vel_fire_bullet, 0), new PVector(acc_fire_bullet, 0), projectile_size, "fire_bullet"));
            }
            else if (player1.est_en_ice > 0) {
                player1.est_en_ice -= 1;
                projectiles.add(new Projectile(new PVector(player1.pos.x + player1.weed + 1, player1.pos.y + player1.heil/2 - projectile_size/2), new PVector(vel_ice_bullet, 0), new PVector(acc_ice_bullet, 0), projectile_size, "ice_bullet"));
            }
            else {
                projectiles.add(new Projectile(new PVector(player1.pos.x + player1.weed + 1, player1.pos.y + player1.heil/2 - projectile_size/2), new PVector(vel_normal_bullet, 0), new PVector(acc_normal_bullet, 0), projectile_size, "normal_bullet"));
            }
        }
    }
    else {
        if (!player1_name_validate) {
            if (keyCode == ENTER) {
                player1_name_validate = true;
            }
        }
        else {
            if (!player2_na_validate) {
                if (keyCode == ENTER) {
                    player2_na_validate = true;
                }
            }
            else {
                if (keyCode == ENTER) {
                    settings_done = true;
                    setup();
                }
            }
        }
    }
}

public void keyReleased() {
    if (settings_done) {
        if (key == 'p') {
            player2.vel.y = 0;
        }
        if (key == 'm') {
            player2.vel.y = 0;
        }
        if (key == 'a') {
            player1.vel.y = 0;
        }
        if (key == 'q') {
            player1.vel.y = 0;
        }   
    }
}

public void make_text_player1() {
    final float ratio = 0.6f;
    textFont(rubber_biscuit);
    textSize(60);

    name_player_1_graphics = createGraphics( PApplet.parseInt(textWidth(player1_name)) , 60); 

    name_player_1_graphics.noSmooth();
    name_player_1_graphics.beginDraw();
    name_player_1_graphics.fill(255,165,0);
    name_player_1_graphics.loadPixels();
    name_player_1_graphics.textAlign(LEFT,TOP);
    name_player_1_graphics.textFont(rubber_biscuit);
    name_player_1_graphics.textSize(60);
    name_player_1_graphics.text(player1_name, 0, 0);
    name_player_1_graphics.endDraw();
    
    for (int pixel = 0; pixel < (name_player_1_graphics.pixels.length * ratio); pixel++) {
        if (name_player_1_graphics.pixels[pixel] == color(255,165,0)) {
            name_player_1_graphics.pixels[pixel] = color(255,255,0);
        }
    }
}
public void make_text_player2() {
    final float ratio = 0.6f;
    textFont(rubber_biscuit);
    textSize(80);


    name_player_2_graphics = createGraphics( PApplet.parseInt(textWidth("Joueur2")) , 80); 

    

    name_player_2_graphics.noSmooth();
    name_player_2_graphics.beginDraw();
    name_player_2_graphics.fill(255,165,0);
    name_player_2_graphics.loadPixels();
    name_player_2_graphics.textAlign(LEFT,TOP);
    name_player_2_graphics.textFont(rubber_biscuit);
    name_player_2_graphics.textSize(80);
    name_player_2_graphics.text("Joueur2", 0, 0);
    name_player_2_graphics.endDraw();
    
    for (int pixel = 0; pixel < (name_player_2_graphics.pixels.length * ratio); pixel++) {
        if (name_player_2_graphics.pixels[pixel] == color(255,165,0)) {
            name_player_2_graphics.pixels[pixel] = color(255,255,0);
        }
    }
}
  class Balle {
    PVector pos;
    PVector vel;
    PVector acc;
    int size;
    int random_objet_ind;
    int random;
    int compteur_size;
    int health;
    float vel_x_precedente;
    boolean press_p;
    int est_invisible;

    Balle(PVector pos_, PVector vel_, PVector acc_, int size_) {
        pos = pos_;
        vel = vel_;
        acc = acc_;
        size = size_;
        random = PApplet.parseInt(random(2,4));
        compteur_size = 0;
        est_invisible = 0;
        vel_x_precedente = 0;
        press_p = false;
    }

    public void update () {
        vel.add(acc);
        pos.add(vel);
        if (fire_game) {
            player1.heil= starting_heil;
            player2.heil = starting_heil;
            if (player1.est_en_feu == 0 && player2.est_en_feu == 0) {
                fire_game = false;
                for (Projectile bullet : projectiles) {
                    fire_game = fire_game || (bullet.projectile_type == "fire_bullet");
                }
                if (!fire_game) {
                    pos.x = width/2;
                    pos.y = height/2;
                    vel.x = vel_x_precedente;
                    vel.y = 0;
                    player1.pos.y = height / 2 - global_heil1/2;
                    player2.pos.y = height/2 - global_heil2/2;
                    fire_wall.pos.x = width + 2*mur_weed;
                }
            }
        }
        if (pos.y + size/2 >= height)  {
            vel.y = -vel.y;
            pos.y = height - size/2;
        }
        if (pos.y - size/2 <= 0) {
            vel.y = -vel.y;
            pos.y = size/2;
        }
        if (pos.x >= width && player1.est_en_feu == 0 && player2.est_en_feu == 0 && !press_p && !fire_game) {
            score2 -= 1;
            acc.x = 0;
            acc.y = 0;
            vel.x = 0;
            vel.y = 0;
            pos.x = width-1;
            press_p = true;
        }
        if (pos.x <= 0 && player1.est_en_feu == 0 && player2.est_en_feu == 0 && !press_p && !fire_game) {
            score1 -= 1;
            acc.x = 0;
            acc.y = 0;
            vel.x = 0;
            vel.y = 0;
            pos.x = 1;
            press_p = true;
        }
        bounce1(player1);
        bounce2(player2);
        bounce_mur_1();
        bounce_mur_2();
        if (apparition_objet == random) {
            random_objet_ind = PApplet.parseInt(random(0, 87));
            if (0 <= random_objet_ind && random_objet_ind < 7) {
                if (objet_changement_direction.est_gele == 0) {
                    objet_changement_direction.vel.y = vel_cube;
                }
            }
            else if (7 <= random_objet_ind && random_objet_ind < 12) {
                if (objet_fire_mario.est_gele == 0) {
                    objet_fire_mario.vel.y = vel_cube;
                }
            }
            else if (12 <= random_objet_ind && random_objet_ind < 22) {
                if (objet_king_boo.est_gele == 0) {            
                    objet_king_boo.vel.y = vel_cube;
                }
            }
            else if (22 <= random_objet_ind && random_objet_ind < 33) {
                if (objet_etoile.est_gele == 0) {
                    objet_etoile.vel.y = vel_cube;
                }
            }
            else if (33 <= random_objet_ind && random_objet_ind < 42) {
                if (objet_platforme_maudite_boost.est_gele == 0) {
                    objet_platforme_maudite_boost.vel.y = vel_cube;
                }
            }
            else if (42 <= random_objet_ind && random_objet_ind < 52) {
                if (objet_ice_mario.est_gele == 0) {
                    objet_ice_mario.vel.y = vel_cube;
                }
            }
            else if (52 <= random_objet_ind && random_objet_ind < 63) {
                if (objet_eclair.est_gele == 0) {
                    objet_eclair.vel.y = vel_cube;
                }
            }
            else if (63 <= random_objet_ind && random_objet_ind < 75) {
                if (objet_mega_champ.est_gele == 0) {
                    objet_mega_champ.vel.y = vel_cube;
                }
            }
            else if (75 <= random_objet_ind && random_objet_ind < 83) {
                if (objet_red_champ.est_gele == 0) {
                    objet_red_champ.vel.y = vel_cube;
                }
            }
            else if (83 <= random_objet_ind && random_objet_ind < 87) {
                if (objet_green_champ.est_gele == 0) {
                    objet_green_champ.vel.y =vel_cube;
                }
            }
            apparition_objet = 0;
            random = PApplet.parseInt(random(1,3));
            if (compteur_size >= 4) {
                size = size_ball;
                compteur_size = 0;
            }
        }
        touch(objet_changement_direction);
        touch(objet_fire_mario);
        touch(objet_king_boo);
        touch(objet_etoile);
        touch(objet_platforme_maudite_boost);
        touch(objet_ice_mario);
        touch(objet_eclair);
        touch(objet_mega_champ);
        touch(objet_red_champ);
        touch(objet_green_champ);
    } 
    
    public void show () {
        stroke(0);
        if (est_invisible > 0) {
            est_invisible -= 1;
            tint(255,0);
            image(green_shell, pos.x - size/2, pos.y - size/2, size, size);
        }
        else if (abs(vel.x) <= 12* width / 1300) {
            ballcolor = color(255, 255-30*health, 255-30*health);
            tint(ballcolor);
            image(green_shell, pos.x - size/2, pos.y - size/2, size, size);
        }
        else if (abs(vel.x) <= 15* width / 1300) {
            image(red_shell, pos.x - size/2, pos.y - size/2, size, size);
        }
        else {
            image(blue_shell,pos.x - size/2, pos.y - size/2, 1.5f*size, 1.5f*size);
        }
    }

    public void bounce1(Player player) {
        if (pos.y > player.pos.y && pos.y < player.pos.y + player.heil && pos.x - size/2 <= player.pos.x + player.weed && player1.est_en_feu == 0 && player2.est_en_feu == 0 && !press_p && !fire_game) {
            if (abs(player.pos.y + (player.heil)/2 -pos.y) == 0){
                vel.x = abs(vel.x);
                acc.x = abs(acc.x);
                vel.y = 0;
                pos.x = player.pos.x + player.weed + size/2;
                ballcolor = color(255,255,255);
                apparition_objet ++;
                compteur_size ++;
                if (player1.est_foudre >0) {
                    player1.est_foudre -=1;
                    if (player1.est_foudre == 0){
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_foudre >0) {
                    player2.est_foudre -=1;
                    if (player2.est_foudre == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_gele >0) {
                    player1.est_gele -=1;
                    if (player1.est_gele == 0) {
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_gele >0) {
                    player2.est_gele -=1;
                    if (player2.est_gele == 0) {
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_geant >0) {
                    player1.est_geant -=1;
                    if (player1.est_geant == 0) {
                        player1.heil = global_heil1;
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_geant >0) {
                    player2.est_geant -=1;
                    if (player2.est_geant == 0) {
                        player2.heil = global_heil2;
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_pas_geant >0) {
                    player1.est_pas_geant -=1;
                    if (player1.est_pas_geant == 0) {
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_pas_geant >0) {
                    player2.est_pas_geant -=1;
                    if (player2.est_pas_geant == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_cheate >0) {
                    player1.est_cheate -=1;
                    if (player1.est_cheate == 0) {
                        mur1.pos.x = -2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (player2.est_cheate >0) {
                    player2.est_cheate-=1;
                    if (player2.est_cheate == 0) {
                        mur2.pos.x = width + 2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (objet_changement_direction.est_gele >0) {
                    objet_changement_direction.est_gele -=1;
                    if (objet_changement_direction.est_gele == 0) {
                        objet_changement_direction.vel.y = vel_cube;
                    }
                }
                if (objet_eclair.est_gele >0) {
                    objet_eclair.est_gele -=1;
                    if (objet_eclair.est_gele == 0) {
                        objet_eclair.vel.y = vel_cube;
                    }
                }
                if (objet_etoile.est_gele >0) {
                    objet_etoile.est_gele -=1;
                    if (objet_etoile.est_gele == 0) {
                        objet_etoile.vel.y = vel_cube;
                    }
                }
                if (objet_fire_mario.est_gele >0) {
                    objet_fire_mario.est_gele -=1;
                    if (objet_fire_mario.est_gele == 0) {
                        objet_fire_mario.vel.y = vel_cube;
                    }
                }
                if (objet_green_champ.est_gele >0) {
                    objet_green_champ.est_gele -=1;
                    if (objet_green_champ.est_gele == 0) {
                        objet_green_champ.vel.y = vel_cube;
                    }
                }
                if (objet_ice_mario.est_gele >0) {
                    objet_ice_mario.est_gele -=1;
                    if (objet_ice_mario.est_gele == 0) {
                        objet_ice_mario.vel.y = vel_cube;
                    }
                }
                if (objet_king_boo.est_gele >0) {
                    objet_king_boo.est_gele -=1;
                    if (objet_king_boo.est_gele == 0) {
                        objet_king_boo.vel.y = vel_cube;
                    }
                }
                if (objet_mega_champ.est_gele >0) {
                    objet_mega_champ.est_gele -=1;
                    if (objet_mega_champ.est_gele == 0) {
                        objet_mega_champ.vel.y = vel_cube;
                    }
                }
                if (objet_platforme_maudite_boost.est_gele >0) {
                    objet_platforme_maudite_boost.est_gele -=1;
                    if (objet_platforme_maudite_boost.est_gele == 0) {
                        objet_platforme_maudite_boost.vel.y = vel_cube;
                    }
                }
                if (objet_red_champ.est_gele >0) {
                    objet_red_champ.est_gele -=1;
                    if (objet_red_champ.est_gele == 0) {
                        objet_red_champ.vel.y = vel_cube;
                    }
                }
                player1.update();
                player1.show();
                player2.update();
                player2.show();
                est_invisible = 0;
                is_foudre_falling = false;
            }
            else {
                vel.x = abs(vel.x);
                acc.x = abs(acc.x);
                vel.y = -(player.pos.y + (player.heil)/2 -pos.y) / player.heil * 15;
                pos.x = player.pos.x + player.weed + size/2;
                ballcolor = color(255,255,255);
                apparition_objet ++;
                compteur_size ++;
                if (player1.est_foudre >0) {
                    player1.est_foudre -=1;
                    if (player1.est_foudre == 0){
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_foudre >0) {
                    player2.est_foudre -=1;
                    if (player2.est_foudre == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_gele >0) {
                    player1.est_gele -=1;
                    if (player1.est_gele == 0) {
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_gele >0) {
                    player2.est_gele -=1;
                    if (player2.est_gele == 0) {
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_geant >0) {
                    player1.est_geant -=1;
                    if (player1.est_geant == 0) {
                        player1.heil = global_heil1;
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_geant >0) {
                    player2.est_geant -=1;
                    if (player2.est_geant == 0) {
                        player2.heil = global_heil2;
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_pas_geant >0) {
                    player1.est_pas_geant -=1;
                    if (player1.est_pas_geant == 0) {
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_pas_geant >0) {
                    player2.est_pas_geant -=1;
                    if (player2.est_pas_geant == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_cheate >0) {
                    player1.est_cheate -=1;
                    if (player1.est_cheate == 0) {
                        mur1.pos.x = -2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (player2.est_cheate >0) {
                    player2.est_cheate-=1;
                    if (player2.est_cheate == 0) {
                        mur2.pos.x = width + 2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (objet_changement_direction.est_gele >0) {
                    objet_changement_direction.est_gele -=1;
                    if (objet_changement_direction.est_gele == 0) {
                        objet_changement_direction.vel.y = vel_cube;
                    }
                }
                if (objet_eclair.est_gele >0) {
                    objet_eclair.est_gele -=1;
                    if (objet_eclair.est_gele == 0) {
                        objet_eclair.vel.y = vel_cube;
                    }
                }
                if (objet_etoile.est_gele >0) {
                    objet_etoile.est_gele -=1;
                    if (objet_etoile.est_gele == 0) {
                        objet_etoile.vel.y = vel_cube;
                    }
                }
                if (objet_fire_mario.est_gele >0) {
                    objet_fire_mario.est_gele -=1;
                    if (objet_fire_mario.est_gele == 0) {
                        objet_fire_mario.vel.y = vel_cube;
                    }
                }
                if (objet_green_champ.est_gele >0) {
                    objet_green_champ.est_gele -=1;
                    if (objet_green_champ.est_gele == 0) {
                        objet_green_champ.vel.y = vel_cube;
                    }
                }
                if (objet_ice_mario.est_gele >0) {
                    objet_ice_mario.est_gele -=1;
                    if (objet_ice_mario.est_gele == 0) {
                        objet_ice_mario.vel.y = vel_cube;
                    }
                }
                if (objet_king_boo.est_gele >0) {
                    objet_king_boo.est_gele -=1;
                    if (objet_king_boo.est_gele == 0) {
                        objet_king_boo.vel.y = vel_cube;
                    }
                }
                if (objet_mega_champ.est_gele >0) {
                    objet_mega_champ.est_gele -=1;
                    if (objet_mega_champ.est_gele == 0) {
                        objet_mega_champ.vel.y = vel_cube;
                    }
                }
                if (objet_platforme_maudite_boost.est_gele >0) {
                    objet_platforme_maudite_boost.est_gele -=1;
                    if (objet_platforme_maudite_boost.est_gele == 0) {
                        objet_platforme_maudite_boost.vel.y = vel_cube;
                    }
                }
                if (objet_red_champ.est_gele >0) {
                    objet_red_champ.est_gele -=1;
                    if (objet_red_champ.est_gele == 0) {
                        objet_red_champ.vel.y = vel_cube;
                    }
                }
                player1.update();
                player1.show();
                player2.update();
                player2.show();
                est_invisible = 0;
                is_foudre_falling = false;
            }
            for (int j = red_champs.size()-1; j > -1; j--) {
                red_champs.get(j).est_touch = false;
            }
            for (int j = green_champs.size()-1; j > -1; j--) {
                green_champs.get(j).est_touch = false;
            }
            for (int j = etoiles.size()-1; j > -1; j--) {
                etoiles.get(j).est_touch = false;
            }
            for (int j = mega_champs.size()-1; j > -1; j--) {
                mega_champs.get(j).est_touch = false;
            }
        }
    }
    public void bounce2(Player player) {
        if (pos.y > player.pos.y && pos.y < player.pos.y + player.heil && pos.x + size/2 >= player.pos.x && player1.est_en_feu == 0 && player2.est_en_feu == 0 && !press_p && !fire_game) {
            if (abs(player.pos.y + (player.heil) / 2 - pos.y) == 0){
                vel.x = -abs(vel.x);
                acc.x = -abs(acc.x);
                vel.y = 0;
                pos.x = player.pos.x - size/2;
                ballcolor = color(255,255,255);
                apparition_objet +=1;
                compteur_size ++;
                if (player1.est_foudre >0) {
                    player1.est_foudre -=1;
                    if (player1.est_foudre == 0){
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_foudre >0) {
                    player2.est_foudre -=1;
                    if (player2.est_foudre == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_gele >0) {
                    player1.est_gele -=1;
                    if (player1.est_gele == 0) {
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_gele >0) {
                    player2.est_gele -=1;
                    if (player2.est_gele == 0) {
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_geant >0) {
                    player1.est_geant -=1;
                    if (player1.est_geant == 0) {
                        player1.heil = global_heil1;
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_geant >0) {
                    player2.est_geant -=1;
                    if (player2.est_geant == 0) {
                        player2.heil = global_heil2;
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_pas_geant >0) {
                    player1.est_pas_geant -=1;
                    if (player1.est_pas_geant == 0) {
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_pas_geant >0) {
                    player2.est_pas_geant -=1;
                    if (player2.est_pas_geant == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_cheate >0) {
                    player1.est_cheate -=1;
                    if (player1.est_cheate == 0) {
                        mur1.pos.x = -2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (player2.est_cheate >0) {
                    player2.est_cheate-=1;
                    if (player2.est_cheate == 0) {
                        mur2.pos.x = width + 2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (objet_changement_direction.est_gele >0) {
                    objet_changement_direction.est_gele -=1;
                    if (objet_changement_direction.est_gele == 0) {
                        objet_changement_direction.vel.y = vel_cube;
                    }
                }
                if (objet_eclair.est_gele >0) {
                    objet_eclair.est_gele -=1;
                    if (objet_eclair.est_gele == 0) {
                        objet_eclair.vel.y = vel_cube;
                    }
                }
                if (objet_etoile.est_gele >0) {
                    objet_etoile.est_gele -=1;
                    if (objet_etoile.est_gele == 0) {
                        objet_etoile.vel.y = vel_cube;
                    }
                }
                if (objet_fire_mario.est_gele >0) {
                    objet_fire_mario.est_gele -=1;
                    if (objet_fire_mario.est_gele == 0) {
                        objet_fire_mario.vel.y = vel_cube;
                    }
                }
                if (objet_green_champ.est_gele >0) {
                    objet_green_champ.est_gele -=1;
                    if (objet_green_champ.est_gele == 0) {
                        objet_green_champ.vel.y = vel_cube;
                    }
                }
                if (objet_ice_mario.est_gele >0) {
                    objet_ice_mario.est_gele -=1;
                    if (objet_ice_mario.est_gele == 0) {
                        objet_ice_mario.vel.y = vel_cube;
                    }
                }
                if (objet_king_boo.est_gele >0) {
                    objet_king_boo.est_gele -=1;
                    if (objet_king_boo.est_gele == 0) {
                        objet_king_boo.vel.y = vel_cube;
                    }
                }
                if (objet_mega_champ.est_gele >0) {
                    objet_mega_champ.est_gele -=1;
                    if (objet_mega_champ.est_gele == 0) {
                        objet_mega_champ.vel.y = vel_cube;
                    }
                }
                if (objet_platforme_maudite_boost.est_gele >0) {
                    objet_platforme_maudite_boost.est_gele -=1;
                    if (objet_platforme_maudite_boost.est_gele == 0) {
                        objet_platforme_maudite_boost.vel.y = vel_cube;
                    }
                }
                if (objet_red_champ.est_gele >0) {
                    objet_red_champ.est_gele -=1;
                    if (objet_red_champ.est_gele == 0) {
                        objet_red_champ.vel.y = vel_cube;
                    }
                }
                player1.update();
                player1.show();
                player2.update();
                player2.show();
                est_invisible = 0;
                is_foudre_falling = false;
            }
            else {
                vel.x = -abs(vel.x);
                acc.x = -abs(acc.x);
                vel.y = -(player.pos.y + (player.heil) / 2 - pos.y) / player.heil * 15;;
                pos.x = player.pos.x - size/2;
                ballcolor = color(255,255,255);
                apparition_objet +=1;
                compteur_size ++;
                if (player1.est_foudre >0) {
                    player1.est_foudre -=1;
                    if (player1.est_foudre == 0){
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_foudre >0) {
                    player2.est_foudre -=1;
                    if (player2.est_foudre == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_gele >0) {
                    player1.est_gele -=1;
                    if (player1.est_gele == 0) {
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_gele >0) {
                    player2.est_gele -=1;
                    if (player2.est_gele == 0) {
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_geant >0) {
                    player1.est_geant -=1;
                    if (player1.est_geant == 0) {
                        player1.heil = global_heil1;
                        player1.vel_max = 10 * width / 1300;
                    }
                }
                if (player2.est_geant >0) {
                    player2.est_geant -=1;
                    if (player2.est_geant == 0) {
                        player2.heil = global_heil2;
                        player2.vel_max = 10 * width / 1300;
                    }
                }
                if (player1.est_pas_geant >0) {
                    player1.est_pas_geant -=1;
                    if (player1.est_pas_geant == 0) {
                        player1.heil = global_heil1;
                    }
                }
                if (player2.est_pas_geant >0) {
                    player2.est_pas_geant -=1;
                    if (player2.est_pas_geant == 0) {
                        player2.heil = global_heil2;
                    }
                }
                if (player1.est_cheate >0) {
                    player1.est_cheate -=1;
                    if (player1.est_cheate == 0) {
                        mur1.pos.x = -2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (player2.est_cheate >0) {
                    player2.est_cheate-=1;
                    if (player2.est_cheate == 0) {
                        mur2.pos.x = width + 2*mur_weed;
                        if (vel.x <0) {
                            vel.x = -vel_x_precedente ;
                        }
                        else {
                            vel.x = vel_x_precedente;
                        }
                        vel_x_precedente = 0;
                        acc.x = 0;
                    }
                }
                if (objet_changement_direction.est_gele >0) {
                    objet_changement_direction.est_gele -=1;
                    if (objet_changement_direction.est_gele == 0) {
                        objet_changement_direction.vel.y = vel_cube;
                    }
                }
                if (objet_eclair.est_gele >0) {
                    objet_eclair.est_gele -=1;
                    if (objet_eclair.est_gele == 0) {
                        objet_eclair.vel.y = vel_cube;
                    }
                }
                if (objet_etoile.est_gele >0) {
                    objet_etoile.est_gele -=1;
                    if (objet_etoile.est_gele == 0) {
                        objet_etoile.vel.y = vel_cube;
                    }
                }
                if (objet_fire_mario.est_gele >0) {
                    objet_fire_mario.est_gele -=1;
                    if (objet_fire_mario.est_gele == 0) {
                        objet_fire_mario.vel.y = vel_cube;
                    }
                }
                if (objet_green_champ.est_gele >0) {
                    objet_green_champ.est_gele -=1;
                    if (objet_green_champ.est_gele == 0) {
                        objet_green_champ.vel.y = vel_cube;
                    }
                }
                if (objet_ice_mario.est_gele >0) {
                    objet_ice_mario.est_gele -=1;
                    if (objet_ice_mario.est_gele == 0) {
                        objet_ice_mario.vel.y = vel_cube;
                    }
                }
                if (objet_king_boo.est_gele >0) {
                    objet_king_boo.est_gele -=1;
                    if (objet_king_boo.est_gele == 0) {
                        objet_king_boo.vel.y = vel_cube;
                    }
                }
                if (objet_mega_champ.est_gele >0) {
                    objet_mega_champ.est_gele -=1;
                    if (objet_mega_champ.est_gele == 0) {
                        objet_mega_champ.vel.y = vel_cube;
                    }
                }
                if (objet_platforme_maudite_boost.est_gele >0) {
                    objet_platforme_maudite_boost.est_gele -=1;
                    if (objet_platforme_maudite_boost.est_gele == 0) {
                        objet_platforme_maudite_boost.vel.y = vel_cube;
                    }
                }
                if (objet_red_champ.est_gele >0) {
                    objet_red_champ.est_gele -=1;
                    if (objet_red_champ.est_gele == 0) {
                        objet_red_champ.vel.y = vel_cube;
                    }
                }
                player1.update();
                player1.show();
                player2.update();
                player2.show();
                est_invisible = 0;
                is_foudre_falling = false;
            }
            for (int j = red_champs.size()-1; j > -1; j--) {
                red_champs.get(j).est_touch = false;
            }
            for (int j = green_champs.size()-1; j > -1; j--) {
                green_champs.get(j).est_touch = false;
            }
            for (int j = etoiles.size()-1; j > -1; j--) {
                etoiles.get(j).est_touch = false;
            }
            for (int j = mega_champs.size()-1; j > -1; j--) {
                mega_champs.get(j).est_touch = false;
            }
        }
    }
    public void bounce_mur_1() {
        if (pos.x - size/2 <= mur1.pos.x + mur1.weed  && player1.est_en_feu == 0 && player2.est_en_feu == 0 && !press_p && !fire_game) {
            vel.x = abs(vel.x);
            acc.x = abs(acc.x);
            pos.x = mur1.pos.x + mur1.weed + size/2;
            apparition_objet ++;
            compteur_size ++;
            if (player1.est_foudre >0) {
                player1.est_foudre -=1;
                if (player1.est_foudre == 0){
                    player1.heil = global_heil1;
                }
            }
            if (player2.est_foudre >0) {
                player2.est_foudre -=1;
                if (player2.est_foudre == 0) {
                    player2.heil = global_heil2;
                }
            }
            if (player1.est_gele >0) {
                player1.est_gele -=1;
                if (player1.est_gele == 0) {
                    player1.vel_max = 10 * width / 1300;
                }
            }
            if (player2.est_gele >0) {
                player2.est_gele -=1;
                if (player2.est_gele == 0) {
                    player2.vel_max = 10 * width / 1300;
                }
            }
            if (player1.est_geant >0) {
                player1.est_geant -=1;
                if (player1.est_geant == 0) {
                    player1.heil = global_heil1;
                    player1.vel_max = 10 * width / 1300;
                }
            }
            if (player2.est_geant >0) {
                player2.est_geant -=1;
                if (player2.est_geant == 0) {
                    player2.heil = global_heil2;
                    player2.vel_max = 10 * width / 1300;
                }
            }
            if (player1.est_pas_geant >0) {
                player1.est_pas_geant -=1;
                if (player1.est_pas_geant == 0) {
                    player1.heil = global_heil1;
                }
            }
            if (player2.est_pas_geant >0) {
                player2.est_pas_geant -=1;
                if (player2.est_pas_geant == 0) {
                    player2.heil = global_heil2;
                }
            }
            if (player1.est_cheate >0) {
                player1.est_cheate -=1;
                if (player1.est_cheate == 0) {
                    mur1.pos.x = -2*mur_weed;
                    if (vel.x <0) {
                        vel.x = -vel_x_precedente ;
                    }
                    else {
                        vel.x = vel_x_precedente;
                    }
                    vel_x_precedente = 0;
                    acc.x = 0;
                }
            }
            if (player2.est_cheate >0) {
                player2.est_cheate-=1;
                if (player2.est_cheate == 0) {
                    mur2.pos.x = width + 2*mur_weed;
                    if (vel.x <0) {
                        vel.x = -vel_x_precedente ;
                    }
                    else {
                        vel.x = vel_x_precedente;
                    }
                    vel_x_precedente = 0;
                    acc.x = 0;
                }
            }
            if (objet_changement_direction.est_gele >0) {
                objet_changement_direction.est_gele -=1;
                if (objet_changement_direction.est_gele == 0) {
                    objet_changement_direction.vel.y = vel_cube;
                }
            }
            if (objet_eclair.est_gele >0) {
                objet_eclair.est_gele -=1;
                if (objet_eclair.est_gele == 0) {
                    objet_eclair.vel.y = vel_cube;
                }
            }
            if (objet_etoile.est_gele >0) {
                objet_etoile.est_gele -=1;
                if (objet_etoile.est_gele == 0) {
                    objet_etoile.vel.y = vel_cube;
                }
            }
            if (objet_fire_mario.est_gele >0) {
                objet_fire_mario.est_gele -=1;
                if (objet_fire_mario.est_gele == 0) {
                    objet_fire_mario.vel.y = vel_cube;
                }
            }
            if (objet_green_champ.est_gele >0) {
                objet_green_champ.est_gele -=1;
                if (objet_green_champ.est_gele == 0) {
                    objet_green_champ.vel.y = vel_cube;
                }
            }
            if (objet_ice_mario.est_gele >0) {
                objet_ice_mario.est_gele -=1;
                if (objet_ice_mario.est_gele == 0) {
                    objet_ice_mario.vel.y = vel_cube;
                }
            }
            if (objet_king_boo.est_gele >0) {
                objet_king_boo.est_gele -=1;
                if (objet_king_boo.est_gele == 0) {
                    objet_king_boo.vel.y = vel_cube;
                }
            }
            if (objet_mega_champ.est_gele >0) {
                objet_mega_champ.est_gele -=1;
                if (objet_mega_champ.est_gele == 0) {
                    objet_mega_champ.vel.y = vel_cube;
                }
            }
            if (objet_platforme_maudite_boost.est_gele >0) {
                objet_platforme_maudite_boost.est_gele -=1;
                if (objet_platforme_maudite_boost.est_gele == 0) {
                    objet_platforme_maudite_boost.vel.y = vel_cube;
                }
            }
            if (objet_red_champ.est_gele >0) {
                objet_red_champ.est_gele -=1;
                if (objet_red_champ.est_gele == 0) {
                    objet_red_champ.vel.y = vel_cube;
                }
            }
            player1.update();
            player1.show();
            player2.update();
            player2.show();
            est_invisible = 0;
            is_foudre_falling = false;
            for (int j = red_champs.size()-1; j > -1; j--) {
                red_champs.get(j).est_touch = false;
            }
            for (int j = green_champs.size()-1; j > -1; j--) {
                green_champs.get(j).est_touch = false;
            }
            for (int j = etoiles.size()-1; j > -1; j--) {
                etoiles.get(j).est_touch = false;
            }
            for (int j = mega_champs.size()-1; j > -1; j--) {
                mega_champs.get(j).est_touch = false;
            }
        }
    }
    public void bounce_mur_2() {
        if (pos.x + size/2 >= mur2.pos.x  && player1.est_en_feu == 0 && player2.est_en_feu == 0 && !press_p && !fire_game) {
            vel.x = -abs(vel.x);
            acc.x = -abs(acc.x);
            pos.x = mur2.pos.x - size/2;
            apparition_objet ++;
            compteur_size ++;
            if (player1.est_foudre >0) {
                player1.est_foudre -=1;
                if (player1.est_foudre == 0){
                    player1.heil = global_heil1;
                }
            }
            if (player2.est_foudre >0) {
                player2.est_foudre -=1;
                if (player2.est_foudre == 0) {
                    player2.heil = global_heil2;
                }
            }
            if (player1.est_gele >0) {
                player1.est_gele -=1;
                if (player1.est_gele == 0) {
                    player1.vel_max = 10 * width / 1300;
                }
            }
            if (player2.est_gele >0) {
                player2.est_gele -=1;
                if (player2.est_gele == 0) {
                    player2.vel_max = 10 * width / 1300;
                }
            }
            if (player1.est_geant >0) {
                player1.est_geant -=1;
                if (player1.est_geant == 0) {
                    player1.heil = global_heil1;
                    player1.vel_max = 10 * width / 1300;
                }
            }
            if (player2.est_geant >0) {
                player2.est_geant -=1;
                if (player2.est_geant == 0) {
                    player2.heil = global_heil2;
                    player2.vel_max = 10 * width / 1300;
                }
            }
            if (player1.est_pas_geant >0) {
                player1.est_pas_geant -=1;
                if (player1.est_pas_geant == 0) {
                    player1.heil = global_heil1;
                }
            }
            if (player2.est_pas_geant >0) {
                player2.est_pas_geant -=1;
                if (player2.est_pas_geant == 0) {
                    player2.heil = global_heil2;
                }
            }
            if (player1.est_cheate >0) {
                player1.est_cheate -=1;
                if (player1.est_cheate == 0) {
                    mur1.pos.x = -2*mur_weed;
                    if (vel.x <0) {
                        vel.x = -vel_x_precedente ;
                    }
                    else {
                        vel.x = vel_x_precedente;
                    }
                    vel_x_precedente = 0;
                    acc.x = 0;
                }
            }
            if (player2.est_cheate >0) {
                player2.est_cheate-=1;
                if (player2.est_cheate == 0) {
                    mur2.pos.x = width + 2*mur_weed;
                    if (vel.x <0) {
                        vel.x = -vel_x_precedente ;
                    }
                    else {
                        vel.x = vel_x_precedente;
                    }
                    vel_x_precedente = 0;
                    acc.x = 0;
                }
            }
            if (objet_changement_direction.est_gele >0) {
                objet_changement_direction.est_gele -=1;
                if (objet_changement_direction.est_gele == 0) {
                    objet_changement_direction.vel.y = vel_cube;
                }
            }
            if (objet_eclair.est_gele >0) {
                objet_eclair.est_gele -=1;
                if (objet_eclair.est_gele == 0) {
                    objet_eclair.vel.y = vel_cube;
                }
            }
            if (objet_etoile.est_gele >0) {
                objet_etoile.est_gele -=1;
                if (objet_etoile.est_gele == 0) {
                    objet_etoile.vel.y = vel_cube;
                }
            }
            if (objet_fire_mario.est_gele >0) {
                objet_fire_mario.est_gele -=1;
                if (objet_fire_mario.est_gele == 0) {
                    objet_fire_mario.vel.y = vel_cube;
                }
            }
            if (objet_green_champ.est_gele >0) {
                objet_green_champ.est_gele -=1;
                if (objet_green_champ.est_gele == 0) {
                    objet_green_champ.vel.y = vel_cube;
                }
            }
            if (objet_ice_mario.est_gele >0) {
                objet_ice_mario.est_gele -=1;
                if (objet_ice_mario.est_gele == 0) {
                    objet_ice_mario.vel.y = vel_cube;
                }
            }
            if (objet_king_boo.est_gele >0) {
                objet_king_boo.est_gele -=1;
                if (objet_king_boo.est_gele == 0) {
                    objet_king_boo.vel.y = vel_cube;
                }
            }
            if (objet_mega_champ.est_gele >0) {
                objet_mega_champ.est_gele -=1;
                if (objet_mega_champ.est_gele == 0) {
                    objet_mega_champ.vel.y = vel_cube;
                }
            }
            if (objet_platforme_maudite_boost.est_gele >0) {
                objet_platforme_maudite_boost.est_gele -=1;
                if (objet_platforme_maudite_boost.est_gele == 0) {
                    objet_platforme_maudite_boost.vel.y = vel_cube;
                }
            }
            if (objet_red_champ.est_gele >0) {
                objet_red_champ.est_gele -=1;
                if (objet_red_champ.est_gele == 0) {
                    objet_red_champ.vel.y = vel_cube;
                }
            }
            player1.update();
            player1.show();
            player2.update();
            player2.show();
            est_invisible = 0;
            is_foudre_falling = false;
            for (int j = red_champs.size()-1; j > -1; j--) {
                red_champs.get(j).est_touch = false;
            }
            for (int j = green_champs.size()-1; j > -1; j--) {
                green_champs.get(j).est_touch = false;
            }
            for (int j = etoiles.size()-1; j > -1; j--) {
                etoiles.get(j).est_touch = false;
            }
            for (int j = mega_champs.size()-1; j > -1; j--) {
                mega_champs.get(j).est_touch = false;
            }
        }
    }
    public void touch(Objet objet) {
        if (dist(pos.x, pos.y, objet.pos.x + objet.size/2, objet.pos.y + objet.size/2) <= objet.size/2 + size/2 ) {        
            if (vel.x > 0) {
                if (objet.est_gele == 0) {
                    if (objet.objet_type == "changement_direction") {
                        objet_changement_direction(player2);
                    }
                    else if (objet.objet_type == "fire_mario") {
                        fire_mario(player1);
                    }
                    else if (objet.objet_type == "king_boo") {
                        king_boo(player1);
                    }
                    else if (objet.objet_type == "etoile") {
                        etoile(player1);
                    }
                    else if (objet.objet_type == "platforme_maudite_boost") {
                        platforme_maudite_boost(player2);
                    }
                    else if (objet.objet_type == "ice_mario") {
                        ice_mario(player1);
                    }
                    else if (objet.objet_type == "eclair") {
                        eclair(player2);                    
                    }
                    else if (objet.objet_type == "mega_champ") {
                        mega_champ(player1);
                    }
                    else if (objet.objet_type == "red_champ") {
                        red_champ(player1);
                    }
                    else if (objet.objet_type == "green_champ") {
                        green_champ(player1);
                    }
                }
                // else { A compléter
                    // 
                // }
            }
            else {
                if (objet.est_gele == 0) {
                    if (objet.objet_type == "changement_direction") {
                        objet_changement_direction(player1);
                    }
                    else if (objet.objet_type == "fire_mario") {
                        fire_mario(player2);
                    }
                    else if (objet.objet_type == "king_boo") {
                        king_boo(player2);
                    }
                    else if (objet.objet_type == "etoile") {
                        etoile(player2);
                    }
                    else if (objet.objet_type == "platforme_maudite_boost") {
                        platforme_maudite_boost(player1);
                    }
                    else if (objet.objet_type == "ice_mario") {
                        ice_mario(player2);
                    }
                    else if (objet.objet_type == "eclair") {
                        eclair(player1);                    
                    }
                    else if (objet.objet_type == "mega_champ") {
                        mega_champ(player2);
                    }
                    else if (objet.objet_type == "red_champ") {
                        red_champ(player2);
                    }
                    else if (objet.objet_type == "green_champ") {
                        green_champ(player2);
                    }
                }
                // else { A compléter
                    // 
                // }
            }
            objet.vel.y = 0;
            objet.pos.y = -size_objet;
        }
    }
    public void objet_changement_direction(Player player) {
        vel.y = -vel.y + random(2) - 1;
    }
    public void fire_mario(Player player) {
        if (player.pos.x > width/2) {
            if (!player2.est_objet_stocke) {
                player2.est_objet_stocke = true;
                player2.objet_stocke = "fire_mario";
            }
        }
        else {
            if (!player1.est_objet_stocke) {
                player1.est_objet_stocke = true;
                player1.objet_stocke = "fire_mario";
            }
        }
    }
    public void king_boo(Player player) {
        if (player.pos.x > width/2) {
            if (!player2.est_objet_stocke) {
                player2.est_objet_stocke = true;
                player2.objet_stocke = "king_boo";
            }
        }
        else {
            if (!player1.est_objet_stocke) {
                player1.est_objet_stocke = true;
                player1.objet_stocke = "king_boo";
            }
        }
    }
    public void etoile(Player player) {
        if (player.pos.x > width/2) {
            etoiles.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_etoile, "etoile"));
        }
        else {
            etoiles.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_etoile, "etoile"));
        }
    }
    public void platforme_maudite_boost(Player player) {
        player.vel_max = 20* width / 1300;
    }
    public void ice_mario(Player player) {
        if (player.pos.x > width/2) {
            if (!player2.est_objet_stocke) {
                player2.est_objet_stocke = true;
                player2.objet_stocke = "ice_mario";
            }
        }
        else {
            if (!player1.est_objet_stocke) {
                player1.est_objet_stocke = true;
                player1.objet_stocke = "ice_mario";
            }
        }
    }
    public void eclair(Player player) {
        is_foudre_falling = true;
        player.est_foudre = 4;
        player.est_geant = 0;
        player.est_pas_geant = 0;
        player.est_objet_stocke = false;
        player.objet_stocke = "";
        player.est_en_ice = 0;
        size = 15;
        compteur_size = 0;
        if (player.pos.x > width/2) {
            eclairs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(0,-3* width / 1300), new PVector(0,-0.5f* width / 1300), size_eclair, "eclair"));
        }
        else {
            eclairs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(0,-3* width / 1300), new PVector(0,-0.5f* width / 1300), size_eclair, "eclair"));
        }
    }
    public void mega_champ(Player player) {
        if (player.pos.x > width/2) {
            mega_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_mega_champ, "mega_champ"));
        }
        else {
            mega_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_mega_champ, "mega_champ"));
        }
    }
    public void red_champ(Player player) {
        if (player.pos.x > width/2) {
            red_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_red_champ, "red_champ"));
        }
        else {
            red_champs.add(new Objet_au_sol(new PVector(pos.x * width / 1300,pos.y * width / 1300), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_red_champ, "red_champ"));
        }
    }
    public void green_champ(Player player) {
        if (player.pos.x > width/2) {
            green_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_green_champ, "green_champ"));
        }
        else {
            green_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5f * width / 1300), size_green_champ, "green_champ"));
        }
    }
}
class Mur {
    PVector pos;
    int weed;
    float heil;
    String mur_type;


    Mur(PVector pos_, int weed_, float heil_, String mur_type_) {
        pos=pos_;
        weed=weed_;
        heil=heil_;
        mur_type = mur_type_;
    }

    public void show () {
        if (mur_type == "rainbow_wall") {
            for (int i = 0; i < weed; i++) {
                colorMode(HSB);
                int frame = frameCount % 255;
                stroke((map(i, 0, weed, 0, 0.25f*255) + 10*frame) % 255, 150, 255);
                line(pos.x + i, pos.y, pos.x + i, pos.y + heil);
                colorMode(RGB);
            }
        }
        if (mur_type == "fire_wall") {
            fill(255,165,0);
            stroke(255,165,0);
            
            rect(pos.x, pos.y, weed, heil);
        }
    }
}
class Objet {
    PVector pos;
    PVector vel;
    int size;
    String objet_type;
    int est_gele;

    Objet(PVector pos_, PVector vel_, int size_, String objet_type_) {
        pos = pos_;
        vel = vel_;
        size = size_;
        objet_type = objet_type_;
        est_gele = 0;
    }

    public void update () {
        pos.add(vel);
        if (est_gele > 0) {
            vel.y = 0;
        }
        if (pos.y > height) {
            vel.y = 0;
            pos.y = -size_objet;
            pos.x =  width/2 - size_objet/2;
        }
    }
    public void show () {
        stroke(0);
        if (est_gele >0) {
            image(cube, pos.x, pos.y, size, size); // A remplacer par cube_gele
        }
        else {
            image(cube, pos.x, pos.y, size, size);
        }
    }
}
class Objet_au_sol {
    PVector pos;
    PVector vel;
    PVector acc;
    int size;
    String objet_type;
    boolean dead;
    boolean est_touch;

    Objet_au_sol(PVector pos_, PVector vel_,PVector acc_, int size_, String objet_type_) {
        pos = pos_;
        vel = vel_;
        acc = acc_;
        size = size_;
        objet_type = objet_type_;
        dead = false;
        est_touch = true;
    }

    public void update () {
        pos.add(vel);
        vel.add(acc);
        if (pos.x + size/2 < player1.pos.x || pos.x + size/2 > player2.pos.x + player2.weed) {
            dead = true;
        } 
        if (objet_type == "eclair") {
            if (pos.y <= 0) {
                vel.y = 0;
                pos.y = size/2;
                dead = true;
            }
        }
        else {
            if (pos.y + size >= height) {
                acc.y = 0;
                vel.y = 0;
                pos.y = height - size;
            }
        }
        collision_platform();
        check_collision();
    }
    public void show () {
        stroke(0);
        if (objet_type == "red_champ") {
            image(red_champ,pos.x,pos.y, size, size);
        }
        else if (objet_type == "green_champ") {
            image(green_champ,pos.x,pos.y,size,size);
        }
        else if (objet_type == "etoile") {
            image(etoile,pos.x,pos.y,size,size);
        }
        else if (objet_type == "eclair") {
            image(eclair,pos.x,pos.y,size,size);
        }
        else if (objet_type == "mega_champ") {
            image(mega_champ,pos.x,pos.y,size,size);
        }
        else if (objet_type == "king_boo") {
            image(king_boo,pos.x,pos.y,size,size);
        }
    }
    public void collision_platform() {
        if (vel.x >= 0) {
            if (pos.x + size >= player2.pos.x && pos.y + size/2 > player2.pos.y && pos.y + size/2 < player2.pos.y + player2.heil) {
                dead = true;
                if (objet_type == "red_champ") {
                    global_heil2 *= 1.5f;
                    player2.heil = global_heil2;
                }
                else if (objet_type == "green_champ") {
                    score2 +=1;
                }
                else if (objet_type == "etoile") {
                    mur2.pos.x = width - mur_weed;
                    player2.est_cheate = 4;
                    if (balle.vel_x_precedente == 0) {
                        balle.vel_x_precedente = abs(balle.vel.x);
                        balle.vel.x *= 1.5f;
                    }
                }
                else if (objet_type == "mega_champ") {
                    player2.pos.y = height/4;
                    player2.est_foudre = 0;
                    balle.size = 100* width / 1300;
                    balle.compteur_size = 0;
                    player2.est_geant = 4;
                    player1.est_pas_geant = 4;
                }
            }
        }
        else {
            if (pos.x <= player1.pos.x + player1.weed && pos.y + size/2 > player1.pos.y && pos.y + size/2 < player1.pos.y + player1.heil) {
                dead = true;
                if (objet_type == "red_champ") {
                    global_heil1 *= 1.5f;
                    player1.heil = global_heil1;
                }
                else if (objet_type == "green_champ") {
                    score1 +=1;
                }
                else if (objet_type == "etoile") {
                    mur1.pos.x = 0;
                    player1.est_cheate = 4;
                    if (balle.vel_x_precedente == 0) {
                        balle.vel_x_precedente = abs(balle.vel.x);
                        balle.vel.x *= 1.5f;
                    }
                }
                else if (objet_type == "mega_champ") {
                    player1.pos.y = height/4;
                    player1.est_foudre = 0;
                    balle.size = 100* width / 1300;
                    balle.compteur_size = 0;
                    player1.est_geant = 4; 
                    player2.est_pas_geant = 4;
                }
            }
        }
    }
    public void check_collision() {
        if (objet_type != "king_boo") {
            if (dist(pos.x + size/2, pos.y + size/2, balle.pos.x, balle.pos.y) <= balle.size/2 + size/2 ) {
                if (!est_touch) {
                    vel.x *= -1;
                    est_touch = true;
                }
            }
            for (int j = king_boos.size()-1; j > -1; j--) {
                if (king_boos.get(j).vel.x > 0) {
                    if (dist(pos.x + size/2, pos.y + size/2, king_boos.get(j).pos.x + king_boos.get(j).size/2, king_boos.get(j).pos.y + king_boos.get(j).size/2) <= king_boos.get(j).size/2 + size/2 ) {
                        vel.x = -1;
                    }                
                }
                else if (king_boos.get(j).vel.x < 0) {
                    if (dist(pos.x + size/2, pos.y + size/2, king_boos.get(j).pos.x + king_boos.get(j).size/2, king_boos.get(j).pos.y + king_boos.get(j).size/2) <= king_boos.get(j).size/2 + size/2 ) {
                        vel.x = 1;
                    }             
                }
            }
        }
    }
}
class Player {
    PVector pos;
    PVector vel;
    int weed;
    float heil;
    int center;
    int vel_max;
    int est_foudre;
    int est_cheate;
    int est_geant;
    int est_pas_geant;
    boolean est_objet_stocke;
    String objet_stocke;
    PGraphics name;
    int est_en_feu;
    int est_en_ice;
    int est_gele;
    

    Player(PVector pos_, PVector vel_, int weed_, float heil_, PGraphics name_) {
        pos=pos_;
        vel=vel_;
        weed=weed_;
        heil=heil_;
        vel_max = 10 * width / 1300;
        center = PApplet.parseInt((pos_.y + heil_)) / 2;
        est_foudre = 0;
        est_cheate = 0;
        est_geant = 0;
        est_pas_geant = 0;
        est_objet_stocke = false;
        objet_stocke = "";
        name = name_;
        est_en_feu = 0;
        est_en_ice = 0;
        est_gele = 0;
    }

    public void update () {
        pos.add(vel);

        if (pos.y + heil/2 > height) {
            pos.y = height - heil/2;
        }
        if (pos.y + heil/2 < 0) {
            pos.y = -heil/2;
        }

        if (est_cheate > 0) {
            est_foudre = 0;
            est_gele = 0;
            balle.est_invisible = 0;
            est_pas_geant = 0;
        }
        if (est_gele > 0) {
            vel_max = 6 * width/1300;
        }
        if (est_foudre > 0) {
            heil = 0.75f * starting_heil;
        }
        if (est_geant > 0) {
            heil = 3*height/4;
            vel_max = 3* width / 1300;
        }
        if (est_pas_geant > 0) {
            heil = 0.75f * starting_heil;
        }
        if (est_geant == 0 && est_gele == 0) {
            vel_max = 10 * width / 1300;
        }
        if (est_pas_geant == 0 && est_geant == 0 && est_foudre == 0 && !fire_game) {
            if (pos.x > width/2) {
                heil = global_heil2;
            }
            else {
                heil = global_heil1;
            }
        }
    }

    public void show () {
        if (pos.x <width/2) {
            if (est_foudre > 0) {
                image(platform1_foudre,pos.x, pos.y, weed, heil);
            }
            else if (est_en_feu > 0) {
                image(platform1_feu,pos.x, pos.y, weed, heil);
            }
            else if (est_en_ice > 0) {
                image(platform1_ice,pos.x, pos.y, weed, heil);
            }
            else if (est_gele > 0) {
                image(platform1_gele,pos.x, pos.y, weed, heil);
            }
            else {
                image(platform1,pos.x,pos.y, weed, heil);
            }
        }
        else {
            if (est_foudre > 0) {
                image(platform2_foudre,pos.x,pos.y, weed, heil);
            }
            else if (est_en_feu > 0) {
                image(platform2_feu,pos.x, pos.y, weed, heil);
            }
            else if (est_en_ice > 0) {
                image(platform2_ice,pos.x, pos.y, weed, heil);
            }
            else if (est_gele > 0) {
                image(platform2_gele,pos.x, pos.y, weed, heil);
            }
            else {
                image(platform2,pos.x,pos.y, weed, heil);
            }
        }
        if (est_objet_stocke) {
            if (objet_stocke == "king_boo") {
                if (pos.x < width/2) {
                    image(king_boo, width/4 - size_king_boo/2, 5* width / 1300, size_king_boo, size_king_boo);
                }
                else {
                    image(king_boo, 3*width/4 - size_king_boo/2, 5* width / 1300, size_king_boo, size_king_boo);
                }
            }
            else if (objet_stocke == "fire_mario") {
                if (pos.x < width/2) {
                    image(fire_mario, width/4 - size_fire_mario/2, 5* width / 1300, size_fire_mario, size_fire_mario);
                }
                else {
                    image(fire_mario, 3*width/4 - size_fire_mario/2, 5* width / 1300, size_fire_mario, size_fire_mario);
                }
            }
            else if (objet_stocke == "ice_mario") {
                if (pos.x < width/2) {
                    image(ice_mario, width/4 - size_ice_mario/2, 5* width / 1300, size_ice_mario, size_ice_mario);
                }
                else {
                    image(ice_mario, 3*width/4 - size_ice_mario/2, 5* width / 1300, size_ice_mario, size_ice_mario);
                }
            }
        }
    }

}
class Projectile {
    PVector pos;
    PVector vel;
    PVector acc;
    int size;
    boolean dead;
    String projectile_type;

    Projectile(PVector pos_, PVector vel_, PVector acc_, int size_, String projectile_type_) {
        pos = pos_;
        vel = vel_;
        acc = acc_;
        size = size_;
        dead = false;
        projectile_type = projectile_type_;
    }
    public void update() {
        vel.add(acc);
        pos.add(vel);
        check_collision_balle();
        check_collision_cube(objet_changement_direction);
        check_collision_cube(objet_fire_mario);
        check_collision_cube(objet_king_boo);
        check_collision_cube(objet_etoile);
        check_collision_cube(objet_platforme_maudite_boost);
        check_collision_cube(objet_ice_mario);
        check_collision_cube(objet_eclair);
        check_collision_cube(objet_mega_champ);
        check_collision_player_1();
        check_collision_player_2();
        check_collision_mur_1();
        check_collision_mur_2();
        check_collision_fire_wall();
        check_collision_king_boo();
    }

    public void show() {
        stroke(0);
        bullet1.resize(size,size);
        bullet2.resize(size,size);
        if (vel.x > 0) {
            if (projectile_type == "fire_bullet") {
                image(boule_de_feu1,pos.x,pos.y,size,size);
            }
            else if (projectile_type == "ice_bullet") {
                image(boule_de_neige1,pos.x,pos.y,size,size);
            }
            else {
                image(bullet1,pos.x,pos.y,size,size);
            }
        }
        else {
            if (projectile_type == "fire_bullet") {
                image(boule_de_feu2,pos.x,pos.y,size,size);
            }
            else if (projectile_type == "ice_bullet") {
                image(boule_de_neige2,pos.x,pos.y,size,size);
            }
            else {
                image(bullet2,pos.x,pos.y,size,size);
            }
        }
    }

    public void check_collision_balle() {
        if (dist(pos.x + size/2, pos.y + size /2, balle.pos.x, balle.pos.y) <= balle.size/2 + size/2) {
            balle.vel.x += 0.6f * vel.x/abs(vel.x);
            if (vel.x * balle.vel.x < 0) {
                if (balle.health > 0) {
                    balle.health--;
                }
            }
            else {
                if (balle.health < 123) {
                    balle.health ++;
                }
            }
            dead = true;
        }
    }
    public void check_collision_cube(Objet objet) {
        if (dist(pos.x + size/2, pos.y + size/2, objet.pos.x + objet.size/2, objet.pos.y + objet.size/2) <= size/2 + objet.size / 2) {
            if (projectile_type == "ice_bullet") {
                objet.est_gele = 4;
            }
            else {
                objet.vel.x = 0;
                objet.vel.y = 0;
                objet.pos.x = width/2 - size_objet/2;
                objet.pos.y = -size_objet;
                // objet.pos.x += 20 * vel.x/abs(vel.x) * width / 1300;
                dead = true;
            }
        }
    }
    public void check_collision_player_1() {
        if (pos.x <= player1.pos.x + player1.weed && pos.y + size/2 > player1.pos.y && pos.y + size/2 < player1.pos.y + player1.heil) {
            if (projectile_type == "fire_bullet") {
                if (player1.est_cheate == 0) {
                    dead = true;
                    score1 -= 1;
                    balle.press_p = true;
                }
                else {
                    vel.x = -vel.x;
                    pos.x = player1.pos.x + player1.weed;
                    acc.x = -acc.x;
                }
            }
            else if (projectile_type == "ice_bullet") {
                player1.est_gele = 4;
                dead = true;
                if (player1.est_en_feu > 0) {
                    player1.est_en_feu = 0;
                    fire_game = false;
                }
            }
            else {
                if (player1.est_en_feu > 0) {
                    projectile_type = "fire_bullet";
                    vel.x = vel.x /abs(vel.x) * vel_fire_bullet;
                    acc.x = vel.x / abs(vel.x) * acc_fire_bullet;
                }
                if (player1.est_en_ice > 0) {
                    projectile_type = "ice_bullet";
                    vel.x = vel.x /abs(vel.x) * vel_ice_bullet;
                    acc.x = vel.x / abs(vel.x) * acc_ice_bullet;
                }
                vel.x = -vel.x;
                pos.x = player1.pos.x + player1.weed;
                acc.x = - acc.x;
            }
        }
    }
    public void check_collision_player_2() {
        if (pos.x + size >= player2.pos.x &&  pos.y + size/2 > player2.pos.y && pos.y + size/2 < player2.pos.y + player2.heil) {
            if (projectile_type == "fire_bullet") {
                if (player1.est_cheate == 0) {
                    dead = true;
                    score2 -= 1;
                    balle.press_p = true;
                }
                else {
                    vel.x = -vel.x;
                    pos.x = player2.pos.x - size;
                    acc.x = -acc.x;
                }
            }
            else if (projectile_type == "ice_bullet") {
                player2.est_gele = 4;
                dead = true;
                if (player2.est_en_feu > 0) {
                    player2.est_en_feu = 0;
                    fire_game = false;
                }
            }
            else {
                if (player2.est_en_feu > 0) {
                    projectile_type = "fire_bullet";
                    vel.x = vel.x /abs(vel.x) * vel_fire_bullet;
                    acc.x = vel.x / abs(vel.x) * acc_fire_bullet;
                }
                if (player2.est_en_ice > 0) {
                    projectile_type = "ice_bullet";
                    vel.x = vel.x /abs(vel.x) * vel_ice_bullet;
                    acc.x = vel.x / abs(vel.x) * acc_ice_bullet;
                }         
                vel.x = -vel.x;
                pos.x = player2.pos.x - size;
                acc.x = -acc.x;
            }
        }
    }
    public void check_collision_mur_1() {
        if (pos.x <= mur1.pos.x + mur1.weed) {
            vel.x = -vel.x;
            pos.x = mur1.pos.x + mur1.weed;
        }
    }
    public void check_collision_mur_2() {
        if (pos.x + size >= mur2.pos.x) {
            vel.x = -vel.x;
            pos.x = mur2.pos.x - size;
        }
    }
    public void check_collision_fire_wall() {
        if (fire_wall.pos.x > width / 2) {
            if (pos.x + size >= fire_wall.pos.x) {
                vel.x = -vel.x;
                pos.x = fire_wall.pos.x - size;
                acc.x = -acc.x;
            }
        }
        else {
            if (pos.x <= fire_wall.pos.x + fire_wall.weed) {
                vel.x = -vel.x;
                pos.x = fire_wall.pos.x + fire_wall.weed;
                acc.x = -acc.x;
            }
        }
    }
    public void check_collision_king_boo() {
        for (int j = king_boos.size()-1; j > -1; j--) {
            if (dist(pos.x + size/2, pos.y + size/2, king_boos.get(j).pos.x + king_boos.get(j).size/2, king_boos.get(j).pos.y + king_boos.get(j).size/2) <= king_boos.get(j).size/2 + size/2) {
                if (projectile_type == "fire_bullet") {
                    dead = true;
                    king_boos.get(j).dead = true;
                }
                else {
                    king_boos.get(j).vel.x *= -1;
                    dead = true;
                }
            }
        }
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
