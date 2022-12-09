LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_toplevel IS
END tb_toplevel;

ARCHITECTURE test OF tb_toplevel IS
    -- Declare all inputs and outputs
    SIGNAL clk : STD_LOGIC;
    SIGNAL peoplecounter : INTEGER;
    SIGNAL mode : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL sprayed : std_logic;
    SIGNAL purified : std_logic;

    -- Declare the instance of the top level entity
    COMPONENT top_level
        GENERIC (freq : INTEGER := 15);
        PORT (
            clk : IN STD_LOGIC;
            peoplecounter : IN INTEGER;
            mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            sprayed : OUT std_logic;
            purified : OUT std_logic
        );
    END COMPONENT;

BEGIN

    -- Instantiate the top level entity
    UUT : top_level
        generic map (
            15
        );
        PORT MAP (
            clk => clk,
            peoplecounter => peoplecounter,
            mode => mode,
            sprayed => sprayed,
            purified => purified
        );

    -- Clock process
    clock_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
    END PROCESS;

    -- Test bench stimulus
    STIMULUS : PROCESS
    BEGIN
        -- Initialize the inputs
        peoplecounter <= 0;
        mode <= "00";

        -- Wait for 10 clock cycles
        WAIT FOR 10 * 10 ns;

        -- Change the inputs
        peoplecounter <= 3;
        mode <= "01";

        -- Wait for 10 more clock cycles
        WAIT FOR 10 * 10 ns;
        mode <= "10"

        -- Change the inputs again
        peoplecounter <= 5;
        mode <= "10";

        -- Wait for 10 more clock cycles
        WAIT FOR 10 * 10 ns;

        -- Stop the simulation
        WAIT;
    END PROCESS;

END test;