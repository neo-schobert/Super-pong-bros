//1 - creer une balle qui rebondit sur les murs CHECK
//2 - creer des joueurs qui peuvent se deplacer verticalement CHECK
//3 - faire rebondir la balle sur les joueurs CHECK
//4 - compter les points 
import processing.core.PApplet;
import processing.core.PGraphics;
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
PImage cursed_champ;
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
PImage fake_cube;
PFont rubber_biscuit;
PFont press_start;
PGraphics name_player_1_graphics;
PGraphics name_player_2_graphics;
PImage player_name_background;
int weed;
float starting_heil; 
int score1 = 5;
int score2 = 5;
color ballcolor = color(255,255,255);
int apparition_objet = 0;
int size_objet;
ArrayList<Objet> objets;
ArrayList<Projectile> projectiles;
ArrayList<Objet_au_sol> red_champs;
ArrayList<Objet_au_sol> cursed_champs;
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
int size_cursed_champ;
int size_green_champ;
int size_etoile;
int size_ball;
int duree_invisiblite = 80;
String player1_name = "";
String player2_name = "";
boolean settings_done = false;
boolean game_over_bool_1 = false;
boolean game_over_bool_2 = false;
boolean player1_name_validate = false;
boolean player2_name_validate = false;
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



void settings() {
    fullScreen();
    String[] fontList = PFont.list();
    printArray(fontList);
}


void setup() {
    rubber_biscuit = createFont("Rubber Biscuit Bold",128);
    
    press_start = createFont("Press Start Regular",128);
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
    size_cursed_champ = 120 * width / 1300;
    size_green_champ = 100 * width/1300;
    size_etoile = 150 * width/1300;
    fire_game = false;
    vel_normal_bullet = 20 * width / 1300;
    vel_fire_bullet = 40 * width / 1300;
    vel_ice_bullet = 20 * width / 1300;
    acc_fire_bullet = 2* width / 1300;
    acc_ice_bullet = 0;
    acc_normal_bullet = 0;
    vel_cube = 1 * width / 1300;
    player_name_background = loadImage("player_name_background.png");
    player_name_background.resize(width,height);

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
        cursed_champ = loadImage("cursed_champ.png");
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
        fake_cube = loadImage("fake_cube.png");
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
        cursed_champs = new ArrayList<Objet_au_sol>();
        green_champs = new ArrayList<Objet_au_sol>();
        mega_champs = new ArrayList<Objet_au_sol>();
        king_boos = new ArrayList<Objet_au_sol>();
        etoiles = new ArrayList<Objet_au_sol>();
        eclairs = new ArrayList<Objet_au_sol>();
        objets = new ArrayList<Objet>();




        balle = new Balle(new PVector(width/2, height/2), new PVector(8 * width / 1300, 0), new PVector(0, 0), size_ball);
        make_text_player1();
        make_text_player2();
        player1 = new Player(new PVector(width/15, height / 2 - global_heil1/2) , new PVector(0, 0), weed, global_heil1, name_player_1_graphics);
        player2 = new Player(new PVector(width - width/15 - weed, height/2 - global_heil2/2) , new PVector(0, 0), weed, global_heil2, name_player_2_graphics);
        mur1 = new Mur(new PVector(-2*mur_weed,0), mur_weed, height, "rainbow_wall");
        mur2 = new Mur(new PVector(width + 2*mur_weed,0),mur_weed , height, "rainbow_wall");
        fire_wall = new Mur(new PVector(width + 2*mur_weed,0),mur_weed , height, "fire_wall");

    }
    else {
        global_heil1 = height/7;
        global_heil2 = height/7;
    }
}   

