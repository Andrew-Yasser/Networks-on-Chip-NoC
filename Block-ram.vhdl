Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity BlockRam_E is
 Port (d_in: IN STD_LOGIC_VECTOR (7 downto 0);
 ADDRA: IN STD_LOGIC_VECTOR (2 downto 0);
 ADDRB: IN STD_LOGIC_VECTOR (2 downto 0);
 WEA, REA, CLKA, CLKB: IN STD_LOGIC;
 d_out: OUT STD_LOGIC_VECTOR (7 downto 0)
 );
 END entity BlockRam_E;
 
 Architecture block_ram_A of BlockRam_E is
 Signal Reg0: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg1: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg2: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg3: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg4: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg5: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg6: STD_LOGIC_VECTOR (7 downto 0);
 Signal Reg7: STD_LOGIC_VECTOR (7 downto 0);
 -- creating 8 registers
 
 Begin
 write: Process(CLKA) IS BEGIN-- responsible for write
 IF rising_edge (CLKA) THEN -- check that clock A is rising
 IF WEA = '1' THEN -- check that write is enabled
 case ADDRA is
 when "000" =>
 Reg0 <= d_in;
 when "001" =>
 Reg1 <= d_in;
 when "010" =>
 Reg2 <= d_in;
 when "011" =>
 Reg3 <= d_in;
 when "100" =>
 Reg4 <= d_in;
 when "101" =>
 Reg5 <= d_in;
 when "110" =>
 Reg6 <= d_in;
 when others =>
 Reg7 <= d_in;
 end case;
 end if;
 end if; 
 END Process write;
 
 read: Process (CLKB) IS BEGIN -- responsible for read
 IF rising_edge(CLKB) THEN -- check that clock A is rising
 IF REA = '1' THEN -- check that read is enabled
 case ADDRB is 
 when "000" =>
 d_out <= Reg0;
 when "001" =>
 d_out <= Reg1;
 when "010" =>
 d_out <= Reg2;
 when "011" =>
 d_out <= Reg3;
 when "100" =>
 d_out <= Reg4;
 when "101" =>
 d_out <= Reg5;
 when "110" =>
 d_out <= Reg6;
 when others =>
 d_out <= Reg7;
 end case;
 end if;
 end if;
 END Process read;
 END block_ram_A;
