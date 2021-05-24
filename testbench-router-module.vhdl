LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY Router_T_E IS
END Router_T_E;
Architecture Router_T_A OF Router_T_E IS
 COMPONENT Router_E IS
 PORT (
 rst : IN STD_LOGIC;
 rclock : IN STD_LOGIC;
 wclock : IN STD_LOGIC;
 datai1 : IN STD_LOGIC_VECTOR (7 downto 0);
 wr1 : IN STD_LOGIC;
 datai2 : IN STD_LOGIC_VECTOR (7 downto 0);
 wr2 : IN STD_LOGIC;
 datai3 : IN STD_LOGIC_VECTOR (7 downto 0);
 wr3 : IN STD_LOGIC;
 datai4 : IN STD_LOGIC_VECTOR (7 downto 0);
 wr4 : IN STD_LOGIC; 
 datao1 : OUT STD_LOGIC_VECTOR (7 downto 0);
 datao2 : OUT STD_LOGIC_VECTOR (7 downto 0);
 datao3 : OUT STD_LOGIC_VECTOR (7 downto 0);
 datao4 : OUT STD_LOGIC_VECTOR (7 downto 0));
 END COMPONENT Router_E;
 
 SIGNAL s_rst : STD_LOGIC;
 SIGNAL s_rclock : STD_LOGIC;
 SIGNAL s_wclock : STD_LOGIC;
 SIGNAL s_datai1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_wr1 : STD_LOGIC;
 SIGNAL s_datai2 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_wr2 : STD_LOGIC;
SIGNAL s_datai3 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_wr3 : STD_LOGIC;
 SIGNAL s_datai4 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_wr4 : STD_LOGIC; 
 SIGNAL s_datao1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_datao2 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_datao3 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_datao4 : STD_LOGIC_VECTOR (7 downto 0);
 BEGIN
 
 ROUTER : Router_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_datai1,s_wr1,s_datai2,s_wr2,s_datai3,s_wr3,s_datai4,s_wr4,s_datao1,s_datao2,s_
datao3,s_datao4);
 read_clock: PROCESS IS
 BEGIN 
 s_rclock <= '0' , '1' AFTER 5 ns; 
 WAIT FOR 10 ns;
 END PROCESS read_clock;
 
 write_clock: PROCESS IS
 BEGIN 
 s_wclock <= '0' , '1' AFTER 5 ns; 
 WAIT FOR 10 ns;
 END PROCESS write_clock;
 
 --test case 1 : reset && input data from all input buffers to output buffer 4
 p1: process is begin
 s_rst <= '1';
 WAIT FOR 5 ns;
 s_rst <= '0';
 s_datai1 <= "10000111"; --FIFO41
 s_datai2 <= "10001011"; --FIFO42
 s_datai3 <= "10010011"; --FIFO43
 s_datai4 <= "10100011"; --FIFO44
 s_wr1 <= '1';
s_wr2 <= '1';
 s_wr3 <= '1';
 s_wr4 <= '1';
 WAIT FOR 20 ns;
 s_wr1 <= '0';
 s_wr2 <= '0';
 s_wr3 <= '0';
 s_wr4 <= '0';
 wait FOR 20 ns;
 -- test case 2: input data from all input buffers to output buffer 3
 s_datai1 <= "10000110"; --FIFO31
 s_datai2 <= "10001010"; --FIFO32
 s_datai3 <= "10010010"; --FIFO33
 s_datai4 <= "10100010"; --FIFO34
 s_wr1 <= '1';
 s_wr2 <= '1';
 s_wr3 <= '1';
 s_wr4 <= '1';
 WAIT FOR 20 ns;
 assert s_datao4 <= "10100011" -- value in datai4
 report "Test case 1 error" 
 severity warning;
 s_wr1 <= '0';
 s_wr2 <= '0';
 s_wr3 <= '0';
 s_wr4 <= '0';
 wait FOR 20 ns;
 -- test case 3: input data from all input buffers to output buffer 2
 s_datai1 <= "10000101"; --FIFO21
 s_datai2 <= "10001001"; --FIFO22
 s_datai3 <= "10010001"; --FIFO23
 s_datai4 <= "10100001"; --FIFO24
 s_wr1 <= '1';
 s_wr2 <= '1';
 s_wr3 <= '1';
 s_wr4 <= '1';
 WAIT FOR 20 ns;
 assert s_datao3 <= "10100010" -- value in datai4
 report "Test case 2 error" 
 severity warning;
 s_wr1 <= '0';
 s_wr2 <= '0';
 s_wr3 <= '0';
 s_wr4 <= '0';
 wait FOR 20 ns;
 -- test case 4: input data from all input buffers to output buffer 1
 s_datai1 <= "10000100"; --FIFO11
 s_datai2 <= "10001000"; --FIFO12
 s_datai3 <= "10010000"; --FIFO13
 s_datai4 <= "10100000"; --FIFO14
 s_wr1 <= '1';
 s_wr2 <= '1';
 s_wr3 <= '1';
 s_wr4 <= '1';
 WAIT FOR 20 ns;
 assert s_datao2 <= "10100001" -- value in datails
 report "Test case 3 error" 
 severity warning;
 s_wr1 <= '0';
 s_wr2 <= '0';
 s_wr3 <= '0';
 s_wr4 <= '0';
 wait For 40 ns;
 assert s_datao1 <= "10100000" -- value in datai4
 report "Test case 4 error" 
 severity warning;
 wait FOR 40 ns;
 END PROCESS p1 ;
END Architecture Router_T_A;
