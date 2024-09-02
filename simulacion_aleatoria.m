disp("Bienvenido al simulador de proyectiles volcánicos")
flag = true;

% Inicializa listas para almacenar las trayectorias
trayectorias_x = {};
trayectorias_y = {};

% Crear una figura para la animación de todas las trayectorias
figure;
hold on;

count=input("selecciona la cantidad de simulaciones aleatorias: ");
while count>0
    count=count-1;
    flag1 = true;
    flag2 = true;
    flag3 = true;
    masa = 39160;
    g = 9.81;
    
    while(flag1)
        vi = rand()*200;
        if vi >= 0
            flag1 = false;
        else
            disp("Pon una velocidad positiva")
        end
    end

    while(flag2)
        ang = rand()*90;
        if ang >= 0 && ang <= 180
            flag2 = false;
        else
            disp("Pon un ángulo mayor a 0 y menor a 90")
        end
    end
    
    while(flag3)
        cd = rand()*1.2;
        if cd >= 0 && cd <= 1.2
            flag3 = false;
        else
            disp("El coeficiente de arrastre debe ser de 0 a 1.2")
        end
    end

    f_arrastre = (0.5 * 1.2 * vi^2 * 28.27 * cd) * 10^-5;
    altura = 1900;
    dt = 1;

    vel_x = vi * cosd(ang);
    vel_y = vi * sind(ang);
    pos_x = 0;
    pos_y = altura;
    
    % Inicializa listas para almacenar la trayectoria actual
    trayectoria_x_actual = [];
    trayectoria_y_actual = [];
    
    while pos_y >= 0
        % Actualizar las posiciones
        pos_x = pos_x + vel_x * dt;
        vel_x = vel_x - (f_arrastre * vel_x^2 * dt) / masa;
        
        pos_y = pos_y + vel_y * dt;
        vel_y = vel_y - (masa * g + f_arrastre * vel_y^2) * dt / masa;
        
        % Agregar las posiciones actuales a la trayectoria actual
        trayectoria_x_actual = [trayectoria_x_actual, pos_x];
        trayectoria_y_actual = [trayectoria_y_actual, pos_y];
        
        % Dibujar la trayectoria actual con animación
        plot(trayectoria_x_actual, trayectoria_y_actual);
        xlim([0, 10000]); % Ajusta los límites del gráfico según sea necesario
        ylim([0, 7000]);
        xlabel('Distancia X (m)');
        ylabel('Altura Y (m)');
        title('Tiro Parabólico - Trayectorias Animadas');
        grid on;
        drawnow; % Actualiza la figura en cada iteración
    end
    
    % Almacenar la trayectoria actual en las listas de trayectorias
    trayectorias_x{end + 1} = trayectoria_x_actual;
    trayectorias_y{end + 1} = trayectoria_y_actual;
    
    % Pregunta al usuario si desea simular otra erupción
end