/*  ===================================================================
    NEBELTOPF  v5  –  facettierter Fogponik-Pflanzentopf für Bambu Lab H2D
    -------------------------------------------------------------------
    SO BEDIENST DU DIE DATEI
      1. Fenster > Customizer öffnen (rechts).
      2. Bei TEIL auswählen, was du sehen oder exportieren willst.
         "uebersicht" lädt die fertigen STLs aus dem Ordner stl/ und ist
         deshalb sofort da und flüssig drehbar. "schnitt" zeigt sie
         aufgeschnitten. Beide nur mit F5 (Vorschau) ansehen, nicht F6.
      3. Für ein einzelnes Teil: TEIL wählen, F6 (Rendern), dann F7
         (STL exportieren).
    TEMPO
      * Die Kuppel ist das schwere Teil. OpenSCAD 2021.01 braucht dafür
        ca. 2 Minuten, egal wie schnell der PC ist (es rechnet nur auf
        einem Kern).
      * Viel schneller: aktuellen "Development Snapshot" von openscad.org
        installieren und unter Bearbeiten > Einstellungen > Erweitert
        als 3D-Rendering-Backend "Manifold" wählen. Dann dauert die Kuppel
        nur noch Sekunden.
      * QUALITAET = "schnell" macht Kreise gröber, gut zum Ausprobieren.
    Keine Schrauben, kein TPU, keine Gewindeeinsätze.
    =================================================================== */

/* [Auswahl] */
// Was soll angezeigt bzw. exportiert werden?
TEIL = "uebersicht"; // [uebersicht, schnitt, kuppel, kuppel_haupt, kuppel_farbe2, sockel, sieb, netztopf, kragenadapter, kammerdeckel, podest, kabelkappe, blindkappe, pruefblock]
// "schnell" zum Ausprobieren, "fein" zum Exportieren
QUALITAET = "fein"; // [schnell, fein]

/* [Wasserstandsanzeiger und Nachfüllen] */
// Ecke mit der Wasserkammer und dem Anzeiger: zwischen zwei Pflanzplätzen, kein Topf darüber
ECKE_ANZ = 240;
// Abstand des Anzeigers von der Mittelachse
R_ANZEIGER = 162;
// Innenradius der runden Kammer um den Anzeiger
KAMMER_RUND = 19;
// So weit läuft die Ausbuchtung auf beiden Seiten an den Flächen entlang (gleich angeschrägt)
FLANKE = 60;
// Neigung der Oberseite nach außen (Wasser und Schmutz laufen ab)
DACH_NEIGUNG = 5;
// Loch im Kammerdeckel für den Anzeiger (muss über die dickste Stelle des Anzeigers passen)
ANZEIGER_LOCH = 20;
// Rohrdurchmesser des Anzeigers unten (Aufnahme im Podest)
ANZEIGER_D = 12;
// Höhe des Podests: hebt den Anzeiger an, damit sein Sichtfenster über dem Deckel liegt
PODEST_H = 25;

/* [Kabeldurchführung] */
// Innendurchmesser des Kabelstutzens
ANSCHLUSS_ID = 10;
// Durchmesser des Kabels vom Vernebler (Loch in der Kabelkappe)
KABEL_D = 5.0;
// Seitenfläche für das Neblerkabel (Nachbarseite der Ausbuchtung)
SEITE_KABEL = 330;

/* [Passungen] */
// Spiel radial zwischen Netztopf und Fassung
SPIEL = 0.25;

/* [Sockel] */
SOCKEL_H   = 200;
// Füllhöhe max. über dem Tankboden (der Kabelstutzen liegt darüber)
WASSER_MAX = 130;
// Mindestfüllhöhe für den Nebler (Orientierung)
WASSER_MIN = 40;

/* [Experten: Kuppelgeometrie (aufeinander abgestimmt, nur mit Prüfung ändern)] */
R0         = 140;      // Eckradius Sechseck -> 280 mm über Ecken
ZARGE      = 20;       // senkrechter Rand unten
WAND       = 3;        // Wandstärke senkrecht zur Facette
DECKE      = 3;
H_KUPPEL   = 163.5;    // Spitze über der Zarge (gesamt 183,5)
EL_UNTEN   = 15;       // Topfwinkel unten (Facette 75°)
Z_UNTEN    = 64;
EL_MITTE   = 43;       // Topfwinkel Mitte (Facette 47°)
R_MITTE    = 75.5;
Z_MITTE    = 121.5;
EL_ECKE    = 21.5;
EL_ZWISCH  = 43;  R_ZWISCH = 115.5; Z_ZWISCH = 100;
EL_OBEN    = 28;  R_OBEN   = 70.5;  Z_OBEN   = 148.5;
NABE_R     = 35;       // Verstärkung hinter jeder Öffnung
NABE_T     = 14;
FARBSCHICHT = 1.2;     // Dicke der zweiten Farbe
KEIL_L     = 45;       // Stützkeile unter den Naben

