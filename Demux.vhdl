library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY demux_e IS
PORT(d_in: IN std_logic_vector (7 downto 0); -- input data vector
 sel: IN std_logic_vector (1 downto 0); -- 2 selesction bits
 en: IN std_logic; -- enable flag
 -- output data vectors
 d_out1: OUT std_logic_vector (7 downto 0); 
 d_out2: OUT std_logic_vector (7 downto 0);
 d_out3: OUT std_logic_vector (7 downto 0);
 d_out4: OUT std_logic_vector (7 downto 0));
END ENTITY demux_e;
  
  ARCHITECTURE demux_a of demux_e is
BEGIN
P1:PROCESS(en,d_in,sel) IS BEGIN -- sensitivity list contains all inputs
if en = '1' THEN
case sel is -- all cases of selection bits are dealt with
 when "00" => d_out1 <= d_in;
 when "01" => d_out2 <= d_in;
 when "10" => d_out3 <= d_in;
 when others => d_out4 <= d_in;
 end case; 
 end if;
END PROCESS P1;
END ARCHITECTURE demux_a;
