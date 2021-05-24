-- Code for Gray to binary converter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity gray_to_binary is
Port ( gray_in : in STD_LOGIC_VECTOR (2 downto 0); -- Gray code input
 bin_out : out STD_LOGIC_VECTOR (2 downto 0)); -- Binary code output
end gray_to_binary;
architecture Behavioral of gray_to_binary is begin
bin_out(2)<= gray_in(2); -- most significant bit remains the same
bin_out(1)<= gray_in(2) xor gray_in(1); -- b(i) = b(i+1) xor g(i)
bin_out(0)<= gray_in(2) xor gray_in(1) xor gray_in(0); -- repeat until least significant bit
end Behavioral;