/* [Experten: Bajonett Kuppel/Sockel] */
RING_RI    = 115.3;    // Bajonettring der Kuppel innen
RING_RA    = 118.3;
RING_H     = 20;
SCHULTER   = 3.5;
NASE_ZU    = 8;  NASE_ZO = 13;
NASE_TIEFE = 2.6;      // so weit ragen die Nasen nach innen (Eingriff 1,8 mm)
NASE_WINKEL = 7;
DREHWEG    = 20;

/* [Experten: Sockel innen] */
BODEN      = 4;
WAND_AUSSEN = 2.0;
TANK_RI    = 109.5;    // Tank/Kragen innen (Ø 219)
TANK_WAND  = 3.2;
KRAGEN_RA  = 114.5;    // Kragen außen (Kragen 5 mm dick)
KRAGEN_H   = 20;
LAND       = 3.7;
RINNE_T    = 3;
Z_SIEB     = -30;      // Oberkante der Siebauflage

/* [Experten: Netztopf] */
TOPF_D_OBEN  = 52;
TOPF_D_UNTEN = 42;
TOPF_TIEFE   = 50;
TOPF_WAND    = 1.6;
RAND_D       = 60;

/* [Versteckt] */
A0  = R0*cos(30);
EPS = 0.01;
FEIN = (QUALITAET == "fein");
$fn = FEIN ? 96 : 40;
FN_GROSS = FEIN ? 180 : 72;

// ===================================================================
//   Kuppelgeometrie: Facetten als Schnitt von Halbräumen
// ===================================================================
function nvec(az, el) = [cos(az)*cos(el), sin(az)*cos(el), sin(el)];
function ebene(az, el, r, z) = let(n=nvec(az,el)) [n, n*[r*cos(az), r*sin(az), z]];
function schnitt(e1, e2, e3) =
    let(n1=e1[0], n2=e2[0], n3=e3[0], D=n1*cross(n2,n3))
    abs(D) < 1e-9 ? undef
                  : (e1[1]*cross(n2,n3) + e2[1]*cross(n3,n1) + e3[1]*cross(n1,n2)) / D;
function innen(p, E) = max([for (e=E) e[0]*p - e[1]]) <= 1e-6;
function ecken(E) = [for (i=[0:len(E)-3]) for (j=[i+1:len(E)-2]) for (k=[j+1:len(E)-1])
                       let(p=schnitt(E[i],E[j],E[k])) if (p != undef && innen(p,E)) p];
function auf_ebene(V, e) = [for (p=V) if (abs(e[0]*p - e[1]) < 1e-4) p];
function summe(v, i=0) = i >= len(v) ? [0,0,0] : v[i] + summe(v, i+1);
module punkte_huelle(V) { hull() polyhedron(points=V, faces=[[for (i=[0:len(V)-1]) i]]); }

// Index 1 = Spitze, 8..16 = Pflanzfacetten
E_AUSSEN = concat(
    [[[0,0,-1], 0], [[0,0,1], ZARGE+H_KUPPEL]],
    [for (k=[0:5]) ebene(30+60*k, 0, A0, 0)],
    [for (k=[0:5]) ebene(30+60*k, EL_UNTEN, A0, ZARGE)],
    [for (j=[0:2]) ebene(60+120*j, EL_MITTE, R_MITTE, ZARGE+Z_MITTE)],
    [for (k=[0:5]) ebene(60*k, EL_ECKE, R0, ZARGE)],
    [for (j=[0:2]) ebene(120*j, EL_ZWISCH, R_ZWISCH, ZARGE+Z_ZWISCH)],
    [for (k=[0:5]) ebene(30+60*k, EL_OBEN, R_OBEN, ZARGE+Z_OBEN)]);
E_INNEN = [for (e=E_AUSSEN)
    e[0][2] < -0.99 ? [e[0], 1] : (e[0][2] > 0.99 ? [e[0], e[1]-DECKE] : [e[0], e[1]-WAND])];
// Eckpunkte nur EINMAL berechnen (spart Zeit bei jeder Vorschau)
V_AUSSEN = ecken(E_AUSSEN);
V_INNEN  = ecken(E_INNEN);
PFLANZ_EBENEN = [1, 8,9,10,11,12,13, 14,15,16];

module kuppel_aussen() { punkte_huelle(V_AUSSEN); }
module kuppel_innen()  { punkte_huelle(V_INNEN); }

// Pflanzplätze: [Mittelpunkt, Azimut, Elevation]
PLAETZE = concat(
    [for (k=[0:5]) let(az=30+60*k, r=A0-Z_UNTEN*tan(EL_UNTEN))
        [[r*cos(az), r*sin(az), ZARGE+Z_UNTEN], az, EL_UNTEN]],
    [for (j=[0:2]) let(az=60+120*j)
        [[R_MITTE*cos(az), R_MITTE*sin(az), ZARGE+Z_MITTE], az, EL_MITTE]],
    [[[0,0,ZARGE+H_KUPPEL], 0, 90]]);
