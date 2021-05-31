Library ieee;
use ieee.std_logic_1164.all;

Entity flags is port(
Z: in std_logic_vector(15 downto 0);
carry : in std_logic;
flagout : out std_logic_vector(15 downto 0));
end entity;

Architecture model of flags is

begin

flagout(15 downto 3) <= (Others => '0');
flagout(0) <= carry;
flagout(2) <= Z(15); --NEGATIVE
flagout(1) <= '1' WHEN Z = "0000000000000000" --ZERO
		ELSE '0';

end Architecture;


