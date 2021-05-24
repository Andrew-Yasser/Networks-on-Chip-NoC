LIBRARY IEEE;
USE IEEE.Std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY Router_E IS
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
END Router_E;
Architecture Router_A OF Router_E IS
 
 COMPONENT FIFO_E IS
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
 END COMPONENT FIFO_E;
 
 COMPONENT RoundRobin_E is
 Port (clk: IN STD_LOGIC;
 din1: in STD_LOGIC_VECTOR (7 downto 0);
 din2: in STD_LOGIC_VECTOR (7 downto 0);
 din3: in STD_LOGIC_VECTOR (7 downto 0);
 din4: in STD_LOGIC_VECTOR (7 downto 0);
 dout: out STD_LOGIC_VECTOR (7 downto 0)
 );
End COMPONENT RoundRobin_E;
COMPONENT demux_e IS
PORT(d_in: IN std_logic_vector (7 downto 0); -- input data vector
     sel: IN std_logic_vector (1 downto 0); -- 2 selesction bits
 en: IN std_logic; -- enable flag
 -- output data vectors
 d_out1: OUT std_logic_vector (7 downto 0); 
 d_out2: OUT std_logic_vector (7 downto 0);
 d_out3: OUT std_logic_vector (7 downto 0);
 d_out4: OUT std_logic_vector (7 downto 0));
END COMPONENT demux_e;
COMPONENT IB_E is
Port ( Data_in: in std_logic_vector( 7 downto 0);
 Clock_En: in std_logic;
 Clock: in std_logic;
 Reset: in std_logic;
 Data_out: out std_logic_Vector ( 7 downto 0 )
 );
END COMPONENT IB_E;
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
 ---------/FIFO EMPTY&FULL/---------
 SIGNAL s_FIFO11_empty : STD_LOGIC; 
 SIGNAL s_FIFO11_full : STD_LOGIC;
 SIGNAL s_FIFO12_empty : STD_LOGIC; 
 SIGNAL s_FIFO12_full : STD_LOGIC;
 SIGNAL s_FIFO13_empty : STD_LOGIC; 
 SIGNAL s_FIFO13_full : STD_LOGIC;
 SIGNAL s_FIFO14_empty : STD_LOGIC; 
 SIGNAL s_FIFO14_full : STD_LOGIC;
 ----------------------------------
 SIGNAL s_FIFO21_empty : STD_LOGIC; 
 SIGNAL s_FIFO21_full : STD_LOGIC;
 SIGNAL s_FIFO22_empty : STD_LOGIC; 
 SIGNAL s_FIFO22_full : STD_LOGIC;
 SIGNAL s_FIFO23_empty : STD_LOGIC; 
 SIGNAL s_FIFO23_full : STD_LOGIC;
 SIGNAL s_FIFO24_empty : STD_LOGIC; 
 SIGNAL s_FIFO24_full : STD_LOGIC;
 -----------------------------------
 SIGNAL s_FIFO31_empty : STD_LOGIC;