// lokales System: z zeigt aus der Facette heraus, -x zeigt nach oben
module am_platz(p) { translate(p[0]) rotate([0,0,p[1]]) rotate([0,90-p[2],0]) children(); }

// ===================================================================
//   Bajonett Netztopf <-> Fassung (lokale Koordinaten, Rand oben bei z=0)
// ===================================================================
BAJ_START = 15;            // Winkel der ersten Nase beim Einsetzen
BAJ_DREH  = 30;            // im Uhrzeigersinn drehen (von außen gesehen)
T_NASE_U  = -11.6;  T_NASE_O = -7.6;
T_NASE_R  = 28.5;   T_NASE_B = 20;     // Nase: Außenradius, Breite in Grad
// Rastung: Noppe am Topfrand fällt am Ende in eine Mulde im Sitz
RAST_P    = [28 - 0.7*cos(45), -2.5 + 0.7*sin(45)];     // Noppenmitte (r, z), Noppe steht 0,3 mm vor
T_KEIL    = 0.45;    // so weit zieht der Keil den Topf in Endstellung nach innen

module ringsektor(r_i, r_a, a0, a1, zu, zo0, zo1, n=12) {
    if (a1 < a0) ringsektor_(r_i, r_a, a1, a0, zu, zo1, zo0, n);
    else         ringsektor_(r_i, r_a, a0, a1, zu, zo0, zo1, n);
}
module ringsektor_(r_i, r_a, a0, a1, zu, zo0, zo1, n) {
    pts = [for (s=[0:n]) let(a=a0+(a1-a0)*s/n, zo=zo0+(zo1-zo0)*s/n)
              each [[r_i*cos(a), r_i*sin(a), zu], [r_a*cos(a), r_a*sin(a), zu],
                    [r_a*cos(a), r_a*sin(a), zo], [r_i*cos(a), r_i*sin(a), zo]]];
    fc = concat(
        [[3,2,1], [3,1,0]], [[4*n, 4*n+1, 4*n+2], [4*n, 4*n+2, 4*n+3]],
        [for (s=[0:n-1]) for (q=[0:3]) let(a=4*s+q, b=4*s+(q+1)%4)
            each [[b, b+4, a+4], [b, a+4, a]]]);
    polyhedron(points=pts, faces=fc);
}
// Aussparung für Topf + Bajonett. tropfen: Bohrung oben spitz (druckbar ohne Stützen)
module fassung_ausschnitt(tropfen=true) {
    hull() {   // kegelige Senkung für den Rand
        translate([0,0,-0.5]) cylinder(d=RAND_D+2*SPIEL, h=0.5);
        translate([0,0,-4.7]) cylinder(d=TOPF_D_OBEN+2*SPIEL, h=0.01);
    }
    translate([0,0,-0.01]) cylinder(d=RAND_D+2*SPIEL, h=40);
    hull() {
        translate([0,0,-NABE_T-2]) cylinder(d=TOPF_D_OBEN+1, h=NABE_T+3);
        if (tropfen) translate([-RAND_D/2, -7.4, -NABE_T-2]) cube([EPS, 14.8, NABE_T+3]);
    }
    for (i=[0:2]) rotate(BAJ_START+120*i) {
        // Einführschlitz
        ringsektor(24, T_NASE_R+0.5, -T_NASE_B/2-2, T_NASE_B/2+2, T_NASE_U-0.7, 0.5, 0.5, 4);
        // Kanal, zum Ende hin keilförmig (zieht den Topf in den Sitz)
        ringsektor(24, T_NASE_R+0.5, T_NASE_B/2+2, -BAJ_DREH+2, T_NASE_U-0.7, T_NASE_O+0.4, T_NASE_O+0.4, 6);
        ringsektor(24, T_NASE_R+0.5, -BAJ_DREH+2.01, -BAJ_DREH-T_NASE_B/2-2, T_NASE_U-0.7, T_NASE_O+0.4, T_NASE_O-T_KEIL, 8);
        // Rastmulde für die Noppe in Endstellung
        rotate(-BAJ_DREH) translate([RAST_P[0], 0, RAST_P[1]-0.35]) sphere(r=1.35, $fn=24);
    }
}

