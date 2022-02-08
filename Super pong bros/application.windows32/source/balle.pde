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
        random = int(random(2,4));
        compteur_size = 0;
        est_invisible = 0;
        vel_x_precedente = 0;
        press_p = false;
    }

    void update () {
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
            random_objet_ind = int(random(0, 87));
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
            random = int(random(1,3));
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
    
    void show () {
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
            image(blue_shell,pos.x - size/2, pos.y - size/2, 1.5*size, 1.5*size);
        }
    }

    void bounce1(Player player) {
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
    void bounce2(Player player) {
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
    void bounce_mur_1() {
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
    void bounce_mur_2() {
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
    void touch(Objet objet) {
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
    void objet_changement_direction(Player player) {
        vel.y = -vel.y + random(2) - 1;
    }
    void fire_mario(Player player) {
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
    void king_boo(Player player) {
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
    void etoile(Player player) {
        if (player.pos.x > width/2) {
            etoiles.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_etoile, "etoile"));
        }
        else {
            etoiles.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_etoile, "etoile"));
        }
    }
    void platforme_maudite_boost(Player player) {
        player.vel_max = 20* width / 1300;
    }
    void ice_mario(Player player) {
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
    void eclair(Player player) {
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
            eclairs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(0,-3* width / 1300), new PVector(0,-0.5* width / 1300), size_eclair, "eclair"));
        }
        else {
            eclairs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(0,-3* width / 1300), new PVector(0,-0.5* width / 1300), size_eclair, "eclair"));
        }
    }
    void mega_champ(Player player) {
        if (player.pos.x > width/2) {
            mega_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_mega_champ, "mega_champ"));
        }
        else {
            mega_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_mega_champ, "mega_champ"));
        }
    }
    void red_champ(Player player) {
        if (player.pos.x > width/2) {
            red_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_red_champ, "red_champ"));
        }
        else {
            red_champs.add(new Objet_au_sol(new PVector(pos.x * width / 1300,pos.y * width / 1300), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_red_champ, "red_champ"));
        }
    }
    void green_champ(Player player) {
        if (player.pos.x > width/2) {
            green_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_green_champ, "green_champ"));
        }
        else {
            green_champs.add(new Objet_au_sol(new PVector(pos.x,pos.y), new PVector(-1 * width / 1300,3 * width / 1300), new PVector(0,0.5 * width / 1300), size_green_champ, "green_champ"));
        }
    }
}