SIGNAL s_FIFO31_full : STD_LOGIC;
 SIGNAL s_FIFO32_empty : STD_LOGIC; 
 SIGNAL s_FIFO32_full : STD_LOGIC;
 SIGNAL s_FIFO33_empty : STD_LOGIC; 
 SIGNAL s_FIFO33_full : STD_LOGIC;
 SIGNAL s_FIFO34_empty : STD_LOGIC; 
 SIGNAL s_FIFO34_full : STD_LOGIC;
 -----------------------------------
 SIGNAL s_FIFO41_empty : STD_LOGIC; 
 SIGNAL s_FIFO41_full : STD_LOGIC;
 SIGNAL s_FIFO42_empty : STD_LOGIC; 
 SIGNAL s_FIFO42_full : STD_LOGIC;
 SIGNAL s_FIFO43_empty : STD_LOGIC; 
 SIGNAL s_FIFO43_full : STD_LOGIC;
 SIGNAL s_FIFO44_empty : STD_LOGIC; 
 SIGNAL s_FIFO44_full : STD_LOGIC;
 ----------/FIFO request signals/-----------
 SIGNAL s_FIFO11_read_request : STD_LOGIC; 
 SIGNAL s_FIFO11_write_request : STD_LOGIC;
 SIGNAL s_FIFO12_read_request : STD_LOGIC; 
 SIGNAL s_FIFO12_write_request : STD_LOGIC;
 SIGNAL s_FIFO13_read_request : STD_LOGIC; 
 SIGNAL s_FIFO13_write_request : STD_LOGIC;
 SIGNAL s_FIFO14_read_request : STD_LOGIC; 
 SIGNAL s_FIFO14_write_request : STD_LOGIC;
 -------------------------------------------
 SIGNAL s_FIFO21_read_request : STD_LOGIC; 
 SIGNAL s_FIFO21_write_request : STD_LOGIC;
 SIGNAL s_FIFO22_read_request : STD_LOGIC; 
 SIGNAL s_FIFO22_write_request : STD_LOGIC;
 SIGNAL s_FIFO23_read_request : STD_LOGIC; 
 SIGNAL s_FIFO23_write_request : STD_LOGIC;
 SIGNAL s_FIFO24_read_request : STD_LOGIC; 
 SIGNAL s_FIFO24_write_request : STD_LOGIC;
 -------------------------------------------
 SIGNAL s_FIFO31_read_request : STD_LOGIC; 
 SIGNAL s_FIFO31_write_request : STD_LOGIC;
 SIGNAL s_FIFO32_read_request : STD_LOGIC; 
 SIGNAL s_FIFO32_write_request : STD_LOGIC;
 SIGNAL s_FIFO33_read_request : STD_LOGIC; 
 SIGNAL s_FIFO33_write_request : STD_LOGIC;
 SIGNAL s_FIFO34_read_request : STD_LOGIC; 
 SIGNAL s_FIFO34_write_request : STD_LOGIC;
 -------------------------------------------
 SIGNAL s_FIFO41_read_request : STD_LOGIC; 
 SIGNAL s_FIFO41_write_request : STD_LOGIC;
 SIGNAL s_FIFO42_read_request : STD_LOGIC; 
 SIGNAL s_FIFO42_write_request : STD_LOGIC;
 SIGNAL s_FIFO43_read_request : STD_LOGIC; 
 SIGNAL s_FIFO43_write_request : STD_LOGIC;
 SIGNAL s_FIFO44_read_request : STD_LOGIC; 
 SIGNAL s_FIFO44_write_request : STD_LOGIC;
 ----------------/syncronize signals/-----------------
