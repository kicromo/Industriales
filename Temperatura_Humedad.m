% Paso 1: Importar los datos del canal Mathworks Weather Station
canalID = '12397'; % Código del canal
readAPIKey = 'DXNZPSHEY3OR4883'; % Tu clave de API

% Conectar con el canal Mathworks Weather Station y obtener datos de los últimos 5 días
tempHumedad = thingSpeakRead(str2double(canalID), 'ReadKey', readAPIKey, 'NumDays', 5);


% Paso 2: Seleccionar los datos de temperatura y humedad
temperatura = tempHumedad(:, 4); % Columna de temperatura en grados Celsius
humedad = tempHumedad(:, 3); % Columna de humedad en porcentaje

% Paso 3: Crear histogramas de temperatura y humedad
figure;

% Histograma de Temperatura
subplot(1, 2, 1);
histogram(temperatura);
title('Histograma de Temperatura');
xlabel('Temperatura (°C)');
ylabel('Frecuencia');

% Histograma de Humedad
subplot(1, 2, 2);
histogram(humedad);
title('Histograma de Humedad');
xlabel('Humedad (%)');
ylabel('Frecuencia');
