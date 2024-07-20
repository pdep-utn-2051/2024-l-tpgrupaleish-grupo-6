jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).
civilizacion(romanos).
civilizacion(incas).
tecnologias(herreria).
tecnologias(forja).
tecnologias(fundicion).
tecnologias(horno).
tecnologias(molino).
tecnologias(collera).
tecnologias(arado).
tecnologias(emplumado).
tecnologias(punta).
tecnologias(laminas).
tecnologias(malla).
tecnologias(placas).
usaCivilizacion(ana,romanos).
usaCivilizacion(beto,incas).
usaCivilizacion(carola,romanos).
usaCivilizacion(dimitri,romanos).
desarrolloTecnologia(ana,herreria).
desarrolloTecnologia(ana,forja).
desarrolloTecnologia(ana,emplumado).
desarrolloTecnologia(ana,laminas).
desarrolloTecnologia(beto,herreria).
desarrolloTecnologia(beto,forja).
desarrolloTecnologia(beto,fundicion).
desarrolloTecnologia(carola,herreria).
desarrolloTecnologia(dimitri,herreria).
desarrolloTecnologia(dimitri,fundicion).
unidad(campeon,Vida):-between(1,100,Vida).
unidad(jinete,90).
unidad(jinete,80).
unidad("piquero con escudo",55).
unidad("piquero con escudo",72).
unidad("piquero con escudo",77).
unidad("piquero sin escudo",50).
unidad("piquero sin escudo",65).
unidad("piquero sin escudo",70).
tieneUnidad(ana,jinete,90).
tieneUnidad(ana,"piquero con escudo",55).
tieneUnidad(ana,"piquero sin escudo",65).
tieneUnidad(beto,campeon,100).
tieneUnidad(beto,campeon,80).
tieneUnidad(beto,"piquero con escudo",55).
tieneUnidad(beto,jinete,80).
tieneUnidad(carola,"piquero sin escudo",70).
tieneUnidad(carola,"piquero con escudo",72).

% Punto 2

expertoEnMetales(Persona):-desarrolloTecnologia(Persona,herreria),desarrolloTecnologia(Persona,forja).

% Punto 3

civilizacionPopular(Civilizacion):-civilizacion(Civilizacion),findall(Persona,usaCivilizacion(Persona,Civilizacion),Personas),length(Personas,Cantidad),Cantidad>1.

% Punto 4

tieneAlcanceGlobal(Tecnologia):-tecnologias(Tecnologia),forall(jugador(Persona),desarrolloTecnologia(Persona,Tecnologia)).

% Punto 5

%civilizacionLider(Civilizacion):-forall(usaCivilizacion(Persona,Civilizacion),desarrolloTecnologia(Persona,Tecnologia)).
noSonDeLaCivilizacion(Civilizacion,Jugadores):-findall(Persona,not(usaCivilizacion(Persona,Civilizacion)),Jugadores).

% Punto 7

laUnidadConMasVida(Jugador,X,VidaUnidad):-findall(Vida,tieneUnidad(Jugador,_,Vida),VidaSoldados),maxl(VidaSoldados,VidaUnidad),tieneUnidad(Jugador,X,VidaUnidad).

max(A,B,A) :- A >= B.
max(A,B,B) :- A < B.
maxl([X],X). 
maxl([X|Y],M):- maxl(Y,M1), max(M1,X,M).


% Punto 8

leGana(Ganador,VidaG,Perdedor,VidaP):-unidad(Ganador,VidaG),unidad(Perdedor,VidaP),Ganador="piquero con escudo",Perdedor=jinete.
leGana(Ganador,VidaG,Perdedor,VidaP):-unidad(Ganador,VidaG),unidad(Perdedor,VidaP),Ganador="piquero sin escudo",Perdedor=jinete.
leGana(Ganador,VidaG,Perdedor,VidaP):-unidad(Ganador,VidaG),unidad(Perdedor,VidaP),Ganador=jinete,Perdedor=campeon.
leGana(Ganador,VidaG,Perdedor,VidaP):-unidad(Ganador,VidaG),unidad(Perdedor,VidaP),Ganador=campeon,Perdedor="piquero con escudo".
leGana(Ganador,VidaG,Perdedor,VidaP):-unidad(Ganador,VidaG),unidad(Perdedor,VidaP),Ganador=campeon,Perdedor="piquero sin escudo".
leGana(Ganador,VidaG,Perdedor,VidaP):-unidad(Ganador,VidaG),unidad(Perdedor,VidaP),VidaG>VidaP.

% Punto 9

puedeSobrevivir(Jugador):-jugador(Jugador),findall("piquero con escudo",tieneUnidad(Jugador,"piquero con escudo",_),Piqueros),
    findall("piquero sin escudo",tieneUnidad(Jugador,"piquero sin escudo",_),Piqueros2),
    length(Piqueros,Cantidad),length(Piqueros2,Cantidad2),Cantidad>Cantidad2.

% Punto 10

puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=herreria,not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=molino,not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=forja,desarrolloTecnologia(Jugador,herreria),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=fundicion,desarrolloTecnologia(Jugador,forja),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=horno,desarrolloTecnologia(Jugador,fundicion),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=collera,desarrolloTecnologia(Jugador,molino),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=arado,desarrolloTecnologia(Jugador,collera),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=emplumado,desarrolloTecnologia(Jugador,herreria),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=punta,desarrolloTecnologia(Jugador,emplumado),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=laminas,desarrolloTecnologia(Jugador,herreria),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=malla,desarrolloTecnologia(Jugador,laminas),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-tecnologias(Tecnologia),Tecnologia=placas,desarrolloTecnologia(Jugador,malla),not(desarrolloTecnologia(Jugador,Tecnologia)).