LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY timer IS
    PORT (
        clk : IN STD_LOGIC;
        freq : IN INTEGER;
        output : OUT STD_LOGIC;
        seconds : out integer range 0 to 19
        );
END timer;

ARCHITECTURE Behavioral OF timer IS

    signal second: integer range 0 to freq -1 ;
         
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if second = freq - 1 then
                second <= 0;
            else
                second <= second + 1;
            end if;
        end if;
    end process;

    output <= '1' when second = freq - 1 else '0';
    seconds <= second;
end Behavioral;