TYPE state_type IS (state_1, state_2, state_3, state_4);
 SIGNAL s_current_state: state_type;
 SIGNAL s_next_state: state_type;
 SIGNAL s_current_read_sync : STD_LOGIC_VECTOR (3 downto 0);
 --------------------/IB Outputs/---------------------
 SIGNAL s_reg1_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_reg2_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_reg3_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_reg4_datao : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/DeMux ENABLE/---------------------
 SIGNAL s_demux1_en : STD_LOGIC;
 SIGNAL s_demux2_en : STD_LOGIC;
 SIGNAL s_demux3_en : STD_LOGIC;
 SIGNAL s_demux4_en : STD_LOGIC;
 --------------------/DeMux Inputs/---------------------
 SIGNAL s_demux1_datai : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux2_datai : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux3_datai : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux4_datai : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/DeMux_1 Outputs/---------------------
 SIGNAL s_demux1_datao1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux1_datao2 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux1_datao3 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux1_datao4 : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/DeMux_2 Outputs/---------------------
 SIGNAL s_demux2_datao1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux2_datao2 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux2_datao3 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux2_datao4 : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/DeMux_3 Outputs/---------------------
 SIGNAL s_demux3_datao1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux3_datao2 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux3_datao3 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux3_datao4 : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/DeMux_1 Outputs/---------------------
 SIGNAL s_demux4_datao1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux4_datao2 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux4_datao3 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_demux4_datao4 : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/FIFO outputs/-----------------------
 SIGNAL s_FIFO11_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO12_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO13_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO14_datao : STD_LOGIC_VECTOR (7 downto 0);
 --------------------------------------------------------
 SIGNAL s_FIFO21_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO22_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO23_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO24_datao : STD_LOGIC_VECTOR (7 downto 0);
 --------------------------------------------------------
 SIGNAL s_FIFO31_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO32_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO33_datao : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL s_FIFO34_datao : STD_LOGIC_VECTOR (7 downto 0);
 --------------------------------------------------------
 SIGNAL s_FIFO41_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO42_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO43_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_FIFO44_datao : STD_LOGIC_VECTOR (7 downto 0);
 ----------------/DeMux selection lines/-----------------
 SIGNAL s_demux1_sel : STD_LOGIC_VECTOR (1 downto 0);
 SIGNAL s_demux2_sel : STD_LOGIC_VECTOR (1 downto 0);
 SIGNAL s_demux3_sel : STD_LOGIC_VECTOR (1 downto 0);
 SIGNAL s_demux4_sel : STD_LOGIC_VECTOR (1 downto 0);
 ----------------------/scheduler output signals/----------------------- 
 SIGNAL s_scheduler1_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_scheduler2_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_scheduler3_datao : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL s_scheduler4_datao : STD_LOGIC_VECTOR (7 downto 0);
 --------------------/FIFO write selctor/---------------------
 SIGNAL s_FIFO1_en : STD_LOGIC_VECTOR (3 downto 0);
 SIGNAL s_FIFO2_en : STD_LOGIC_VECTOR (3 downto 0);
 SIGNAL s_FIFO3_en : STD_LOGIC_VECTOR (3 downto 0);
 SIGNAL s_FIFO4_en : STD_LOGIC_VECTOR (3 downto 0);
 
BEGIN
 ------------/connections/--------------
 s_rst <= rst;
 s_rclock <= rclock;
 s_wclock <= wclock;
 ---------------------------------------
 s_datai1 <= datai1 ;
 s_datai2 <= datai2 ;
 s_datai3 <= datai3 ;
 s_datai4 <= datai4 ;
 ---------------------------------------
 datao1 <= s_datao1;
 datao2 <= s_datao2;
 datao3 <= s_datao3;
 datao4 <= s_datao4;
 ---------------------------------------
 s_wr1 <= wr1;
 s_wr2 <= wr2;
 s_wr3 <= wr3;
 s_wr4 <= wr4;
 ----------------------------------------
 s_demux1_datai <= s_reg1_datao;
 s_demux2_datai <= s_reg2_datao;
 s_demux3_datai <= s_reg3_datao;
 s_demux4_datai <= s_reg4_datao;
 ----------------------------------------
 s_demux1_en <= (s_wr1 and s_wclock);
 s_demux2_en <= (s_wr2 and s_wclock);
 s_demux3_en <= (s_wr3 and s_wclock);
 s_demux4_en <= (s_wr4 and s_wclock); 
 ---------------------------------------
