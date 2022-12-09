LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY timer IS
    GENERIC (freq : INTEGER := 5);
    PORT (
        clk : IN STD_LOGIC;
        output : OUT STD_LOGIC;
        seconds : out integer range 0 to 19
        );
END timer;

ARCHITECTURE Behavioral OF timer IS

    SIGNAL tick : INTEGER RANGE 0 TO freq - 1 := 0;
    SIGNAL second : INTEGER RANGE 0 TO 19;

BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF tick = freq - 1 THEN
                tick <= 0;
                IF second = 19 THEN
                    second <= 0;
                ELSE
                    second <= second + 1;
                END IF;
            ELSE
                tick <= tick + 1;
            END IF;
        END IF;
    END PROCESS;

    output <= '1' WHEN second = 19 ELSE
        '0';
        seconds <= second;
END Behavioral;