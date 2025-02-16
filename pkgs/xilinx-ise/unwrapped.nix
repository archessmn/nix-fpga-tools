{ stdenv, lib, pkgs, requireFile, callPackage }:

let
  # _7zz-patched = callPackage ../7zz { };

in stdenv.mkDerivation rec {
  pname = "xilinx-ise-unwrapped";
  version = "14.7";
  src = requireFile {
    name = "Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip";
    sha256 = "1f6c3302d3c9450ad7c7ce0ddeb3413b451f0468beb1f26cb0b168661df4e18e";
    url = "file:///home/max/Downloads/Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip";
  };
  nativeBuildInputs = [ pkgs.unzip pkgs._7zz ];
  buildCommand = ''
    unzip $src
    tar xvf ova/14.7_VM.ova
    rm ova/14.7_VM.ova
    7zz e 14.7_VM-disk001.vmdk 0.img
    rm 14.7_VM-disk001.vmdk
    7zz x -snld -o$out 0.img opt/Xilinx home/ise
  '';
}
