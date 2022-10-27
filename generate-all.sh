sizes=$(seq 100 10 300)

function gen_ppms {
  (
    cat ./gen-greyscale-ppm-via-gimp.scm
    for size in $sizes; do
      echo "(resize-bw $size)"
    done
    echo "(gimp-quit 0)"
  ) | rlwrap gimp -ndisfb -
}

function gen_svgs {
  echo "Compile GHC program"
  ghc -o greyscale-ppm-to-svg ./greyscale-ppm-to-svg.hs

  for size in $sizes; do
    echo "Generate SVG out-$size.svg"
    cat out-$size.ppm | ./greyscale-ppm-to-svg > out-$size.svg
  done
}

function gen_dxfs {
  for size in $sizes; do
    echo "Generate DXF out-$size.dxf"
    cat out-$size.ppm | python3 ./greyscale-ppm-to-dxf.py > out-$size.dxf
  done
}

gen_ppms
gen_svgs
gen_dxfs
