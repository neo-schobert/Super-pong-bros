class Objet {
    PVector pos;
    PVector vel;
    int size;
    String objet_type;
    int est_gele;
    boolean dead;

    Objet(PVector pos_, PVector vel_, int size_, String objet_type_) {
        pos = pos_;
        vel = vel_;
        size = size_;
        objet_type = objet_type_;
        est_gele = 0;
        dead = false;
    }

    void update () {
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
    void show () {
        if (objet_type != "fake_cube") {
            stroke(0);
            if (est_gele >0) {
                image(cube, pos.x, pos.y, size, size); // A remplacer par cube_gele
            }
            else {
                image(cube, pos.x, pos.y, size, size);
            }
        } else{
            stroke(0);
            if (est_gele >0) {
                image(fake_cube, pos.x, pos.y, size, size); // A remplacer par cube_gele
            }
            else {
                image(fake_cube, pos.x, pos.y, size, size);
            }
        }
    }
}
