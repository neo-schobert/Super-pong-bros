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

    void update () {
        pos.add(vel);
        vel.add(acc);
        if (pos.x + size/2 < player1.pos.x || pos.x + size/2 > player2.pos.x + player2.weed) {
            if (objet_type == "cursed_champ") {
                if (vel.x <0) {
                    println("2/3 * global_heil1: "+ 2./3. * global_heil1);
                    println("global_heil1"+ global_heil1);
                    println("starting_heil: "+starting_heil);
                    if (2./3. * global_heil1 >= starting_heil) {
                        global_heil1 *= 2./3.;
                        player1.heil = global_heil1;
                    }
                }
                else {
                    println("2/3 * global_heil2: "+2/3 * global_heil2);
                    println("global_heil2"+ global_heil2);
                    println("starting_heil: "+starting_heil);
                    if (2./3. * global_heil2 >= starting_heil) {
                        global_heil2 *= 2./3.;
                        player2.heil = global_heil2;
                    }
                }
            }
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
    void show () {
        stroke(0);
        if (objet_type == "red_champ") {
            image(red_champ,pos.x,pos.y, size, size);
        }
        else if (objet_type == "cursed_champ") {
            image(cursed_champ,pos.x,pos.y, size, size);
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
    void collision_platform() {
        if (vel.x >= 0) {
            if (pos.x + size >= player2.pos.x && pos.y + size/2 > player2.pos.y && pos.y + size/2 < player2.pos.y + player2.heil) {
                if (objet_type != "cursed_champ") {
                    dead = true;
                }
                if (objet_type == "red_champ") {
                    global_heil2 *= 1.5;
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
                        balle.vel.x *= 1.5;
                    }
                }
                else if (objet_type == "mega_champ") {
                    player2.pos.y = height/4;
                    player2.est_foudre = 0;
                    balle.size = 100* width / 1300;
                    balle.compteur_size = 0;
                    player2.est_geant = 4;
                    player1.est_pas_geant = 4;
                    if (player1.est_cheate == 0) {
                        player1.pos.y = player1.pos.y + player1.heil/2 - player1.est_pas_geant_platforme_taille/2;
                    }
                }
            }
        }
        else {
            if (pos.x <= player1.pos.x + player1.weed && pos.y + size/2 > player1.pos.y && pos.y + size/2 < player1.pos.y + player1.heil) {
                if (objet_type != "cursed_champ") {
                    dead = true;
                }
                if (objet_type == "red_champ") {
                    global_heil1 *= 1.5;
                    player1.heil = global_heil1;
                }
                else if (objet_type == "cursed_champ") {

                }
                else if (objet_type == "green_champ") {
                    score1 +=1;
                }
                else if (objet_type == "etoile") {
                    mur1.pos.x = 0;
                    player1.est_cheate = 4;
                    if (balle.vel_x_precedente == 0) {
                        balle.vel_x_precedente = abs(balle.vel.x);
                        balle.vel.x *= 1.5;
                    }
                }
                else if (objet_type == "mega_champ") {
                    player1.pos.y = height/4;
                    player1.est_foudre = 0;
                    balle.size = 100* width / 1300;
                    balle.compteur_size = 0;
                    player1.est_geant = 4; 
                    player2.est_pas_geant = 4;
                    if (player2.est_cheate == 0) {
                        player2.pos.y = player2.pos.y + player2.heil/2 - player2.est_pas_geant_platforme_taille/2;
                    }
                }
            }
        }
    }
    void check_collision() {
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
