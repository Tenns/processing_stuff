color Color =  color(212, 134, 141);
colorMode(HSB, 255);

color alt1 = color(hue(Color), saturation(Color), brightness(Color));
colorMode(RGB, 255);
color alt2 = color(hue(Color), saturation(Color), brightness(Color));

println(Color, alt1, alt2);
