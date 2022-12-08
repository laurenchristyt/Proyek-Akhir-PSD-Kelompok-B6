library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    Port ( clk : in  STD_LOGIC;
           peoplecounter: in integer;
           mode: in std_logic_vector(1 downto 0);

           sprayed: out std_logic;
           purified: out std_logic_vector(1 downto 0));
end top_level;

architecture Behavioral of top_level is

    component timer_comp is
        generic(freq : integer := 10);
        Port ( clk : in  std_logic;
              output : out  std_logic
        );
    end component;

    component machine_comp is
        port(
            clk: in std_logic;
            timer: in std_logic;
            peoplecounter: in integer;
            mode: in std_logic_vector(1 downto 0);
        
            sprayed: out std_logic;
            purified: out std_logic_vector(1 downto 0)
          );
    end component;

    signal timer_signal : std_logic;
begin

    timer_1 : timer_comp 
    generic map (freq <= 10)
    port map (clk, timer_signal);

    machine_1 : machine_comp
    port map (
        clk,
        timer_signal,
        peoplecounter,
        mode,
        sprayed,
        purified
    );

end Behavioral;