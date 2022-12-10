-- B6
-- LAUREN CHRISTY T.		2106707870
-- MICHAEL GUNAWAN		2106731195
-- SYAUQI AULIYA M.		2106707201

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY toplevel IS
    GENERIC (freq : INTEGER := 15);
    PORT (
        clk : IN STD_LOGIC;
        peoplecounter : IN INTEGER;
        mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        sprayed : OUT STD_LOGIC;
        purified : OUT STD_LOGIC;

        power_indicator : OUT STD_LOGIC;
        soap_indicator : OUT INTEGER;
        timer_indicator : OUT STD_LOGIC
    );
END entity;

ARCHITECTURE Behavioral OF toplevel IS

    TYPE states IS (OFF, SPRAY, REFILL, NORMAL, POWERSAVE, BOOST);
    SIGNAL power : STD_LOGIC;
    SIGNAL second : INTEGER RANGE 0 TO 30;
    SIGNAL soap : INTEGER;

    -- bagaikan memanggil fungsi di bahasa C
    COMPONENT timer IS
        PORT (
            clk : IN STD_LOGIC;
            freq : IN INTEGER;
            keluaran : OUT STD_LOGIC;
            seconds : OUT INTEGER RANGE 0 TO 30
        );
    END COMPONENT;

    COMPONENT machine IS
        PORT (
            clk : IN STD_LOGIC;
            timer : IN STD_LOGIC;
            peoplecounter : IN INTEGER;
            mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

            sprayed : OUT STD_LOGIC;
            purified : OUT STD_LOGIC;
            soap_indicator : OUT INTEGER
        );
    END COMPONENT;

    SIGNAL timer_signal : STD_LOGIC;
BEGIN

    soap_indicator <= soap;
    power_indicator <= power;
    timer_indicator <= timer_signal;

    timer_1 : timer
    PORT MAP(clk, freq, timer_signal, second);

    machine_1 : machine
    PORT MAP(
        clk,
        timer_signal,
        peoplecounter,
        mode,
        sprayed,
        purified,
        soap
    );

    -- Process diperlukan agar terlihat di top level status powernya
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