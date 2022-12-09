LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_level IS
    PORT (
        clk : IN STD_LOGIC;
        peoplecounter : IN INTEGER;
        mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        sprayed : OUT std_logic;
        purified : OUT std_logic
    );
END top_level;

ARCHITECTURE Behavioral OF top_level IS

    TYPE states IS (OFF, SPRAY, REFILL, NORMAL, POWERSAVE, BOOST);
    SIGNAL power : STD_LOGIC;
    SIGNAL second : INTEGER RANGE 0 TO 19;
    SIGNAL soap : INTEGER RANGE 0 TO 100;

    COMPONENT timer IS
        GENERIC (freq : INTEGER := 5);
        PORT (
            clk : IN STD_LOGIC;
            output : OUT STD_LOGIC;
            seconds : out integer range 0 to 19
        );
    END COMPONENT;

    COMPONENT machine IS
        PORT (
            clk : IN STD_LOGIC;
            timer : IN STD_LOGIC;
            peoplecounter : IN INTEGER;
            mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

            sprayed : OUT std_logic;
            purified : OUT std_logic
        );
    END COMPONENT;

    SIGNAL timer_signal : STD_LOGIC;
BEGIN

    timer_1 : timer
    GENERIC MAP(5)
    PORT MAP(clk, timer_signal, second);

    machine_1 : machine
    PORT MAP(
        clk,
        timer_signal,
        peoplecounter,
        mode,
        sprayed,
        purified
    );

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF (peoplecounter >= 3) THEN
                power <= '1';
            ELSE
                power <= '0';
            END IF;
        END IF;
    END PROCESS;

END Behavioral;