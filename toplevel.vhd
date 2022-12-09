LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_level IS
    GENERIC (freq : INTEGER := 15);
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
    SIGNAL second : INTEGER RANGE 0 TO freq - 1;
    SIGNAL soap : INTEGER RANGE 0 TO 100;

    COMPONENT timer IS
        PORT (
            clk : IN STD_LOGIC;
            freq : IN INTEGER;
            output : OUT STD_LOGIC;
            seconds : out integer range 0 to freq
        );
    END COMPONENT;

    component machine is
        port(
            clk: in std_logic;
            timer: in std_logic;
            peoplecounter: in integer;
            mode: in std_logic_vector(1 downto 0);
        
            sprayed: out std_logic;
            purified: out std_logic
          );
    end component;

    signal timer_signal : std_logic;
begin

    timer_1 : timer_comp 
    port map (clk, freq, timer_signal);

    machine_1 : machine_comp
    port map (
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