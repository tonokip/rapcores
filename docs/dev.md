# Developer Docs

## Build Prerequisites

RAPcores targets the FOSS synthesis, place and route, and bitstream tools. Namely yosys and
nextpnr. We are open to support other flows and open source tool chain. However do note
that RAPcores does use some SystemVerilog features supported by Yosys.

We recommend using a relatively recent build of these tools. The ones included in Linux
distros may be out of date.

- [Yosys](https://github.com/YosysHQ/yosys)
- [nextpnr](https://github.com/YosysHQ/nextpnr)
- [icestorm](https://github.com/YosysHQ/icestorm) (ice40 targets)
- [prjtrellis](https://github.com/YosysHQ/prjtrellis) (ECP5 targets)
- [verible](https://github.com/google/verible) (Optional, for linting)
- [SymbiYosys](https://github.com/YosysHQ/SymbiYosys) (Optional, for formal verification)

### Programming Tools

#### ECP5 Devboard

openocd

#### TinyFPGA BX

The TinyFPGA BX uses tinyprog:

`pip3 install --user tinyprog`


## Developing with Nix

RAPcore includes a [shell.nix](../shell.nix) for use with the Nix Package manager.
This makes it easy to get a development environment with all build requirements installed
for you.

To start you will need to install Nix using the instructions [here](https://nixos.wiki/wiki/Nix_Installation_Guide).
They are reproduced here with some recommendations:

```
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh
source $HOME/.nix-profile/etc/profile.d/nix.sh >> ~/.bashrc
```

Then restart the terminal. Next, `cd` to the RAPcore directory. Run `nix-shell`, and some
packages will be installed. Once complete you should be able to run any of the `make` commands
below. This environment includes all the tools to synthesis, place, route, program, and
formally verify the RAPcore project.

## Build Bitstream

`make BOARD=<board>`


## Formal Verification

SymbiYosys is used for formal verification of the code base. It can be run with:

`make formal`

This command will create a `symbiyosys` directory in the project that
contains all the logs and data from the verification. If an assert or
cover fails, a `.vcd` file will be generated that will display the states
of registers and wires that induced the failure. GTKWave is a useful
program for viewing the `.vcd` files.

The config for Symbiyosys is `symbiyosys.sby` in the root of the directory.
The formal verification configuration file is `boards/formal_config.v`.

## Test Benches

`make testbench`

The config for the test bench is `sim.ys` in the root of the directory.

## Formatting

All files should have `none` as the default nettype:

```
`default_nettype none
```

## Linting

`make lint` : Will run Verible to lint the source.

Optionally this VSCode extension is helpful as well:

[https://github.com/mshr-h/vscode-verilog-hdl-support](https://github.com/mshr-h/vscode-verilog-hdl-support)


## Helpful Articles

- https://zipcpu.com/blog/2020/01/13/reuse.html
- https://www.reddit.com/r/yosys/comments/6ulm3m/new_simulation_within_yosys/

## Useful Tools

Google's Verilog formatter and linter:
- https://github.com/google/verible/
