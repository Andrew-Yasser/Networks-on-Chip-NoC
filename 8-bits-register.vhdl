library IEEE;
USE IEEE.STD_Logic_1164.all;
ENTITY IB_E is
Port ( Data_in: in std_logic_vector( 7 downto 0);
 Clock_En: in std_logic;
 Clock: in std_logic;
 Reset: in std_logic;
 Data_out: out std_logic_Vector ( 7 downto 0 )
 );
END IB_E;
Architecture IB_A of IB_E is begin
PROCESS (Clock, Reset)
begin
if Reset = '1' then 
 Data_out <= "00000000";
elsif rising_edge(Clock) and Clock_En = '1' then
Data_out <= Data_in;
else
 null;
end if;
end PROCESS ;
end IB_A;
