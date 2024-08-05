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
unidad(campeon,Vida,_):-between(1,100,Vida).
unidad("jinete a caballo",90,_).
unidad("jinete a camello",80,_).
unidad("piquero con escudo",Vida,1):-Vida is 50*1.1.
unidad("piquero con escudo",Vida,2):-Vida is 65*1.1.
unidad("piquero con escudo",Vida,3):-Vida is 70*1.1.
unidad("piquero sin escudo",50,1).
unidad("piquero sin escudo",65,2).
unidad("piquero sin escudo",70,3).
tieneUnidad(ana,unidad("jinete a caballo",90,_)).
tieneUnidad(ana,unidad("piquero con escudo",Vida,1)):-Vida is 50*1.1.
tieneUnidad(ana,unidad("piquero sin escudo",65,2)).
tieneUnidad(beto,unidad(campeon,100,_)).
tieneUnidad(beto,unidad(campeon,80,_)).
tieneUnidad(beto,unidad("piquero con escudo",Vida,1)):-Vida is 50*1.1.
tieneUnidad(beto,unidad("jinete a camello",80,_)).
tieneUnidad(carola,unidad("piquero sin escudo",70,3)).
tieneUnidad(carola,unidad("piquero con escudo",Vida,2)):-Vida is 65*1.1.

% Punto 2

expertoEnMetales(Persona):-desarrolloTecnologia(Persona,herreria),desarrolloTecnologia(Persona,forja).
expertoEnMetales(Persona):-desarrolloTecnologia(Persona,fundicion).
expertoEnMetales(Persona):-usaCivilizacion(Persona,romanos).

% Punto 3

civilizacionPopular(Civilizacion):-civilizacion(Civilizacion),findall(Persona,usaCivilizacion(Persona,Civilizacion),Personas),length(Personas,Cantidad),Cantidad>1.

% Punto 4

tieneAlcanceGlobal(Tecnologia):-tecnologias(Tecnologia),forall(jugador(Persona),desarrolloTecnologia(Persona,Tecnologia)).

% Punto 5

civilizacionLider(Civilizacion):-civilizacion(Civilizacion),findall(Tecnologia,desarrolloTecnologia(_,Tecnologia),Tecnologias),
findall(Tecnologia,(usaCivilizacion(Jugador,Civilizacion),desarrolloTecnologia(Jugador,Tecnologia)),TecnologiasCivilisacion),
list_to_set(Tecnologias,Conjunto),list_to_set(TecnologiasCivilisacion,Conjunto2),Conjunto=Conjunto2.

% Punto 7

laUnidadConMasVida(Jugador,X,VidaUnidad):-jugador(Jugador),findall(Vida,tieneUnidad(Jugador,unidad(_,Vida,_)),VidaSoldados),
max_member(VidaUnidad,VidaSoldados),tieneUnidad(Jugador,unidad(X,VidaUnidad,_)).


% Punto 8

leGana(unidad("jinete a caballo",_,_),unidad("jinete a camello",_,_)).
leGana(unidad("jinete a caballo",_,_),unidad(campeon,_,_)).
leGana(unidad("piquero con escudo",_,_),unidad("jinete a caballo",_,_)).
leGana(unidad("piquero con escudo",_,_),unidad("jinete a camello",_,_)).
leGana(unidad("piquero sin escudo",_,_),unidad("jinete a caballo",_,_)).
leGana(unidad("piquero sin escudo",_,_),unidad("jinete a camello",_,_)).
leGana(unidad("piquero con escudo",_,3),unidad("piquero con escudo",_,2)).
leGana(unidad("piquero con escudo",_,2),unidad("piquero con escudo",_,1)).
leGana(unidad("piquero sin escudo",_,3),unidad("piquero sin escudo",_,2)).
leGana(unidad("piquero sin escudo",_,2),unidad("piquero sin escudo",_,1)).
leGana(unidad("piquero con escudo",_,3),unidad("piquero sin escudo",_,_)).
leGana(unidad("piquero con escudo",_,2),unidad("piquero sin escudo",_,_)).
leGana(unidad("piquero con escudo",_,1),unidad("piquero sin escudo",_,_)).
leGana(unidad("piquero sin escudo",_,2),unidad("piquero con escudo",_,1)).
leGana(unidad("piquero sin escudo",_,3),unidad("piquero con escudo",_,1)).
leGana(unidad(campeon,_,_),unidad("piquero con escudo",_,_)).
leGana(unidad(campeon,_,_),unidad("piquero sin escudo",_,_)).
leGana(unidad(campeon,Vida1,_),unidad(campeon,Vida2,_)):-Vida1>Vida2.

% Punto 9

puedeSobrevivir(Jugador):-jugador(Jugador),findall("piquero con escudo",tieneUnidad(Jugador,unidad("piquero con escudo",_,_)),Piqueros),
    findall("piquero sin escudo",tieneUnidad(Jugador,unidad("piquero sin escudo",_,_)),Piqueros2),
    length(Piqueros,Cantidad),length(Piqueros2,Cantidad2),Cantidad>Cantidad2.

% Punto 10

puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=herreria,not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=molino,not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=forja,desarrolloTecnologia(Jugador,herreria),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=fundicion,desarrolloTecnologia(Jugador,forja),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=horno,desarrolloTecnologia(Jugador,fundicion),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=collera,desarrolloTecnologia(Jugador,molino),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=arado,desarrolloTecnologia(Jugador,collera),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=emplumado,desarrolloTecnologia(Jugador,herreria),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=punta,desarrolloTecnologia(Jugador,emplumado),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=laminas,desarrolloTecnologia(Jugador,herreria),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=malla,desarrolloTecnologia(Jugador,laminas),not(desarrolloTecnologia(Jugador,Tecnologia)).
puedeDesarollar(Jugador,Tecnologia):-jugador(Jugador),tecnologias(Tecnologia),Tecnologia=placas,desarrolloTecnologia(Jugador,malla),not(desarrolloTecnologia(Jugador,Tecnologia)).