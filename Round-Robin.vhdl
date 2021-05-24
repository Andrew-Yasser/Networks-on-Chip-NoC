Library IEEE;
use IEEE.STD_LOGIC_1164.all;
ENTITY RoundRobin_E is
 Port (clk: IN STD_LOGIC;
 din1: in STD_LOGIC_VECTOR (7 downto 0);
 din2: in STD_LOGIC_VECTOR (7 downto 0);
 din3: in STD_LOGIC_VECTOR (7 downto 0);
 din4: in STD_LOGIC_VECTOR (7 downto 0);
 dout: out STD_LOGIC_VECTOR (7 downto 0)
 );
End entity RoundRobin_E;
Architecture RoundRobin_A of RoundRobin_E IS
 TYPE state_type IS (state_1, state_2, state_3, state_4);
 SIGNAL current_state: state_type;
 SIGNAL next_state: state_type;
Begin
 checkclock: Process(clk)
 Begin 
IF rising_edge(clk) THEN
 current_state <= next_state;
END IF;
END Process checkclock;
updating_the_next_state: Process (current_state, din1, din2, din3, din4)
Begin
case current_state is
when state_1 =>
 next_state <= state_2;
 dout <= din1;
when state_2 =>
 next_state <= state_3;
 dout <= din2;
when state_3 =>
 next_state <= state_4;
 dout <= din3;
when others =>
 next_state <= state_1;
 dout <= din4;
 END case;
 END Process updating_the_next_state;
END RoundRobin_A;
