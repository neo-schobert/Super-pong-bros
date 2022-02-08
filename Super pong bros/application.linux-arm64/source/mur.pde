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

    void show () {
        if (mur_type == "rainbow_wall") {
            for (int i = 0; i < weed; i++) {
                colorMode(HSB);
                int frame = frameCount % 255;
                stroke((map(i, 0, weed, 0, 0.25*255) + 10*frame) % 255, 150, 255);
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
