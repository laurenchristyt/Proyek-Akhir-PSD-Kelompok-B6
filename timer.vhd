library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer is
    generic(freq : integer := 10);
    Port ( clk : in  STD_LOGIC;
           output : out  STD_LOGIC);
end timer;

architecture Behavioral of timer is

    signal tick:    integer range 0 to freq - 1 := 0;
    signal second: integer range 0 to 20;
         
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if tick = freq - 1 then
                tick <= 0;
                if second = 19 then 
                    second <= 0;
                else
                    second <= second + 1;
                end if;
            else
                tick <= tick + 1;
            end if;
        end if;
    end process;

    output <= '1' when second = 19 else '0';
end Behavioral;