// ===================================================================
//   KUPPEL  (Rand unten bei z = 0)
// ===================================================================
module nabe() { translate([0,0,-NABE_T]) cylinder(r=NABE_R, h=NABE_T+1); }
module topf_freiraum() {
    translate([0,0,-TOPF_TIEFE-3]) cylinder(d1=TOPF_D_UNTEN+3, d2=TOPF_D_OBEN+3, h=TOPF_TIEFE-NABE_T+3);
}
module kuppel_ring() {
    difference() {
        union() {
            cylinder(r=RING_RA, h=RING_H, $fn=FN_GROSS);
            intersection() {   // 45°-Schulter: Nebel- und Tropfsperre
                rotate_extrude($fn=FN_GROSS) polygon([
                    [RING_RI, RING_H], [RING_RA, RING_H], [R0+5, RING_H+(R0+5-RING_RA)],
                    [R0+5, RING_H+(R0+5-RING_RA)+SCHULTER], [RING_RA, RING_H+SCHULTER],
                    [RING_RI, RING_H+SCHULTER]]);
                kuppel_aussen();
            }
        }
        translate([0,0,-1]) cylinder(r=RING_RI, h=RING_H+SCHULTER+2, $fn=FN_GROSS);
    }
    for (k=[0:5]) rotate(60*k-NASE_WINKEL/2)   // Nasen, unten 45° angefast
        rotate_extrude(angle=NASE_WINKEL, $fn=FN_GROSS) polygon([
            [RING_RI-NASE_TIEFE, NASE_ZU+NASE_TIEFE], [RING_RI-NASE_TIEFE, NASE_ZO],
            [RING_RI+0.5, NASE_ZO], [RING_RI+0.5, NASE_ZU]]);
}
module kuppel_rumpf() {
    difference() {
        union() {
            difference() { kuppel_aussen(); kuppel_innen(); }
            intersection() {
                kuppel_aussen();
                union() for (p=PLAETZE) {
                    am_platz(p) nabe();
                    if (p[2] < 89) difference() {   // 45°-Stützkeil unter der Nabe
                        hull() {
                            am_platz(p) nabe();
                            translate(KEIL_L*[cos(p[1])*cos(45), sin(p[1])*cos(45), -sin(45)]) am_platz(p) nabe();
                        }
                        for (q=PLAETZE) am_platz(q) topf_freiraum();
                    }
                }
            }
            kuppel_ring();
        }
        for (p=PLAETZE) am_platz(p) { fassung_ausschnitt(p[2] < 89); topf_freiraum(); }
    }
}
module farbschichten() {
    intersection() {
        union() for (i=PFLANZ_EBENEN) let(e=E_AUSSEN[i], F0=auf_ebene(V_AUSSEN, e), c=summe(F0)/len(F0),
                                         F=[for (p=F0) p + 0.6*(c-p)/norm(c-p)])
            punkte_huelle(concat([for (p=F) p + 0.5*e[0]], [for (p=F) p - FARBSCHICHT*e[0]]));
        translate([0,0,ZARGE+0.6]) cylinder(r=2*R0, h=400);
    }
}
module kuppel()        { render() kuppel_rumpf(); }
module kuppel_haupt()  { render() difference() { kuppel_rumpf(); farbschichten(); } }
module kuppel_farbe2() { render() intersection() { kuppel_rumpf(); farbschichten(); } }

// ===================================================================
//   SOCKEL  (Oberkante z = 0, darauf sitzt die Kuppel)
// ===================================================================
function apo(r) = r/cos(30);
module sechseck(r, h) { cylinder(r=r, h=h, $fn=6); }
// System einer Seitenfläche: x tangential, y oben, z nach außen
module auf_flaeche(az, t, z) {
    multmatrix([[-sin(az), 0, cos(az), A0*cos(az) - t*sin(az)],
                [ cos(az), 0, sin(az), A0*sin(az) + t*cos(az)],
                [ 0,       1, 0,       z],
                [ 0,0,0,1]]) children();
}
Z_BODEN = -SOCKEL_H + BODEN;
Z_MAX = Z_BODEN + WASSER_MAX;   Z_MIN = Z_BODEN + WASSER_MIN;

// --- Kabelstutzen (45° schräg nach oben: druckbar und tropfsicher) ---
Z_KABEL   = Z_SIEB - 10;     // unter dem Sieb, über MAX
FLANSCH_D = 22;  FLANSCH_L = 13;       // Flanschsockel
STUTZEN_D = 16;  STUTZEN_L = 14;  KONUS = 0.06;   // 6 %-Kegel (wie Luer)
module stutzen_achse(az, z) { auf_flaeche(az, 0, z) rotate([-45,0,0]) children(); }
module stutzen_voll() {
    translate([0,0,-12]) cylinder(d=FLANSCH_D, h=12+FLANSCH_L-1.5);
    translate([0,0,FLANSCH_L-1.5]) cylinder(d1=FLANSCH_D, d2=FLANSCH_D-3, h=1.5);     // Fase
    translate([0,0,FLANSCH_L-EPS]) cylinder(d1=STUTZEN_D, d2=STUTZEN_D-KONUS*STUTZEN_L, h=STUTZEN_L);
}
module stutzen_innen_voll() { translate([0,0,-28]) cylinder(d=FLANSCH_D, h=28+12); }
BOHR_INNEN = 25;   // so weit reicht die Bohrung nach innen (bricht ganz in den Tank durch, aber nicht durch den Boden)
module stutzen_bohrung()    { translate([0,0,-BOHR_INNEN]) cylinder(d=ANSCHLUSS_ID, h=BOHR_INNEN+FLANSCH_L+STUTZEN_L+1); }
ANSCHLUESSE = [[SEITE_KABEL, Z_KABEL]];

