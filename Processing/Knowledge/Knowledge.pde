import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;  

UnfoldingMap currentMap;
UnfoldingMap map1;
UnfoldingMap map2;
UnfoldingMap map3;
 
void setup() {
    size(800, 600);
 
    map1 = new UnfoldingMap(this, new Google.GoogleMapProvider());
    map2 = new UnfoldingMap(this, new Microsoft.AerialProvider());
    map3 = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
    MapUtils.createDefaultEventDispatcher(this, map1, map2, map3);
 
    currentMap = map2;
}
 
void draw() {
    currentMap.draw();
}
 
void keyPressed() {
    if (key == '1') {
        currentMap = map1;
    } else if (key == '2') {
        currentMap = map2;
    } else if (key == '3') {
        currentMap = map3;
    }
}