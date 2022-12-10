LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY timer IS
    PORT (
        clk : IN STD_LOGIC;
        freq : IN INTEGER;
        keluaran : OUT STD_LOGIC;
        seconds : OUT INTEGER RANGE 0 TO 30
    );
END timer;

ARCHITECTURE Behavioral OF timer IS

     SIGNAL second : INTEGER RANGE 0 to 30;

BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF second = freq - 1 THEN -- min 1 karena perhitungan mulai dari nol
                second <= 0;
            ELSE
                second <= second + 1;
            END IF;
        END IF;
    END PROCESS;

    keluaran <= '1' WHEN second = freq - 1 ELSE
        '0';
    seconds <= second;
END Behavioral;