// --- Ausbuchtung mit Wasserkammer: Anzeiger + Nachfüllen, ohne die Kuppel abzunehmen ---
// Erker an einer Ecke, zu beiden Seiten gleich angeschrägt, rundes Ende mit dem Anzeiger.
// Die Oberseite fällt um DACH_NEIGUNG nach außen ab. Die Kammer ist nur unten (unter MIN) mit
// dem Tank verbunden: kommunizierende Röhren, gleicher Wasserstand, aber kein Nebel nach außen.
KAMMER_WAND  = 3.2;    // Außenwand der Kammer (hält Wasser)
KAMMER_TRENN = 1.2;    // plus Sechseckwand 2,0 -> Trennwand 3,2 mm zu den Eckfächern
DECKEL_T = 3;  DECKEL_FALZ = 1.6;  DECKEL_SPIEL = 0.3;
function eckpunkt(az, r=R0) = [r*cos(az), r*sin(az)];
P_ANZ = eckpunkt(ECKE_ANZ, R_ANZEIGER);                  // Achse des Anzeigers
U_ANZ = [cos(ECKE_ANZ), sin(ECKE_ANZ)];                  // Richtung der Ecke
DACH_K = tan(DACH_NEIGUNG);
DACH_C = R0 - FLANKE/2;      // Dachebene: z = -DACH_K*(U·p - DACH_C), an den Flankenenden auf z = 0
function dach_z(p) = -DACH_K*(U_ANZ*p - DACH_C);
module schraeg() multmatrix([[1,0,0,0],[0,1,0,0],[-DACH_K*U_ANZ[0], -DACH_K*U_ANZ[1], 1, DACH_K*DACH_C],[0,0,0,1]]) children();
module unter_dach(dz=0) schraeg() translate([-400,-400,dz-400]) cube([800,800,400]);   // alles unter der Dachebene + dz
module sechseck2d(apo) circle(r=apo/cos(30), $fn=6);
module glaetten(r=1.5) offset(r=r) offset(r=-r) children();   // keine dünnen Spitzen
module bucht_2d(innen=0) offset(r=-innen) hull() {
    translate(P_ANZ) circle(r=KAMMER_RUND+KAMMER_WAND, $fn=FN_GROSS);
    for (n=[-60, 60]) translate(eckpunkt(ECKE_ANZ) + FLANKE*(eckpunkt(ECKE_ANZ+n)-eckpunkt(ECKE_ANZ))/R0) square(0.02, center=true);
}
module kammer_2d() glaetten() difference() { bucht_2d(KAMMER_WAND); sechseck2d(A0+KAMMER_TRENN); }
module falz_2d()   glaetten() difference() { bucht_2d(KAMMER_WAND-DECKEL_FALZ); sechseck2d(A0+0.5); }
module bucht_voll() intersection() {
    translate([0,0,-SOCKEL_H]) linear_extrude(SOCKEL_H) bucht_2d();
    unter_dach();
}
module kammer_hohl() {
    intersection() { translate([0,0,Z_BODEN]) linear_extrude(SOCKEL_H) kammer_2d(); unter_dach(-DECKEL_T+EPS); }
    difference() {                                                          // Falz für den Deckel
        intersection() { translate([0,0,-50]) linear_extrude(70) falz_2d(); unter_dach(10); }
        unter_dach(-DECKEL_T);
    }
}
module in_flaeche(az) { rotate(az-90) children(); }    // lokal: x tangential, y nach außen
module durchlass() in_flaeche(ECKE_ANZ)               // Verbindung Kammer <-> Tank quer durch die Ecke, Spitzdach 45°
    translate([0, R0+KAMMER_TRENN+3, Z_BODEN]) rotate([90,0,0])
        linear_extrude(R0+KAMMER_TRENN+3-(TANK_RI-2)) polygon([[-10,0],[10,0],[10,6],[0,16],[-10,6]]);
module durchlass_voll() in_flaeche(ECKE_ANZ) translate([-14, TANK_RI, Z_BODEN-1]) cube([28, R0-TANK_RI, 22]);
module podest_ring() translate([P_ANZ[0], P_ANZ[1], Z_BODEN-EPS])          // hält das Podest mittig
    difference() { cylinder(d=34, h=1.5+EPS); translate([0,0,-1]) cylinder(d=30.8, h=4); }

