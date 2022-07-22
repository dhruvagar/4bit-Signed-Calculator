----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:55:54 05/14/2021 
-- Design Name: 
-- Module Name:    SignCalculator4bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignCalculator4bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC;
           D : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           rst : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end SignCalculator4bit;

architecture Behavioral of SignCalculator4bit is

component FULL_ADDER_VAR 
	 Generic (n: integer := 7);
    Port ( A : in  std_logic_VECTOR (n downto 0);
           B : in  std_logic_VECTOR (n downto 0);
           Cin : in  std_logic;
           S : out  std_logic_VECTOR (n downto 0);
           Cout : out  std_logic);
end component;

component FULL_SUBTRACTER_VAR 
	 Generic (n: integer := 7);
    Port ( A : in  STD_LOGIC_VECTOR (n downto 0);
           B : in  STD_LOGIC_VECTOR (n downto 0);
           Bin : in  STD_LOGIC;
           D : out  STD_LOGIC_VECTOR (n downto 0);
           Bout : out  STD_LOGIC);
end component;

component MULTIPLIER_VAR 
	 Generic (n: integer := 7);
    Port ( A : in  STD_LOGIC_VECTOR (n downto 0);
           B : in  STD_LOGIC_VECTOR (n downto 0);
           M : out  STD_LOGIC_VECTOR (2*n+1 downto 0));
end component;

component MUX4_1_8bit 
	 Port ( A0 : in  std_logic_VECTOR (7 downto 0);
           A1 : in  std_logic_VECTOR (7 downto 0);
           A2 : in  std_logic_VECTOR (7 downto 0);
           A3 : in  std_logic_VECTOR (7 downto 0);
           S : in  std_logic_VECTOR (1 downto 0);
           X : out std_logic_VECTOR (7 downto 0));
end component;

component TwosComplement8Bit
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal APtemp,BPtemp,ANtemp,BNtemp,Atemp,Btemp,OAtemp,OStemp : std_logic_VECTOR (7 downto 0):=(others=>'0');
signal OMtemp : std_logic_VECTOR (15 downto 0):=(others=>'0');
signal E : std_logic;
begin

X0: TwosComplement8Bit PORT MAP (APtemp,ANtemp);
X1: TwosComplement8Bit PORT MAP (BPtemp,BNtemp);
X2: FULL_ADDER_VAR GENERIC MAP(7) PORT MAP(Atemp,Btemp,'0',OAtemp,E);
X3: FULL_SUBTRACTER_VAR GENERIC MAP(7) PORT MAP(Atemp,Btemp,'0',OStemp,E);
X4: MULTIPLIER_VAR GENERIC MAP(7) PORT MAP(Atemp,Btemp,OMtemp);
X5: MUX4_1_8bit PORT MAP(OAtemp,OStemp,OMtemp(7 downto 0),"00000000",S(1 downto 0),OUTPUT);


process(APtemp,BPtemp,ANtemp,BNtemp,Atemp,Btemp,Atemp,OAtemp,OStemp,OMtemp,S,A,B,C,D,rst)
begin

if rst='1' then
Atemp <= (others=>'0');
Btemp <= (others=>'0');

elsif (rst='0') then

APtemp <= "0000" & A;
BPtemp <= "0000" & B;

case C is
when '0' =>Atemp <= APtemp;
when '1' =>Atemp <= ANtemp;
when others => Atemp <= "XXXXXXXX";
end case;

case D is
when '0' =>Btemp <= BPtemp;
when '1' =>Btemp <= BNtemp;
when others => Atemp <= "XXXXXXXX";
end case;


end if;
end process;

end Behavioral;

