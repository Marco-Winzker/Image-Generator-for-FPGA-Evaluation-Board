-- sim_street_de10.vhd
--
-- FPGA Vision Remote Lab http://h-brs.de/fpga-vision-lab
-- (c) Marco Winzker, Hochschule Bonn-Rhein-Sieg, 02.05.2019

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity sim_street_de10 is
end sim_street_de10;

architecture sim of sim_street_de10 is

-- signals of testbench
  signal clk_50    : std_logic := '0';
  signal reset_n   : std_logic_vector(0 downto 0);
  signal vs_out    : std_logic;
  signal hs_out    : std_logic;
  signal r_out     : std_logic_vector(3 downto 0);
  signal g_out     : std_logic_vector(3 downto 0);
  signal b_out     : std_logic_vector(3 downto 0);

begin

-- clock generation
  clk_50 <= not clk_50 after 10 ns;

-- reset
  reset_n(0) <= '0', '1' after 95 ns;
  
-- instantiation of design-under-verification
  duv : entity work.street_de10
    port map (max10_clk1_50 => clk_50,
              key           => reset_n,
              vga_vs        => vs_out,
              vga_hs        => hs_out,
              vga_r         => r_out,
              vga_g         => g_out,
              vga_b         => b_out);

-- no handling of output
-- image generation is verified for submodule
-- this testbench is intended for check of connectivity with wave-viewer

  stop_process : process

  begin
  wait until falling_edge(vs_out);
  wait until falling_edge(vs_out);
  wait until falling_edge(vs_out);

  -- stop simulation after third v-sync
    assert false
      report "Simulation completed"
      severity failure;

  end process;

end sim;
