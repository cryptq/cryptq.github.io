library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Fxp3_GNRC is
port (

	x	: in std_logic_vector(15 downto 0);
	y	: out std_logic_vector(31 downto 0);
	rfs	: out std_logic;
	sor	: out std_logic;
	reset	: in std_logic;
	nsi	: in std_logic;
	clk	: in std_logic);

end FIR_Fxp3_GNRC;

architecture aFIR_Fxp3_GNRC of FIR_Fxp3_GNRC is 

signal x_pipe	:	signed(15 downto 0)	:= (others => '0');
signal M_221	:	signed(23 downto 0)	:= (others => '0');
signal M_925	:	signed(25 downto 0)	:= (others => '0');
signal M_2655	:	signed(27 downto 0)	:= (others => '0');
signal M_10137	:	signed(29 downto 0)	:= (others => '0');
signal M_8197	:	signed(29 downto 0)	:= (others => '0');
signal M_16394	:	signed(30 downto 0)	:= (others => '0');


signal tap14_sub221	:	signed(23 downto 0)	:= (others => '0');
signal tap13_add0	:	signed(23 downto 0)	:= (others => '0');
signal tap12_add925	:	signed(26 downto 0)	:= (others => '0');
signal tap11_add0	:	signed(26 downto 0)	:= (others => '0');
signal tap10_sub2655	:	signed(27 downto 0)	:= (others => '0');
signal tap9_add0	:	signed(27 downto 0)	:= (others => '0');
signal tap8_add10137	:	signed(29 downto 0)	:= (others => '0');
signal tap7_sub16394	:	signed(30 downto 0)	:= (others => '0');
signal tap6_add10137	:	signed(31 downto 0)	:= (others => '0');
signal tap5_add0	:	signed(31 downto 0)	:= (others => '0');
signal tap4_sub2655	:	signed(31 downto 0)	:= (others => '0');
signal tap3_add0	:	signed(31 downto 0)	:= (others => '0');
signal tap2_add925	:	signed(31 downto 0)	:= (others => '0');
signal tap1_add0	:	signed(31 downto 0)	:= (others => '0');
signal tap0_sub221	:	signed(31 downto 0)	:= (others => '0');

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

				M_221 <= resize(x_pipe * to_signed( 221, 9 ), 24);
				M_925 <= resize(x_pipe * to_signed( 925, 11 ), 26);
				M_2655 <= resize(x_pipe * to_signed( 2655, 13 ), 28);
				M_10137 <= resize(x_pipe * to_signed( 10137, 15 ), 30);
				M_8197 <= resize(x_pipe * to_signed( 8197, 15 ), 30);

			end if;

		end if;

	end process;

	M_16394 <= shift_left(resize(M_8197, 31), 1);


	SummationChain : process (clk)

	begin

		if (clk'event and clk='1') then

			if (nsi = '1') then

				tap14_sub221 <= resize("0",24) - resize(M_221,24);
				tap13_add0 <= resize(tap14_sub221,24) + resize("0",24);
				tap12_add925 <= resize(tap13_add0,27) + resize(M_925,27);
				tap11_add0 <= resize(tap12_add925,27) + resize("0",27);
				tap10_sub2655 <= resize(tap11_add0,28) - resize(M_2655,28);
				tap9_add0 <= resize(tap10_sub2655,28) + resize("0",28);
				tap8_add10137 <= resize(tap9_add0,30) + resize(M_10137,30);
				tap7_sub16394 <= resize(tap8_add10137,31) - resize(M_16394,31);
				tap6_add10137 <= resize(tap7_sub16394,32) + resize(M_10137,32);
				tap5_add0 <= resize(tap6_add10137,32) + resize("0",32);
				tap4_sub2655 <= resize(tap5_add0,32) - resize(M_2655,32);
				tap3_add0 <= resize(tap4_sub2655,32) + resize("0",32);
				tap2_add925 <= resize(tap3_add0,32) + resize(M_925,32);
				tap1_add0 <= resize(tap2_add925,32) + resize("0",32);
				tap0_sub221 <= resize(tap1_add0,32) - resize(M_221,32);
				y <= std_logic_vector(resize(tap0_sub221,32));

			end if;

		end if;

	end process;

end aFIR_Fxp3_GNRC;

