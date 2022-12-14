LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY machine IS
    PORT (
        clk : IN STD_LOGIC;
        timer : IN STD_LOGIC;
        peoplecounter : IN INTEGER;
        mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
        sprayed : OUT STD_LOGIC;
        purified : OUT STD_LOGIC;
        soap_indicator : OUT INTEGER
    );
END ENTITY;

ARCHITECTURE rtl OF machine IS
    TYPE states IS (OFF, SPRAY, REFILL, NORMAL, POWERSAVE, BOOST);
    SIGNAL PS, NS : states;
    SIGNAL power : STD_LOGIC;
    SIGNAL soap : INTEGER := 4;

    FUNCTION purifier_state(mode : STD_LOGIC_VECTOR(1 DOWNTO 0)) RETURN states IS
        VARIABLE purifier : states;
    BEGIN
        CASE mode IS -- input dari user
            WHEN "00" => purifier := NORMAL;
            WHEN "01" => purifier := POWERSAVE;
            WHEN "10" => purifier := BOOST;
            WHEN OTHERS => purifier := NORMAL; -- error handling
        END CASE;
        RETURN purifier;
    END FUNCTION;

BEGIN

    -- default / startup value
    
    soap_indicator <= soap;
    syncproc : PROCESS (clk, NS)
    BEGIN
        IF rising_edge(clk) THEN
            PS <= NS;
        END IF;
    END PROCESS;

    -- state transition logic
    combproc : PROCESS (clk, PS)
    BEGIN
        IF rising_edge(clk) THEN
            IF (peoplecounter >= 3) THEN
                power <= '1';
            ELSE
                power <= '0';
            END IF;

            CASE PS IS
                    -- OFF state
                WHEN OFF =>
                    sprayed <= '0';
                    purified <= '0';
                    IF power = '1' THEN
                        NS <= SPRAY; -- siap-siap
                    END IF;

                    -- SPRAY state
                WHEN SPRAY =>
                    purified <= '0'; -- supaya tidak berbarengan
                    IF power = '1' AND soap = 0 THEN
                        NS <= REFILL; -- sabun habis
                    ELSIF power = '0' THEN
                        NS <= OFF; -- matikan mesin
                    ELSE
                        soap <= soap - 1; -- sabun terpakai
                        sprayed <= '1';
                        NS <= purifier_state(mode); -- siap-siap masuk ke mode purified
                    END IF;

                    --  REFILL state
                WHEN REFILL =>
                    sprayed <= '0';
                    purified <= '0';
                    soap <= soap + 1; -- baik spray / purify tidak ada yang berkerja
                    IF (soap = 10) THEN
                        NS <= SPRAY;
                    ELSE
                        NS <= REFILL;
                    END IF;

                    --  NORMAL state
                WHEN NORMAL =>
                    sprayed <= '0';
                    IF power = '1' THEN
                        IF timer = '0' THEN
                            purified <= '1';
                            NS <= purifier_state(mode); -- bila mau pindah mode
                        ELSE
                            NS <= SPRAY;
                        END IF;
                    ELSE
                        NS <= OFF;
                    END IF;

                    -- POWERSAVE state
                WHEN POWERSAVE =>
                    sprayed <= '0';
                    IF power = '1' THEN
                        IF timer = '0' THEN
                            purified <= '1';
                            NS <= purifier_state(mode);
                        ELSE
                            NS <= SPRAY;
                        END IF;
                    ELSE
                        NS <= OFF;
                    END IF;

                    -- BOOST state
                WHEN BOOST =>
                    sprayed <= '0';
                    IF power = '1' THEN
                        IF timer = '0' THEN
                            purified <= '1';
                            NS <= purifier_state(mode);
                        ELSE
                            NS <= SPRAY;
                        END IF;
                    ELSE
                        NS <= OFF;
                    END IF;

            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE;