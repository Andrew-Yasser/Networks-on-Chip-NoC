LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY FIFO_C IS
 PORT (
 reset : IN STD_LOGIC;
 rdclk : IN STD_LOGIC;
 wrclk : IN STD_LOGIC;
 r_req : IN STD_LOGIC;
 w_req : IN STD_LOGIC;
 write_valid : OUT STD_LOGIC;
 read_valid : OUT STD_LOGIC;
 wr_ptr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
 rd_ptr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
 empty : OUT STD_LOGIC;
 full : OUT STD_LOGIC);
END FIFO_C;
Architecture FIFO_C_ARC OF FIFO_C IS
 
 COMPONENT gray_to_binary
 PORT (gray_in : in STD_LOGIC_VECTOR (2 downto 0); -- Gray code input
 bin_out : out STD_LOGIC_VECTOR (2 downto 0)); -- Binary code output
 END COMPONENT;
 
 COMPONENT gray_counter
 PORT( En,clock,Reset : IN std_logic;
 Count_out: OUT std_logic_vector (2 downto 0));
 END COMPONENT;
 
 signal R_valid : STD_LOGIC;
 signal W_valid : STD_LOGIC;
 signal R_PTR: STD_LOGIC_VECTOR (2 DOWNTO 0);
 signal W_PTR : STD_LOGIC_VECTOR (2 DOWNTO 0);
 signal gray_in_write : STD_LOGIC_VECTOR (2 DOWNTO 0);
 signal gray_in_read : STD_LOGIC_VECTOR (2 DOWNTO 0);
 BEGIN
 -- gray counter
 gc_read : gray_counter PORT MAP(R_valid,rdclk,reset,gray_in_read);
 
 
 gc_write : gray_counter PORT MAP(W_valid,wrclk,reset,gray_in_write);
 -- gray to binary convertor
 gtb_read : gray_to_binary PORT MAP(gray_in_read,R_PTR);
 gtb_write : gray_to_binary PORT MAP(gray_in_write,W_PTR);
 -- connections
 wr_ptr <= W_PTR ;
 rd_ptr <= R_PTR ;
 write_valid <= W_valid;
 read_valid <= R_valid;
 
 main : process(r_req,w_req,reset) IS
 begin
 IF(reset = '1') THEN
 full <= '0';
 empty <= '1';
 ELSIF(w_req = '1') THEN
 IF( (std_logic_vector( unsigned(W_PTR) + 1) = R_PTR) or (W_PTR = "111" and R_PTR="000")) THEN--
cheacking if the memory is full
 full <= '1';
 empty <= '0';
 W_valid <='0';
 ELSE 
 full <= '0';
 empty <= '0';
 W_valid <='1'; 
 END IF; 
 ELSIF(r_req = '1')THEN
 IF(R_PTR = W_PTR)THEN-- checking if the memory is empty
 empty <= '1';
 full <= '0' ;
 R_valid <='0';
 Else
 full <= '0';
 empty <= '0';
 R_valid <='1'; 
 END IF;
 ELSE
 W_valid <='0';
 R_valid <='0';
 END IF;
 END PROCESS main; 
END ARCHITECTURE FIFO_C_ARC;
