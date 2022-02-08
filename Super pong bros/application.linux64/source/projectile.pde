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
    void update() {
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

    void show() {
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

    void check_collision_balle() {
        if (dist(pos.x + size/2, pos.y + size /2, balle.pos.x, balle.pos.y) <= balle.size/2 + size/2) {
            balle.vel.x += 0.6 * vel.x/abs(vel.x);
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
    void check_collision_cube(Objet objet) {
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
    void check_collision_player_1() {
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
    void check_collision_player_2() {
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
    void check_collision_mur_1() {
        if (pos.x <= mur1.pos.x + mur1.weed) {
            vel.x = -vel.x;
            pos.x = mur1.pos.x + mur1.weed;
        }
    }
    void check_collision_mur_2() {
        if (pos.x + size >= mur2.pos.x) {
            vel.x = -vel.x;
            pos.x = mur2.pos.x - size;
        }
    }
    void check_collision_fire_wall() {
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
    void check_collision_king_boo() {
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