module bajonett_nuten() {
    for (k=[0:5]) rotate(60*k) {
        ringsektor(KRAGEN_RA-NASE_TIEFE, KRAGEN_RA+1, -DREHWEG-NASE_WINKEL/2-1, -DREHWEG+NASE_WINKEL/2+1,
                   NASE_ZU-1.5, KRAGEN_H+1, KRAGEN_H+1, 3);
        ringsektor(KRAGEN_RA-NASE_TIEFE, KRAGEN_RA+1, -DREHWEG-NASE_WINKEL/2-1, -10,
                   NASE_ZU-1.5, NASE_ZO+1.2, NASE_ZO+1.2, 4);
        ringsektor(KRAGEN_RA-NASE_TIEFE, KRAGEN_RA+1, -10.01, 1, NASE_ZU-1.5, NASE_ZO+1.2, NASE_ZO-0.15, 6);
        ringsektor(KRAGEN_RA-NASE_TIEFE, KRAGEN_RA+1, 0.99, NASE_WINKEL/2+1, NASE_ZU-1.5, NASE_ZO-0.15, NASE_ZO-0.15, 2);
        if (k%2==0) for (a=[-11.5, 6]) rotate(a)        // Federzunge
            translate([TANK_RI-1, -0.5, 0.5]) cube([KRAGEN_RA-TANK_RI+2, 1, KRAGEN_H+1]);
    }
}
module rastnocken() {
    for (k=[0,2,4]) rotate(60*k-5)
        translate([0,0,NASE_ZU-1.5]) linear_extrude(NASE_ZO+1.2-(NASE_ZU-1.5))
            polygon([[KRAGEN_RA-NASE_TIEFE-0.05, -1.6], [KRAGEN_RA-NASE_TIEFE+1.2, 0], [KRAGEN_RA-NASE_TIEFE-0.05, 1.6]]);
}
module sockel_rumpf() {
    difference() {
        union() {
            translate([0,0,-SOCKEL_H]) sechseck(R0, SOCKEL_H);
            translate([0,0,-6]) cylinder(r=KRAGEN_RA, h=KRAGEN_H+6, $fn=FN_GROSS);
            for (a=ANSCHLUESSE) stutzen_achse(a[0], a[1]) stutzen_voll();
            bucht_voll();
        }
        translate([0,0,Z_BODEN]) cylinder(r=TANK_RI, h=SOCKEL_H+KRAGEN_H, $fn=FN_GROSS);
        kammer_hohl();
        durchlass();
        // geschlossene, trockene Eckfächer (sparen Material)
        difference() {
            translate([0,0,Z_BODEN]) sechseck(R0-WAND_AUSSEN/cos(30), SOCKEL_H-BODEN-6);
            translate([0,0,-SOCKEL_H]) cylinder(r=TANK_RI+TANK_WAND, h=SOCKEL_H, $fn=FN_GROSS);
            for (k=[0:5]) rotate(30+60*k) translate([TANK_RI, -4, -SOCKEL_H]) cube([25, 8, SOCKEL_H]);
            for (a=ANSCHLUESSE) stutzen_achse(a[0], a[1]) stutzen_innen_voll();
            durchlass_voll();
        }
        // Rinne: Kondenswasser läuft zum Kragenfuß und durch Schlitze in den Tank
        difference() {
            hull() {
                translate([0,0,-EPS]) cylinder(r=apo(A0-LAND), h=EPS*2, $fn=6);
                translate([0,0,-RINNE_T]) cylinder(r=KRAGEN_RA+0.1, h=EPS, $fn=FN_GROSS);
            }
            translate([0,0,-10]) cylinder(r=KRAGEN_RA, h=40, $fn=FN_GROSS);   // Kragen bleibt ganz
        }
        for (k=[0:5]) rotate(30+60*k) translate([TANK_RI-2, -5, -RINNE_T+0.1]) cube([10, 10, RINNE_T-0.9]);
        bajonett_nuten();
        for (a=ANSCHLUESSE) stutzen_achse(a[0], a[1]) stutzen_bohrung();
    }
    rastnocken();
    podest_ring();
    // Auflage für das Wurzelsieb (unten 45° -> druckbar)
    translate([0,0,Z_SIEB]) rotate_extrude($fn=FN_GROSS)
        polygon([[TANK_RI+0.5, 0], [TANK_RI-4, 0], [TANK_RI+0.5, -4.5]]);
}
module sockel() { render() sockel_rumpf(); }

// ===================================================================
//   KLEINTEILE
// ===================================================================
// --- Wurzelsieb: liegt auf der Auflage über dem Wasser, Nebel geht durch ---
SIEB_D = 2*(TANK_RI-0.6);  SIEB_STEG = 1.2;  SIEB_LOCH = 2.0;  SIEB_RAND = 5;
module sieb() {
    p = SIEB_STEG + SIEB_LOCH;  r = SIEB_D/2;
    difference() { cylinder(r=r, h=2*SIEB_STEG, $fn=FN_GROSS); translate([0,0,-1]) cylinder(r=r-SIEB_RAND, h=5, $fn=FN_GROSS); }
    for (lage=[0,1]) translate([0,0,lage*SIEB_STEG]) linear_extrude(SIEB_STEG)
        intersection() {
            circle(r=r-SIEB_RAND+0.5, $fn=FN_GROSS);
            rotate(lage*90) for (x=[-r:p:r]) translate([x-SIEB_STEG/2, -r]) square([SIEB_STEG, 2*r]);
        }
    // Griff zum Herausheben
    translate([-15, -1.5, 0]) cube([30, 3, 2*SIEB_STEG]);
    hull() { translate([-12,-1.5,2*SIEB_STEG]) cube([24,3,0.1]); translate([-8,-1.5,12]) cube([16,3,0.1]); }
}

