tb ?= TestDcFifo

TB_SRC := ../$(tb).sv
SIM_TCL := ./cfg_xsim.tcl
WAVE_FILE := ./dump.vcd

.PHONY: all wave clean
all : compile elab sim

compile : $(TB_SRC)
	@echo "Vivado compiling..."
	xvlog --sv $(TB_SRC)

elab : compile
	@echo "Vivado elaborating..."
	xelab --debug typical -top $(tb) -s $(tb)_snap

sim : elab
	@echo "Vivado simulating..."
	xsim $(tb)_snap -t $(SIM_TCL) # -gui

wave : $(WAVE_FILE)
	gtkwave $(WAVE_FILE)

clean :
	@echo "Cleaning up generated files..."
	rm -rf dump.vcd .Xil/ xsim.dir/ xelab* xsim* xvlog* $(tb)_snap*

