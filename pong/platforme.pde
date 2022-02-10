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
    float est_foudre_platforme_taille;
    float est_pas_geant_platforme_taille;
    float est_geant_platforme_taille;
    int fake_cubed;
    

    Player(PVector pos_, PVector vel_, int weed_, float heil_, PGraphics name_) {
        pos=pos_;
        vel=vel_;
        weed=weed_;
        heil=heil_;
        vel_max = 10 * width / 1300;
        center = int((pos_.y + heil_)) / 2;
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
        est_foudre_platforme_taille = 0.75 * starting_heil;
        est_pas_geant_platforme_taille = 0.75 * starting_heil;
        est_geant_platforme_taille = 3 * height /4;
        fake_cubed = 0;
    }

    void update () {
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
            fake_cubed = 0;
        }
        if (est_gele > 0) {
            vel_max = 3 * width/1300;
        }
        if (est_foudre > 0) {
            heil = est_foudre_platforme_taille;
        }
        if (est_geant > 0) {
            heil = est_geant_platforme_taille;
            vel_max = 3* width / 1300;
        }
        if (est_pas_geant > 0) {
            heil = est_pas_geant_platforme_taille;
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

    void show () {
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
