library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
  port(
    clk: in std_logic;
    timer: in std_logic;
    peoplecounter: in integer;
    mode: in std_logic_vector(1 downto 0);

    sprayed: out std_logic;
    purified: out std_logic_vector(1 downto 0)
  );
end entity;

architecture rtl of state_machine is
  type states is (OFF, SPRAY, REFILL, NORMAL, POWERSAVE, BOOST);
  signal PS,NS: states;
  signal power: std_logic;
  signal soap: integer range 0 to 20;

   function purifier_state(mode: std_logic_vector(1 downto 0)) return states is
        variable purifier: state_type;
    begin
        case mode is
          when "00" => purifier := NORMAL;
          when "01" => purifier := POWERSAVE;
          when "10" => purifier := BOOST;
        end case;
        return purifier;
    end function;

begin

    -- default / startup values
    PS <= OFF;
    sprayed <= '0';
    purified <= "00";
    

    syncproc : process (clk, NS)
    begin
        if rising_edge(clk) then
            PS <= NS;
        end if;
    end process;

    
  -- state transition logic
  combproc : process(clk)
  begin
    if rising_edge(clk) then
        if (peoplecounter > 3) then
            power <= '1';
        else 
            power <= '0';
    end if;

      case PS is
        -- OFF state
        when OFF =>
          if power = '1' then
            NS <= SPRAY;
          end if;

        -- SPRAY state
        when SPRAY =>
          if power = '1' and soap > 0 then
            sprayed <= '1';
            NS <= purifier_state(mode);
          else
            NS <= REFILL;
          end if;

        -- REFILL state
        when REFILL =>
            if (timer /= '0') then
                soap <= soap + 1;
            elsif (timer /= '1') then
                NS <= SPRAY;
            end if;

        -- NORMAL state
        when NORMAL =>
          if power = '1' then
            if timer = '0' then
                purified <= "00";
                NS <= purifier_state(mode);
              else
                NS <= SPRAY;
              end if;
          else
              NS <= OFF;
          end if;

        -- POWERSAVE state
        when POWERSAVE =>
        if power = '1' then
            if timer = '0' then
                purified <= "01";
                NS <= purifier_state(mode);
              else
                NS <= SPRAY;
              end if;
          else
              NS <= OFF;
          end if;

        -- BOOST state
        when BOOST =>
        if power = '1' then
            if timer = '0' then
                purified <= "10";
                NS <= purifier_state(mode);
              else
                NS <= SPRAY;
              end if;
          else
              NS <= OFF;
          end if;

      end case;
    end if;
  end process;
end architecture;