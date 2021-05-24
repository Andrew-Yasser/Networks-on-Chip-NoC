LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY FIFO_E IS
 PORT (
 reset : IN STD_LOGIC;
 rclk : IN STD_LOGIC;
 wclk : IN STD_LOGIC;
 rreq : IN STD_LOGIC;
 wreq : IN STD_LOGIC;
 datain : IN STD_LOGIC_VECTOR (7 downto 0);
 dataout : OUT STD_LOGIC_VECTOR (7 downto 0);
 empty : OUT STD_LOGIC;
 full : OUT STD_LOGIC);
 END FIFO_E;
Architecture FIFO_A OF FIFO_E IS
 
 COMPONENT FIFO_C IS
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
 END COMPONENT FIFO_C;
 
 COMPONENT BlockRam_E is
 Port (d_in: IN STD_LOGIC_VECTOR (7 downto 0);
 ADDRA: IN STD_LOGIC_VECTOR (2 downto 0);
 ADDRB: IN STD_LOGIC_VECTOR (2 downto 0);
 WEA, REA, CLKA, CLKB: IN STD_LOGIC;
 d_out: OUT STD_LOGIC_VECTOR (7 downto 0)
 );
 END COMPONENT BlockRam_E;
 -- SIGNALS SIGNAL
 SIGNAL s_reset : STD_LOGIC;
 SIGNAL s_rclk : STD_LOGIC;
 SIGNAL s_wclk : STD_LOGIC;
 SIGNAL s_rreq : STD_LOGIC;
 SIGNAL s_wreq : STD_LOGIC;
 SIGNAL s_datain : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_dataout : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_empty : STD_LOGIC;
 SIGNAL s_full : STD_LOGIC;
 SIGNAL s_write_valid : STD_LOGIC;
 SIGNAL s_read_valid: STD_LOGIC;
 SIGNAL s_wr_ptr : STD_LOGIC_VECTOR (2 DOWNTO 0);
 SIGNAL s_rd_ptr: STD_LOGIC_VECTOR (2 DOWNTO 0); 
 BEGIN
 -- connections
 --inputs
 s_reset <= reset;
 s_rclk <= rclk;
 s_wclk <= wclk;
 s_rreq <= rreq;
 s_wreq <= wreq;
 s_datain <= datain;
 
 --outputs
 dataout <= s_dataout;
  empty <= s_empty;
 full <= s_full; 
 -------------
fifocont: FIFO_C PORT MAP(s_reset, s_rclk, s_wclk, s_rreq, s_wreq,s_write_valid, 
 s_read_valid, s_wr_ptr, s_rd_ptr, s_empty, s_full);
memoryram: BlockRam_E PORT MAP(s_datain, s_wr_ptr, s_rd_ptr, s_write_valid, s_read_valid, s_wclk, s_rclk, 
s_dataout);
END ARCHITECTURE FIFO_A;