void draw() {
    if (settings_done) {
        if (!game_over_bool_1 && !game_over_bool_2) {
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
            if (balle.press_start_death) {
                for (int j = projectiles.size()-1; j > -1; j--) {
                    projectiles.remove(j);
                }
                for (int j = red_champs.size()-1; j > -1; j--) {
                    red_champs.remove(j);
                }
                for (int j = cursed_champs.size()-1; j > -1; j--) {
                    cursed_champs.remove(j);
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
            for (int j = objets.size()-1; j > -1; j--) {
                objets.get(j).show();
                objets.get(j).update();
                if (objets.get(j).pos.y > height || objets.get(j).dead) {
                    objets.remove(j);
                }
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
            for (int j = cursed_champs.size()-1; j > -1; j--) {
                cursed_champs.get(j).show();
                cursed_champs.get(j).update();
                if (cursed_champs.get(j).dead) {
                    cursed_champs.remove(j);
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
                game_over_bool_1 = true;
            }
            if (score2 == 0 || global_heil1 >= height) {
                balle.vel.x = 0;
                balle.vel.y = 0;
                balle.pos.x = width/2;
                balle.pos.y = height/2;
                game_over_bool_2 = true;
            }
            if (balle.press_start_death) {
                fill(255,255,255);
                textFont(press_start,6*height / 100);
                text("Press start", width/3, 47 * height/100, 2*width/3, 53 * height/100);
            }
            balle.show();
            balle.update();
            tint(255,255,255);
            fill(0,0,255);
            player1.show();
            player2.show();
            player1.update();
            player2.update();
            for (int i = 0; i < objets.size(); i++) {
                objets.get(i).show();
                objets.get(i).update();
            }
            mur1.show();
            mur2.show();
            fire_wall.show();
            image(player1.name, 31*width/100, height/100, 17 * width/100,height/19 );
            image(player2.name, 52* width/100, height/100, 17 * width/100,height/19);
        }
        else {
            background(game_over); 
            if (game_over_bool_1) {
                String[] defaite = new String [5];
                defaite[0] = "23 à 0, c'est la piquette";
                defaite[1] = player1_name;
                defaite[2] = "tu sais pas jouer";
                defaite[3] = player1_name;
                defaite[4] = "t'es mauvais";
                textFont(rubber_biscuit,height/15);
                fill(255,255,255);
                text(join(defaite, " "),10 * width/100,70 * height/100, 70 * width/100, 80 * height/100);
            }
        }
    }
    else {
        background(player_name_background);
        if (!player1_name_validate) {
            fill(255,255,255);
            textFont(rubber_biscuit, height/19);
            text(player1_name, 58*width/100, 127*height/200);
        }
        else {
            textFont(rubber_biscuit, height/19);
            text(player1_name, 58*width/100, 127*height/200);
            if (!player2_name_validate) {
                fill(255,255,255);
                textFont(rubber_biscuit, height/19);
                text(player2_name, 58*width/100, 150*height/200);
            }
            else {
                fill(255,255,255);
                textFont(rubber_biscuit, height/19);
                text(player2_name, 58*width/100, 150*height/200);
                fill(255,255,255);
                textFont(press_start,height/15);
                text("PRESS START",40*width/100,85*height/100);
            }
        }
    }
}   

void keyTyped() {
    if (!settings_done) {
        if (!player1_name_validate) {
            if (key == 8) {
                if (player1_name.length() > 0) {
                    player1_name = player1_name.substring(0, player1_name.length() -1);
                }
            }
            else {
                if (keyCode != ENTER) {
                    if (player1_name.length() <12) {
                        player1_name += key;
                    }
                }
            }
        }
        else {
            if (!player2_name_validate) {
                if (key == 8) {
                    if (player2_name.length() > 0) {
                        player2_name = player2_name.substring(0, player2_name.length() -1);
                    }
                }
                else {
                    if (keyCode != ENTER) {
                        if (player2_name.length() < 12) {
                            player2_name += key;
                        }
                    }
                }
            }
        }
    }
}


void keyPressed() {
    if (settings_done) {
        if (key == 'p' && !balle.press_start_death) {
            int pranked = 1;
            if (player2.fake_cubed > 0) {
                pranked = -1;
            }
            player2.vel.y = -pranked * player2.vel_max;
        }
        if (key == 'P' && !balle.press_start_death) {
            int pranked = 1;
            if (player2.fake_cubed > 0) {
                pranked = -1;
            }
            player2.vel.y = -pranked * player2.vel_max;
        }
        if (key == 'm' && !balle.press_start_death) {
            int pranked = 1;
            if (player2.fake_cubed > 0) {
                pranked = -1;
            }
            player2.vel.y = pranked * player2.vel_max;
        }
        if (key == 'M' && !balle.press_start_death) {
            int pranked = 1;
            if (player2.fake_cubed > 0) {
                pranked = -1;
            }
            player2.vel.y = pranked * player2.vel_max;
        }
        if (key == 'a' && !balle.press_start_death) {
            int pranked = 1;
            if (player1.fake_cubed > 0) {
                pranked = -1;
            }
            player1.vel.y = -pranked * player1.vel_max;
        }
        if (key == 'A' && !balle.press_start_death) {
            int pranked = 1;
            if (player1.fake_cubed > 0) {
                pranked = -1;
            }
            player1.vel.y = -pranked * player1.vel_max;
        }
        if (key == 'q' && !balle.press_start_death) {
            int pranked = 1;
            if (player1.fake_cubed > 0) {
                pranked = -1;
            }
            player1.vel.y = pranked * player1.vel_max;
        }
        if (key == 'Q' && !balle.press_start_death) {
            int pranked = 1;
            if (player1.fake_cubed > 0) {
                pranked = -1;
            }
            player1.vel.y = pranked * player1.vel_max;
        }
        if (keyCode == ENTER) {
            if (balle.press_start_death) {
                balle.press_start_death = false;
                setup();
            }
        }
        if (key == 'l' && player2.est_objet_stocke) {
            if (player2.objet_stocke == "king_boo") {
                player2.objet_stocke = "";
                player2.est_objet_stocke = false;
                balle.est_invisible = abs(duree_invisiblite - 3*int(abs(balle.vel.x* width / 1300)));
                king_boos.add(new Objet_au_sol(new PVector(player2.pos.x - size_king_boo, height - size_king_boo), new PVector(-5 * width / 1300 ,0), new PVector(0,0), size_king_boo, "king_boo"));
            }
            else if (player2.objet_stocke == "fire_mario") {
                if (player1.est_cheate == 0) {
                    player2.objet_stocke = "";
                    player2.est_objet_stocke = false;
                    player2.est_en_feu = 3;
                    player2.est_en_ice = 0;
                    player2.est_geant = 0;
                    player2.est_gele = 0;
                    player2.est_foudre = 0;


                    player1.est_gele = 0;
                    player1.est_en_feu = 0;
                    player1.est_geant = 0;
                    player1.est_foudre = 0;
                    fire_game = true;
                    fire_wall.pos.x = 0;
                    for (int j = projectiles.size()-1; j > -1; j--) {
                        projectiles.remove(j);
                    }
                    for (int j = red_champs.size()-1; j > -1; j--) {
                        red_champs.remove(j);
                    }
                    for (int j = cursed_champs.size()-1; j > -1; j--) {
                        cursed_champs.remove(j);
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
        if (key == 'L' && player2.est_objet_stocke) {
            if (player2.objet_stocke == "king_boo") {
                player2.objet_stocke = "";
                player2.est_objet_stocke = false;
                balle.est_invisible = abs(duree_invisiblite - 3*int(abs(balle.vel.x* width / 1300)));
                king_boos.add(new Objet_au_sol(new PVector(player2.pos.x - size_king_boo, height - size_king_boo), new PVector(-5 * width / 1300 ,0), new PVector(0,0), size_king_boo, "king_boo"));
            }
            else if (player2.objet_stocke == "fire_mario") {
                if (player1.est_cheate == 0) {
                    player2.objet_stocke = "";
                    player2.est_objet_stocke = false;
                    player2.est_en_feu = 3;
                    player2.est_en_ice = 0;
                    player2.est_geant = 0;
                    player2.est_gele = 0;
                    player2.est_foudre = 0;


                    player1.est_gele = 0;
                    player1.est_en_feu = 0;
                    player1.est_geant = 0;
                    player1.est_foudre = 0;
                    fire_game = true;
                    fire_wall.pos.x = 0;
                    for (int j = projectiles.size()-1; j > -1; j--) {
                        projectiles.remove(j);
                    }
                    for (int j = red_champs.size()-1; j > -1; j--) {
                        red_champs.remove(j);
                    }
                    for (int j = cursed_champs.size()-1; j > -1; j--) {
                        cursed_champs.remove(j);
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
        if (key == 's' && player1.est_objet_stocke) {
            if (player1.objet_stocke == "king_boo") {
                player1.objet_stocke = "";
                player1.est_objet_stocke = false;
                balle.est_invisible = abs(duree_invisiblite - 3*int(abs(balle.vel.x* width / 1300)));
                king_boos.add(new Objet_au_sol(new PVector(player1.pos.x + player1.weed, height - size_king_boo), new PVector(5* width / 1300,0), new PVector(0,0), size_king_boo, "king_boo"));
            }
            else if (player1.objet_stocke == "fire_mario") {
                if (player2.est_cheate == 0) {
                    player1.objet_stocke = "";
                    player1.est_objet_stocke = false;
                    player1.est_en_ice = 0;
                    player1.est_gele = 0;
                    player1.est_geant = 0;
                    player1.est_foudre = 0;
                    player1.est_en_feu = 3;
                    

                    player2.est_gele = 0;
                    player2.est_en_feu = 0;
                    player2.est_geant = 0;
                    player2.est_foudre = 0;
                    fire_game = true;
                    fire_wall.pos.x = width-fire_wall.weed;
                    for (int j = projectiles.size()-1; j > -1; j--) {
                        projectiles.remove(j);
                    }
                    for (int j = red_champs.size()-1; j > -1; j--) {
                        red_champs.remove(j);
                    }
                    for (int j = cursed_champs.size()-1; j > -1; j--) {
                        cursed_champs.remove(j);
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
        if (key == 'S' && player1.est_objet_stocke) {
            if (player1.objet_stocke == "king_boo") {
                player1.objet_stocke = "";
                player1.est_objet_stocke = false;
                balle.est_invisible = abs(duree_invisiblite - 3*int(abs(balle.vel.x* width / 1300)));
                king_boos.add(new Objet_au_sol(new PVector(player1.pos.x + player1.weed, height - size_king_boo), new PVector(5* width / 1300,0), new PVector(0,0), size_king_boo, "king_boo"));
            }
            else if (player1.objet_stocke == "fire_mario") {
                if (player2.est_cheate == 0) {
                    player1.objet_stocke = "";
                    player1.est_objet_stocke = false;
                    player1.est_en_ice = 0;
                    player1.est_gele = 0;
                    player1.est_geant = 0;
                    player1.est_foudre = 0;
                    player1.est_en_feu = 3;
                    

                    player2.est_gele = 0;
                    player2.est_en_feu = 0;
                    player2.est_geant = 0;
                    player2.est_foudre = 0;
                    fire_game = true;
                    fire_wall.pos.x = width-fire_wall.weed;
                    for (int j = projectiles.size()-1; j > -1; j--) {
                        projectiles.remove(j);
                    }
                    for (int j = red_champs.size()-1; j > -1; j--) {
                        red_champs.remove(j);
                    }
                    for (int j = cursed_champs.size()-1; j > -1; j--) {
                        cursed_champs.remove(j);
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
        if (key == ':' && balle.vel.x <= 0 && projectiles.size() < 3 && !balle.press_start_death) {
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
        if (key == '/' && balle.vel.x <= 0 && projectiles.size() < 3 && !balle.press_start_death) {
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
        if (key == 'w' && balle.vel.x >= 0 && projectiles.size() < 3 && !balle.press_start_death) {
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
        if (key == 'W' && balle.vel.x >= 0 && projectiles.size() < 3 && !balle.press_start_death) {
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
            if (!player2_name_validate) {
                if (keyCode == ENTER) {
                    player2_name_validate = true;
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

void keyReleased() {
    if (settings_done) {
        if (key == 'p') {
            player2.vel.y = 0;
        }
        if (key == 'P') {
            player2.vel.y = 0;
        }
        if (key == 'm') {
            player2.vel.y = 0;
        }
        if (key == 'M') {
            player2.vel.y = 0;
        }
        if (key == 'a') {
            player1.vel.y = 0;
        }
        if (key == 'A') {
            player1.vel.y = 0;
        }
        if (key == 'q') {
            player1.vel.y = 0;
        }
        if (key == 'Q') {
            player1.vel.y = 0;
        }
    }
    else {
        if (player1_name_validate && !player2_name_validate) {
            if (keyCode == ENTER) {
                player2_name = "";
            }
        }
    }
}

public void make_text_player1() {
    final float ratio = 0.6f;
    textFont(rubber_biscuit);
    textSize(60);

    name_player_1_graphics = createGraphics( int(textWidth(player1_name)) , 60); 

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


    name_player_2_graphics = createGraphics( int(textWidth(player2_name)) , 80); 


    name_player_2_graphics.noSmooth();
    name_player_2_graphics.beginDraw();
    name_player_2_graphics.fill(255,165,0);
    name_player_2_graphics.loadPixels();
    name_player_2_graphics.textAlign(LEFT,TOP);
    name_player_2_graphics.textFont(rubber_biscuit);
    name_player_2_graphics.textSize(80);
    name_player_2_graphics.text(player2_name, 0, 0);
    name_player_2_graphics.endDraw();
    
    for (int pixel = 0; pixel < (name_player_2_graphics.pixels.length * ratio); pixel++) {
        if (name_player_2_graphics.pixels[pixel] == color(255,165,0)) {
            name_player_2_graphics.pixels[pixel] = color(255,255,0);
        }
    }
}
