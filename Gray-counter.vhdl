LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY gray_counter IS
 PORT( En,clock,Reset : IN std_logic;
 Count_out: OUT std_logic_vector (2 downto 0));
END ENTITY gray_counter;
ARCHITECTURE behav OF gray_counter IS
 signal s_out :std_logic_vector (2 downto 0):="000";
 BEGIN
 Count_out <= s_out;
 cs: PROCESS (clock, Reset) is begin
 
 IF Reset = '1' THEN
 s_out <= "000";
 ELSIF (rising_edge(clock)and En = '1') THEN
 
 case s_out is
 when "000" => s_out <= "001";
 when "001" => s_out <= "011";
 when "011" => s_out <= "010";
 when "010" => s_out <= "110"; 
 when "110" => s_out <= "111";
 when "111" => s_out <= "101";
 when "101" => s_out <= "100"; 
 when "100" => s_out <= "000"; 
 when others => s_out <= "000";
 end case;
 
 END IF;
 
 END PROCESS cs;
END ARCHITECTURE behav;