// --- Aufsteckteile für die Stutzen (Kegelsitz, dichtet ohne Dichtung) ---
KAPPE_MUND = STUTZEN_D - 0.1;      // Innenkegel am Eingang
KAPPE_TIEFE = 13;  KAPPE_D = 21;
module kappe_innenkegel() {
    translate([0,0,-EPS]) cylinder(d1=KAPPE_MUND, d2=KAPPE_MUND-KONUS*KAPPE_TIEFE, h=KAPPE_TIEFE+EPS);
}
module kappe_koerper(h) {
    difference() {
        union() {
            cylinder(d=KAPPE_D, h=h-1);
            translate([0,0,h-1]) cylinder(d1=KAPPE_D, d2=KAPPE_D-2, h=1);
        }
        for (i=[0:11]) rotate(30*i) translate([KAPPE_D/2-0.4, -0.8, 1.5]) cube([2, 1.6, h-3]);   // Griffrillen
    }
}
module blindkappe() {
    difference() { kappe_koerper(KAPPE_TIEFE+2); kappe_innenkegel(); }
}
module kabelkappe() {
    difference() {
        kappe_koerper(KAPPE_TIEFE+2);
        kappe_innenkegel();
        translate([0,0,-1]) cylinder(d=KABEL_D, h=30, $fn=32);
        translate([0,-0.5,-1]) cube([20, 1, 30]);     // Schlitz: Kabel seitlich einlegen
    }
}
// --- Kammerdeckel: liegt bündig im geneigten Falz, Loch für den Anzeiger ---
module kammerdeckel_einbau() {     // in Einbaulage (Weltkoordinaten)
    difference() {
        intersection() {
            translate([0,0,-50]) linear_extrude(70) offset(delta=-DECKEL_SPIEL) falz_2d();
            unter_dach();
            difference() { translate([-400,-400,-300]) cube(800); unter_dach(-DECKEL_T); }
        }
        translate([P_ANZ[0], P_ANZ[1], -60]) cylinder(d=ANZEIGER_LOCH, h=100);   // senkrecht für den Anzeiger
    }
    // Griffleiste außen am runden Ende (dort dreht die Kuppel beim Aufsetzen nie drüber)
    schraeg() translate(P_ANZ + 14.5*U_ANZ) rotate(ECKE_ANZ) translate([0,0,-EPS]) hull() {
        translate([-2,-8,0]) cube([4, 16, 0.1]);
        translate([-0.8,-7,5.5]) cube([1.6, 14, 0.1]);
    }
}
// Druckform: flach hingelegt, Oberseite oben, Achse des Anzeigers im Ursprung
module kammerdeckel() {
    rotate(a=-DACH_NEIGUNG, v=[-U_ANZ[1], U_ANZ[0], 0])
        translate([-P_ANZ[0], -P_ANZ[1], DECKEL_T - dach_z(P_ANZ)]) kammerdeckel_einbau();
}
// --- Podest: steht im Ring auf dem Kammerboden, darauf der Anzeiger ---
module podest() {
    a = ANZEIGER_D;
    difference() {
        union() { cylinder(d=30, h=3); cylinder(d=a+6, h=PODEST_H); }
        translate([0,0,PODEST_H-8]) cylinder(d=a+0.8, h=10);            // Aufnahme für den Anzeiger
        translate([0,0,-1]) cylinder(d=max(a-2, 4), h=PODEST_H+2);      // hohl: Wasser kommt von unten an den Schwimmer
        for (r=[45,135]) rotate(r) translate([-1.5,-20,PODEST_H-5]) cube([3,40,6]);   // Schlitze oben
        if (PODEST_H > 18) for (r=[45:90:315]) rotate(r) translate([0,-2,4]) cube([20,4,PODEST_H-16]);   // Fenster
    }
}

// --- Netztopf (Rand oben bei z=0). Druck: Boden auf die Platte. ---
module topf_nasen(r_b) {
    u = T_NASE_U + 1.5;
    for (i=[0:2]) rotate(BAJ_START+120*i-T_NASE_B/2)
        rotate_extrude(angle=T_NASE_B, $fn=96) polygon([
            [r_b-1, u-(T_NASE_R-r_b+1)], [r_b-1, T_NASE_O], [T_NASE_R, T_NASE_O], [T_NASE_R, u]]);
}
module topfrand() {
    hull() {
        translate([0,0,-0.5]) cylinder(d=RAND_D, h=0.5);
        translate([0,0,-4.5]) cylinder(d=TOPF_D_OBEN, h=0.01);
    }
    // Rastnoppen (fallen in Endstellung in die Mulden der Fassung)
    for (i=[0:2]) rotate(BAJ_START+120*i) translate([RAST_P[0], 0, RAST_P[1]]) sphere(r=1, $fn=24);
}
module netztopf() {
    r_io = TOPF_D_OBEN/2 - TOPF_WAND;
    difference() {
        union() {
            topfrand();
            translate([0,0,-TOPF_TIEFE]) cylinder(d1=TOPF_D_UNTEN, d2=TOPF_D_OBEN, h=TOPF_TIEFE-4);
            topf_nasen(25.4);
        }
        translate([0,0,-TOPF_TIEFE+TOPF_WAND])
            cylinder(d1=TOPF_D_UNTEN-2*TOPF_WAND, d2=TOPF_D_OBEN-2*TOPF_WAND, h=TOPF_TIEFE-4-TOPF_WAND+EPS);
        translate([0,0,-4.6]) cylinder(r=r_io, h=5);
        for (i=[0:11]) rotate(15+30*i) translate([15, -1.5, -TOPF_TIEFE+4]) cube([15, 3, TOPF_TIEFE-18]);
        for (x=[-12:6:12]) translate([x-1.5, -13, -TOPF_TIEFE-1]) cube([3, 26, TOPF_WAND+2]);
    }
    for (i=[0,1]) rotate(i*180) rotate([90,0,0]) translate([0,0,-4]) linear_extrude(8)   // Griffnasen
        polygon([[r_io+0.2, -8], [r_io+0.2, 0], [r_io-5, 0], [r_io-5, -2.8]]);
}
module kragenadapter() {   // für 2"-Neoprenkragen
    difference() {
        union() {
            topfrand();
            translate([0,0,-14]) cylinder(d=TOPF_D_OBEN+0.5, h=10);
            topf_nasen(26.25);
        }
        translate([0,0,-15]) cylinder(d=50, h=20);
    }
    for (i=[0:3]) rotate(45+90*i) translate([21.5, -3, -14]) cube([4, 6, 1.6]);
}
module pruefblock() {
    difference() { translate([-40,-40,-NABE_T]) cube([80,80,NABE_T]); fassung_ausschnitt(false); }
}

// ===================================================================
//   AUSGABE
// ===================================================================
module stl(n, farbe) { color(farbe) import(str("stl/", n, ".stl"), convexity=20); }
module uebersicht() {
    stl("kuppel_haupt", [0.84,0.84,0.82]);
    stl("kuppel_farbe2", [0.22,0.24,0.25]);
    for (p=PLAETZE) am_platz(p) rotate(-BAJ_DREH) stl("netztopf", [0.45,0.62,0.25]);
    stl("sockel", [0.84,0.84,0.82]);
    stutzen_achse(SEITE_KABEL, Z_KABEL) translate([0,0,FLANSCH_L+1.7]) stl("kabelkappe", [0.3,0.3,0.3]);
    translate([0,0,Z_SIEB]) stl("sieb", [0.30,0.45,0.30]);
    color([0.3,0.3,0.3]) kammerdeckel_einbau();
    translate([P_ANZ[0], P_ANZ[1], 0]) {
        translate([0,0,Z_BODEN]) stl("podest", [0.3,0.3,0.3]);
        // Platzhalter für einen gekauften 19-cm-Anzeiger (gesamt ca. 25 cm, dickste Stelle Ø 19)
        translate([0,0,Z_BODEN+PODEST_H-8]) color([0.75,0.2,0.15,0.6]) {
            cylinder(d=ANZEIGER_D, h=185); translate([0,0,185]) cylinder(d=19, h=65);
        }
    }
}
if (TEIL == "uebersicht")    uebersicht();
if (TEIL == "schnitt")       difference() { uebersicht(); translate([-180,0,-230]) cube([360,180,440]); }   // kleiner Schnittkörper: saubere F5-Vorschau
if (TEIL == "kuppel")        kuppel();
if (TEIL == "kuppel_haupt")  kuppel_haupt();
if (TEIL == "kuppel_farbe2") kuppel_farbe2();
if (TEIL == "sockel")        sockel();
if (TEIL == "sieb")          sieb();
if (TEIL == "netztopf")      netztopf();
if (TEIL == "kragenadapter") kragenadapter();
if (TEIL == "blindkappe")    blindkappe();
if (TEIL == "kabelkappe")    kabelkappe();
if (TEIL == "kammerdeckel")  kammerdeckel();
if (TEIL == "podest")        podest();
if (TEIL == "pruefblock")    pruefblock();
