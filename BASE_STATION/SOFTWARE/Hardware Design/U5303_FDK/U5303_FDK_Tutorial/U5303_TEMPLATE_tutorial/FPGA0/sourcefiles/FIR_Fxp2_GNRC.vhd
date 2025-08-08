library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Fxp2_GNRC is
port (

	x	: in std_logic_vector(15 downto 0);
	y	: out std_logic_vector(31 downto 0);
	rfs	: out std_logic;
	sor	: out std_logic;
	reset	: in std_logic;
	nsi	: in std_logic;
	clk	: in std_logic);

end FIR_Fxp2_GNRC;

architecture aFIR_Fxp2_GNRC of FIR_Fxp2_GNRC is 

signal x_pipe	:	signed(15 downto 0)	:= (others => '0');
signal M_37	:	signed(21 downto 0)	:= (others => '0');
signal M_25	:	signed(20 downto 0)	:= (others => '0');
signal M_39	:	signed(21 downto 0)	:= (others => '0');
signal M_35	:	signed(21 downto 0)	:= (others => '0');
signal M_1	:	signed(15 downto 0)	:= (others => '0');
signal M_641	:	signed(25 downto 0)	:= (others => '0');
signal M_1431	:	signed(26 downto 0)	:= (others => '0');
signal M_1311	:	signed(26 downto 0)	:= (others => '0');
signal M_4761	:	signed(28 downto 0)	:= (others => '0');
signal M_13063	:	signed(29 downto 0)	:= (others => '0');
signal M_74	:	signed(22 downto 0)	:= (others => '0');
signal M_280	:	signed(24 downto 0)	:= (others => '0');
signal M_1282	:	signed(26 downto 0)	:= (others => '0');
signal M_2622	:	signed(27 downto 0)	:= (others => '0');
signal M_9522	:	signed(29 downto 0)	:= (others => '0');


signal tap20_sub1	:	signed(16 downto 0)	:= (others => '0');
signal tap19_add74	:	signed(22 downto 0)	:= (others => '0');
signal tap18_add25	:	signed(22 downto 0)	:= (others => '0');
signal tap17_add39	:	signed(23 downto 0)	:= (others => '0');
signal tap16_add280	:	signed(24 downto 0)	:= (others => '0');
signal tap15_add0	:	signed(24 downto 0)	:= (others => '0');
signal tap14_sub1282	:	signed(26 downto 0)	:= (others => '0');
signal tap13_sub1431	:	signed(27 downto 0)	:= (others => '0');
signal tap12_add2622	:	signed(28 downto 0)	:= (others => '0');
signal tap11_add9522	:	signed(29 downto 0)	:= (others => '0');
signal tap10_add13063	:	signed(30 downto 0)	:= (others => '0');
signal tap9_add9522	:	signed(31 downto 0)	:= (others => '0');
signal tap8_add2622	:	signed(31 downto 0)	:= (others => '0');
signal tap7_sub1431	:	signed(31 downto 0)	:= (others => '0');
signal tap6_sub1282	:	signed(31 downto 0)	:= (others => '0');
signal tap5_sub1	:	signed(31 downto 0)	:= (others => '0');
signal tap4_add280	:	signed(31 downto 0)	:= (others => '0');
signal tap3_add39	:	signed(31 downto 0)	:= (others => '0');
signal tap2_add25	:	signed(31 downto 0)	:= (others => '0');
signal tap1_add74	:	signed(31 downto 0)	:= (others => '0');
signal tap0_add0	:	signed(31 downto 0)	:= (others => '0');

signal counter_en : std_logic;
constant LATENCY	: integer  := 4;

begin



    process (clk)
       variable counter    : integer range 0 to LATENCY-1;
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                counter_en     <= '1';
                counter        := 0;
            elsif nsi = '1' and counter_en = '1' then
                if counter = (LATENCY-1) then
                    counter_en <= '0';
                else
                    counter    := counter + 1;
                end if;
            end if;
        end if;
    end process;

    sor <= nsi and (not counter_en);
    rfs <= '0';
	
    InputPipelineStage : process (clk, reset)

	begin

		if (clk'event and clk='1') then

            if (reset = '1') then

                x_pipe <= (others => '0');

			elsif (nsi = '1') then

				x_pipe <= signed(x);

			end if;

		end if;

	end process;

	
	MultiplierBank : process (clk)

	begin

		if (clk'event and clk='1') then

			if (nsi = '1') then

				M_37 <= resize(x_pipe * to_signed( 37, 7 ), 22);
				M_25 <= resize(x_pipe * to_signed( 25, 6 ), 21);
				M_39 <= resize(x_pipe * to_signed( 39, 7 ), 22);
				M_35 <= resize(x_pipe * to_signed( 35, 7 ), 22);
				M_1 <= resize(x_pipe, 16);
				M_641 <= resize(x_pipe * to_signed( 641, 11 ), 26);
				M_1431 <= resize(x_pipe * to_signed( 1431, 12 ), 27);
				M_1311 <= resize(x_pipe * to_signed( 1311, 12 ), 27);
				M_4761 <= resize(x_pipe * to_signed( 4761, 14 ), 29);
				M_13063 <= resize(x_pipe * to_signed( 13063, 15 ), 30);

			end if;

		end if;

	end process;

	M_74 <= shift_left(resize(M_37, 23), 1);
	M_280 <= shift_left(resize(M_35, 25), 3);
	M_1282 <= shift_left(resize(M_641, 27), 1);
	M_2622 <= shift_left(resize(M_1311, 28), 1);
	M_9522 <= shift_left(resize(M_4761, 30), 1);


	SummationChain : process (clk)

	begin

		if (clk'event and clk='1') then

			if (nsi = '1') then

				tap20_sub1 <= resize("0",17) - resize(M_1,17);
				tap19_add74 <= resize(tap20_sub1,23) + resize(M_74,23);
				tap18_add25 <= resize(tap19_add74,23) + resize(M_25,23);
				tap17_add39 <= resize(tap18_add25,24) + resize(M_39,24);
				tap16_add280 <= resize(tap17_add39,25) + resize(M_280,25);
				tap15_add0 <= resize(tap16_add280,25) + resize("0",25);
				tap14_sub1282 <= resize(tap15_add0,27) - resize(M_1282,27);
				tap13_sub1431 <= resize(tap14_sub1282,28) - resize(M_1431,28);
				tap12_add2622 <= resize(tap13_sub1431,29) + resize(M_2622,29);
				tap11_add9522 <= resize(tap12_add2622,30) + resize(M_9522,30);
				tap10_add13063 <= resize(tap11_add9522,31) + resize(M_13063,31);
				tap9_add9522 <= resize(tap10_add13063,32) + resize(M_9522,32);
				tap8_add2622 <= resize(tap9_add9522,32) + resize(M_2622,32);
				tap7_sub1431 <= resize(tap8_add2622,32) - resize(M_1431,32);
				tap6_sub1282 <= resize(tap7_sub1431,32) - resize(M_1282,32);
				tap5_sub1 <= resize(tap6_sub1282,32) - resize(M_1,32);
				tap4_add280 <= resize(tap5_sub1,32) + resize(M_280,32);
				tap3_add39 <= resize(tap4_add280,32) + resize(M_39,32);
				tap2_add25 <= resize(tap3_add39,32) + resize(M_25,32);
				tap1_add74 <= resize(tap2_add25,32) + resize(M_74,32);
				tap0_add0 <= resize(tap1_add74,32) + resize("0",32);
				y <= std_logic_vector(resize(tap0_add0,32));

			end if;

		end if;

	end process;

end aFIR_Fxp2_GNRC;

