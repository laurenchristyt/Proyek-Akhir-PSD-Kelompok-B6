LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_toplevel IS
END tb_toplevel;

ARCHITECTURE test OF tb_toplevel IS
    -- Declare all inputs and outputs
    SIGNAL clk : STD_LOGIC;
    SIGNAL peoplecounter : INTEGER;
    SIGNAL power : STD_LOGIC;
    SIGNAL mode : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL sprayed : STD_LOGIC;
    SIGNAL purified : STD_LOGIC;
    SIGNAL soap : INTEGER;
    SIGNAL timer : STD_LOGIC;

    -- Declare the instance of the top level entity
    COMPONENT top_level
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
    END COMPONENT;

BEGIN

    -- Instantiate the top level entity
    UUT : top_level
    PORT MAP(
        clk,
        peoplecounter,
        mode,
        sprayed,
        purified,
        power,
        soap,
        timer
    );

    -- Clock process
    clock_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 1 ns;
        clk <= '1';
        WAIT FOR 1 ns;
    END PROCESS;

    -- Test bench stimulus
    STIMULUS : PROCESS
    BEGIN
        -- Initialize the inputs
        peoplecounter <= 0;
        mode <= "00";

        -- Wait for 10 clock cycles
        WAIT FOR 50 ns;

        -- Change the inputs
        peoplecounter <= 3;
        mode <= "00"; -- normal

        -- Wait for 10 more clock cycles
        WAIT FOR 50 ns;
        mode <= "10"; -- boost

        WAIT FOR 50 ns;
        mode <= "01"; -- powersave

        -- Change the inputs again
        peoplecounter <= 10;
        mode <= "10";

        WAIT FOR 50 ns;

        -- Check error handling
        peoplecounter <= 2;
        mode <= "10";

        -- Wait for 10 more clock cycles
        WAIT FOR 100 ns;
        peoplecounter <= 2;

        -- Stop the simulation
        WAIT;
    END PROCESS;

END test;