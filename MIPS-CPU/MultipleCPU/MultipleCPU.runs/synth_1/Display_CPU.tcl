# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.cache/wt} [current_project]
set_property parent.project_path {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/ADR.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/ALU.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/ALUoutDR.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/AvoidShake.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/BDR.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/CLK_divider.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/ControlUnit.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/DBDR.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/DBDRSelector.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/DataMEM.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/Display.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/Extend.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/InsMEM.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/PC.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/PC4.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/RegisterFile.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/SegLED.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/Show.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/WriteDataSelector.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/WriteRegSelector.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/main.v}
  {C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/sources_1/new/Display_CPU.v}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/constrs_1/new/MultipleCPU.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/YURAN GU/Desktop/MultipleCPU/MultipleCPU.srcs/constrs_1/new/MultipleCPU.xdc}}]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top Display_CPU -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Display_CPU.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Display_CPU_utilization_synth.rpt -pb Display_CPU_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]