s_datao1 <= s_scheduler1_datao;
 s_datao2 <= s_scheduler2_datao;
 s_datao3 <= s_scheduler3_datao;
 s_datao4 <= s_scheduler4_datao;
 ----------------------------------------
 s_FIFO11_read_request <= (s_current_read_sync(0) and (not s_FIFO11_empty));
 s_FIFO21_read_request <= (s_current_read_sync(0) and (not s_FIFO21_empty));
 s_FIFO31_read_request <= (s_current_read_sync(0) and (not s_FIFO31_empty));
 s_FIFO41_read_request <= (s_current_read_sync(0) and (not s_FIFO41_empty));
 ----------------------------------------
 s_FIFO12_read_request <= (s_current_read_sync(1) and (not s_FIFO12_empty));
 s_FIFO22_read_request <= (s_current_read_sync(1) and (not s_FIFO22_empty));
 s_FIFO32_read_request <= (s_current_read_sync(1) and (not s_FIFO32_empty));
 s_FIFO42_read_request <= (s_current_read_sync(1) and (not s_FIFO42_empty));
 ---------------------------------------- 
 s_FIFO13_read_request <= (s_current_read_sync(2) and (not s_FIFO13_empty));
 s_FIFO23_read_request <= (s_current_read_sync(2) and (not s_FIFO23_empty));
 s_FIFO33_read_request <= (s_current_read_sync(2) and (not s_FIFO33_empty));
 s_FIFO43_read_request <= (s_current_read_sync(2) and (not s_FIFO43_empty));
 ---------------------------------------- 
 s_FIFO14_read_request <= (s_current_read_sync(3) and (not s_FIFO14_empty));
 s_FIFO24_read_request <= (s_current_read_sync(3) and (not s_FIFO24_empty));
 s_FIFO34_read_request <= (s_current_read_sync(3) and (not s_FIFO34_empty));
 s_FIFO44_read_request <= (s_current_read_sync(3) and (not s_FIFO44_empty));
 ---------------------------------------- 
 --/DeMux selection lines Connections/--
 s_demux1_sel(0) <= s_datai1(0);
 s_demux1_sel(1) <= s_datai1(1);
 ----------------------------------------
 s_demux2_sel(0) <= s_datai2(0);
 s_demux2_sel(1) <= s_datai2(1);
 ----------------------------------------
 s_demux3_sel(0) <= s_datai3(0);
 s_demux3_sel(1) <= s_datai3(1);
 ----------------------------------------
 s_demux4_sel(0) <= s_datai4(0);
 s_demux4_sel(1) <= s_datai4(1);
 -------------------------/Input Buffers/--------------------------
 IB_1 : IB_E PORT MAP(s_datai1,s_wr1,s_wclock,s_rst,s_reg1_datao);
 IB_2 : IB_E PORT MAP(s_datai2,s_wr2,s_wclock,s_rst,s_reg2_datao);
 IB_3 : IB_E PORT MAP(s_datai3,s_wr3,s_wclock,s_rst,s_reg3_datao);
 IB_4 : IB_E PORT MAP(s_datai4,s_wr4,s_wclock,s_rst,s_reg4_datao);
 ------------------------------------------------------------/Demux/----------------------------------------------------------
 DeMux_1 : demux_e PORT 
MAP(s_demux1_datai,s_demux1_sel,s_demux1_en,s_demux1_datao1,s_demux1_datao2,s_demux1_datao3,s_de
mux1_datao4);
 DeMux_2 : demux_e PORT 
MAP(s_demux2_datai,s_demux2_sel,s_demux2_en,s_demux2_datao1,s_demux2_datao2,s_demux2_datao3,s_de
mux2_datao4);
 DeMux_3 : demux_e PORT 
MAP(s_demux3_datai,s_demux3_sel,s_demux3_en,s_demux3_datao1,s_demux3_datao2,s_demux3_datao3,s_de
mux3_datao4);
   DeMux_4 : demux_e PORT 
MAP(s_demux4_datai,s_demux4_sel,s_demux4_en,s_demux4_datao1,s_demux4_datao2,s_demux4_datao3,s_de
mux4_datao4);
 ----------------------------------------------------------------------------------------------------------------------------------------------------- 
 FIFO_11 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO11_read_request,s_FIFO11_write_request,s_demux1_datao1,s_FIFO11_datao,
s_FIFO11_empty,s_FIFO11_full);
 FIFO_12 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO12_read_request,s_FIFO12_write_request,s_demux2_datao1,s_FIFO12_datao,
s_FIFO12_empty,s_FIFO12_full);
 FIFO_13 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO13_read_request,s_FIFO13_write_request,s_demux3_datao1,s_FIFO13_datao,
s_FIFO13_empty,s_FIFO13_full);
 FIFO_14 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO14_read_request,s_FIFO14_write_request,s_demux4_datao1,s_FIFO14_datao,
s_FIFO14_empty,s_FIFO14_full);
--------------------------------------------------------------------------------------------------------------------------------------------------------
 FIFO_21 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO21_read_request,s_FIFO21_write_request,s_demux1_datao2,s_FIFO21_datao,
s_FIFO21_empty,s_FIFO21_full);
 FIFO_22 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO22_read_request,s_FIFO22_write_request,s_demux2_datao2,s_FIFO22_datao,
