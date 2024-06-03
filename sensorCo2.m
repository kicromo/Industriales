% Definir el Channel ID y las claves de API
readChannelID = 627915; % ID del canal de lectura 627915
writeChannelID = 2539753; % ID del canal de escritura
writeAPIKey = 'DXNZPSHEY3OR4883'; % Clave de API de escritura


%thingSpeakRead(channelID) reads the most recent data from all fields of the
%specified public channel on ThingSpeak.com and returns the data as a numeric type.

% Leer los últimos 30 datos del sensor de CO2 y del sónar
[CO2Data,hora] = thingSpeakRead(readChannelID, 'Fields', 1, 'NumPoints', 30);
[sonarData,~] = thingSpeakRead(readChannelID, 'Fields', 2, 'NumPoints', 30);

% Calcular la media de los últimos 15 valores de CO2
CO2Mean = mean(CO2Data(end-14:end));

tStamps = datetime('now')-minutes(9):minutes(1):datetime('now');

% Definir el valor recomendable y los umbrales de alarma
valorRecomendable = 800; % Puedes ajustar este valor según tus necesidades
maxAlarma = 1;
minAlarma = 0;
medioAlarma = 0.5;


% Determinar el estado de la alarma
if CO2Mean > valorRecomendable
    alarmaCO2 = maxAlarma;
elseif CO2Mean > valorRecomendable/2
    alarmaCO2 = medioAlarma;
else
    alarmaCO2 = minAlarma;
end


% Publicar los datos y el estado de la alarma en el canal de escritura
thingSpeakWrite(writeChannelID,[CO2Data,sonarData],'Fields',[1,2],'TimeStamps',hora,'WriteKey',writeAPIKey);
thingSpeakWrite(writeChannelID,alarmaCO2,'Fields',3,'WriteKey',writeAPIKey);
