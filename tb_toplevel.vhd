library ieee;
use ieee.std_logic_1164.all;

entity tb_toplevel is
end entity;

architecture Behavioral of top_level_tb is

    component tb_toplevel is
        port (
            clk : in  STD_LOGIC;
           peoplecounter: in integer;
           mode: in std_logic_vector(1 downto 0);

           sprayed: out std_logic;
           purified: out std_logic_vector(1 downto 0));
        );
    end component;

    signal clk: std_logic := '0';
    signal peoplecounter: integer;
    signal mode: std_logic_vector(1 downto 0);
    signal sprayed: std_logic;
    signal purified: std_logic_vector(1 downto 0);

begin


    -- instantiate the top-level design and connect the input and output signals
    UUT: tb_toplevel
        port map (clk, peoplecounter, mode, sprayed, purified);


    -- generate a clock signal with a 50% duty cycle
    clock_process : process
    begin
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
    end process;

    -- test case 1: peoplecounter = 0, mode = "00"
    test_case_1: process
    begin
        peoplecounter <= 0;
        mode <= "00";

        wait for 30 ns;
        assert sprayed = '0' and purified = "00"
            report "Test case 1 failed"
            severity failure;

        wait;
    end process;

    -- test case 2: peoplecounter = 3, mode = "01"
    test_case_2: process
    begin
        peoplecounter <= 3;
        mode <= "01";

        wait for 30 ns;
        assert sprayed = '0' and purified = "00"
            report "Test case 2 failed"
            severity failure;

        wait;
    end process;

    -- test case 3: peoplecounter = 5, mode = "10"
    test_case_3: process
    begin
        peoplecounter <= 5;
        mode <= "10";

        wait for 30 ns;
        assert sprayed = '1' and purified = "00"
            report "Test case 3 failed"
            severity failure;

        wait;
    end process;

    -- test case 4: peoplecounter = 10, mode = "00"
    test_case_4: process
    begin
        peoplecounter <= 10;
        mode <= "00";

        wait for 30 ns;
        assert sprayed = '1' and purified = "00"
            report "Test case 4 failed"
            severity failure;

        wait;
    end process;

end architecture;