s_FIFO22_empty,s_FIFO22_full);
 FIFO_23 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO23_read_request,s_FIFO23_write_request,s_demux3_datao2,s_FIFO23_datao,
s_FIFO23_empty,s_FIFO23_full);
 FIFO_24 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO24_read_request,s_FIFO24_write_request,s_demux4_datao2,s_FIFO24_datao,
s_FIFO24_empty,s_FIFO24_full);
 -----------------------------------------------------------------------------------------------------------------------------------------------------
 FIFO_31 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO31_read_request,s_FIFO31_write_request,s_demux1_datao3,s_FIFO31_datao,
s_FIFO31_empty,s_FIFO31_full);
 FIFO_32 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO32_read_request,s_FIFO32_write_request,s_demux2_datao3,s_FIFO32_datao,
s_FIFO32_empty,s_FIFO32_full);
 FIFO_33 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO33_read_request,s_FIFO33_write_request,s_demux3_datao3,s_FIFO33_datao,
s_FIFO33_empty,s_FIFO33_full);
 FIFO_34 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO34_read_request,s_FIFO34_write_request,s_demux4_datao3,s_FIFO34_datao,
s_FIFO34_empty,s_FIFO34_full);
 -----------------------------------------------------------------------------------------------------------------------------------------------------
 FIFO_41 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO41_read_request,s_FIFO41_write_request,s_demux1_datao4,s_FIFO41_datao,
s_FIFO41_empty,s_FIFO41_full);
 FIFO_42 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO42_read_request,s_FIFO42_write_request,s_demux2_datao4,s_FIFO42_datao,
s_FIFO42_empty,s_FIFO42_full);
   FIFO_43 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO43_read_request,s_FIFO43_write_request,s_demux3_datao4,s_FIFO43_datao,
s_FIFO43_empty,s_FIFO43_full);
 FIFO_44 : FIFO_E PORT 
MAP(s_rst,s_rclock,s_wclock,s_FIFO44_read_request,s_FIFO44_write_request,s_demux4_datao4,s_FIFO44_datao,
s_FIFO44_empty,s_FIFO44_full);
 ------------------------------------------------------------------/scheduler/-----------------------------------------------------------------
 scheduler_1 : RoundRobin_E PORT 
MAP(s_rclock,s_FIFO11_datao,s_FIFO12_datao,s_FIFO13_datao,s_FIFO14_datao,s_scheduler1_datao);
 scheduler_2 : RoundRobin_E PORT 
MAP(s_rclock,s_FIFO21_datao,s_FIFO22_datao,s_FIFO23_datao,s_FIFO24_datao,s_scheduler2_datao);
 scheduler_3 : RoundRobin_E PORT 
MAP(s_rclock,s_FIFO31_datao,s_FIFO32_datao,s_FIFO33_datao,s_FIFO34_datao,s_scheduler3_datao);
 scheduler_4 : RoundRobin_E PORT 
MAP(s_rclock,s_FIFO41_datao,s_FIFO42_datao,s_FIFO43_datao,s_FIFO44_datao,s_scheduler4_datao);
 ---------------------------------------------------------------/sync read request/------------------------------------------------------------
-
 FIFO_SEL : PROCESS(s_demux1_sel,s_demux2_sel,s_demux3_sel,s_demux4_sel)
 BEGIN
 case s_demux1_sel is
 when "00" => s_FIFO1_en <= "0001";
 when "01" => s_FIFO1_en <= "0010";
 when "10" => s_FIFO1_en <= "0100";
 when "11" => s_FIFO1_en <= "1000"; 
 when others => s_FIFO1_en <= "0000";
 end case;
 case s_demux2_sel is
 when "00" => s_FIFO2_en <= "0001";
 when "01" => s_FIFO2_en <= "0010";
 when "10" => s_FIFO2_en <= "0100";
 when "11" => s_FIFO2_en <= "1000"; 
 when others => s_FIFO2_en <= "0000";
 end case;
 case s_demux3_sel is
 when "00" => s_FIFO3_en <= "0001";
 when "01" => s_FIFO3_en <= "0010";
 when "10" => s_FIFO3_en <= "0100";
 when "11" => s_FIFO3_en <= "1000"; 
 when others => s_FIFO3_en <= "0000";
 end case;
 case s_demux4_sel is
 when "00" => s_FIFO4_en <= "0001";
 when "01" => s_FIFO4_en <= "0010";
 when "10" => s_FIFO4_en <= "0100";
 when "11" => s_FIFO4_en <= "1000"; 
 when others => s_FIFO4_en <= "0000";
 end case;
 END PROCESS FIFO_SEL;
 
 write_sync_demux1 : PROCESS(s_wclock)
 Begin
 if rising_edge(s_wclock) THEN
 s_FIFO11_write_request <= (s_wr1 and (not s_FIFO11_full) and (not s_rst) and s_FIFO1_en(0));
   s_FIFO21_write_request <= (s_wr1 and (not s_FIFO21_full) and (not s_rst) and s_FIFO1_en(1));
 s_FIFO31_write_request <= (s_wr1 and (not s_FIFO31_full) and (not s_rst) and s_FIFO1_en(2));
 s_FIFO41_write_request <= (s_wr1 and (not s_FIFO41_full) and (not s_rst) and s_FIFO1_en(3));
 ----------------------------------------
 s_FIFO12_write_request <= (s_wr2 and (not s_FIFO12_full) and (not s_rst) and s_FIFO2_en(0));
 s_FIFO22_write_request <= (s_wr2 and (not s_FIFO22_full) and (not s_rst) and s_FIFO2_en(1));
 s_FIFO32_write_request <= (s_wr2 and (not s_FIFO32_full) and (not s_rst) and s_FIFO2_en(2));
 s_FIFO42_write_request <= (s_wr2 and (not s_FIFO42_full) and (not s_rst) and s_FIFO2_en(3));
 ----------------------------------------
 s_FIFO13_write_request <= (s_wr3 and (not s_FIFO13_full) and (not s_rst) and s_FIFO3_en(0));
 s_FIFO23_write_request <= (s_wr3 and (not s_FIFO23_full) and (not s_rst) and s_FIFO3_en(1));
 s_FIFO33_write_request <= (s_wr3 and (not s_FIFO33_full) and (not s_rst) and s_FIFO3_en(2));
 s_FIFO43_write_request <= (s_wr3 and (not s_FIFO43_full) and (not s_rst) and s_FIFO3_en(3));
 ----------------------------------------
 s_FIFO14_write_request <= (s_wr4 and (not s_FIFO14_full) and (not s_rst) and s_FIFO4_en(0));
 s_FIFO24_write_request <= (s_wr4 and (not s_FIFO24_full) and (not s_rst) and s_FIFO4_en(1));
 s_FIFO34_write_request <= (s_wr4 and (not s_FIFO34_full) and (not s_rst) and s_FIFO4_en(2));
 s_FIFO44_write_request <= (s_wr4 and (not s_FIFO44_full) and (not s_rst) and s_FIFO4_en(3));
 END if; 
 END PROCESS write_sync_demux1;
 ---------------------------------------------------------------------------------------------------------------------------------------------------
 checkclock: Process(s_rclock,s_rst)
 Begin
 IF s_rst = '1' THEN
 s_current_state <= state_1 ; 
 ELSIF rising_edge(s_rclock) THEN
 s_current_state <= s_next_state;
 END IF;
 END Process checkclock;
 read_sync: Process (s_current_state,s_current_read_sync)
 Begin
 case s_current_state is
 when state_1 =>
 s_next_state <= state_2;
 s_current_read_sync <= "0001";
 when state_2 =>
 s_next_state <= state_3;
 s_current_read_sync <= "0010";
 when state_3 =>
 s_next_state <= state_4;
 s_current_read_sync <= "0100";
 when others =>
 s_next_state <= state_1;
 s_current_read_sync <= "1000";
 END case;
 END Process read_sync;
-------------------------------------------------------------------------------------------------------------------------------------------------------
 
END ARCHITECTURE Router_A;
